component { 
    remote function setBooking(required numeric busId, required string seats, required numeric fare, required numeric routeId, required string date) { 
        if((not isdefined("form.csrfToken")) OR (not CSRFVerifyToken(form.csrfToken))){
            session.alert_status = 'error';
            session.alert_message = 'Invalid Request';
            location("../pages/user/index.cfm", "false");
        }
        if(seats == ""){
            session.alert_status = 'error';
            session.alert_message = 'No seat Selected';
            location("../pages/user/index.cfm", "false");
            abort;
        }
        if(!isNumeric(busId) || busId < 1 ){
            session.alert_status = 'error';
            session.alert_message = 'No Bus Selected';
            location("../pages/user/index.cfm", "false");
        }
        seatsFromQuery = listToArray(getBookedSeats(busId,date));
        seatList = listToArray(seats);
        
        seatAlreadyTaken = seatList.filter(function(seat){
            return seatsFromQuery.contains(seat);
        });
        if(arrayLen(seatAlreadyTaken) GTE 1){
            session.alert_status = 'error';
            session.alert_message = 'Seats you choose was already booked. Please select your seats again';
            location("../pages/user/index.cfm", "false");
        }
        
        try{
                cfquery( name="setBooking", result="bookingResults" )
                    {
                        writeOutput("insert into br_bookings (customer, bus_id, seat_no, fare, route_id, paid, status, booked_on) values ");
                        for (i = 1; i <= arrayLen(seatList); i++)
                            {
                                if(i> 1 ) { writeOutput(",");}
                                writeOutput("(");
                                cfqueryparam( cfsqltype="cf_sql_integer", value=session.id );
                                writeOutput(",");
                                cfqueryparam( cfsqltype="cf_sql_integer", value=busId );
                                writeOutput(",");
                                cfqueryparam( cfsqltype="cf_sql_integer", value=seatList[i] );
                                writeOutput(",");
                                cfqueryparam( cfsqltype="cf_sql_integer", value=fare );
                                writeOutput(",");
                                cfqueryparam( cfsqltype="cf_sql_integer", value=routeId );
                                writeOutput(",");
                                cfqueryparam( cfsqltype="cf_sql_integer", value=1 );
                                writeOutput(",");
                                cfqueryparam( cfsqltype="cf_sql_integer", value=1 );
                                writeOutput(",");
                                cfqueryparam( cfsqltype="cf_sql_timestamp", value=LSParseDateTime(date,"English (UK)"));
                                writeOutput(")");
                            }
                    }

                    /*Scheduler Code*/
                    route_details = getRouteDetails(routeId);
                    if(arrayLen(route_details) == 1)
                        {
                            arrival_time = route_details[1].arrival_time;
                            booking_Date = date;

                            cfschedule(
                                        action    = "update", 
                                        task      = "BookingReminder#session.id#",
                                        operation = "HTTPRequest",
                                        startDate = date,
                                        startTime = arrival_time,
                                        url       = 'http://127.0.0.1:8500/bookbus/cfc/scheduler.cfc?method=bookingReminder&BookingID=#bookingResults.generatedKey#',
                                        interval  = 'once'
                                    );
                        }
            }
        catch (any e) 
            {
                session.alert_status = 'error';
                session.alert_message = '#e.message#';
                location("../pages/user/index.cfm", "false");
            }
        
        location("../pages/user/bookingConfirmed.cfm", "false");
    }

    public function getRouteDetails(routeid){
        try{

            result = queryExecute("SELECT * FROM br_bus_routes WHERE id = :routeid",
                                    {
                                        routeid: { cfsqltype: "cf_sql_integer", value: routeid }
                                    },
                                    {
                                        returntype = "array"
                                    });
            return result;                        
        }
        catch(any e){
            return 'error';
        }
    }

    public function getBookedSeats(required numeric busId, required string date){
        try{
            fetchBookedSeats = queryExecute(
                "SELECT bs.seat_no as seats FROM br_bookings as bs
                WHERE bus_id = :bid AND booked_on >= :dateStart AND booked_on <= :dateEnd;", 
                {
                    bid: { cfsqltype: "cf_sql_integer", value: busId },
                    dateStart: { cfsqltype: "cf_sql_timestamp", value: LSParseDateTime("#date# 00:00:00","English (UK)") },
                    dateEnd: { cfsqltype: "cf_sql_timestamp", value: LSParseDateTime("#date# 23:59:59","English (UK)") }
                }
            );
            seats_taken = "#fetchBookedSeats.seats#";
            cfloop(query = fetchBookedSeats, startRow = "2" ) {
                 seats_taken="#seats_taken#,#seats#"
            }
            
            return seats_taken; 
        }
        catch (any e) {
            session.alert_status = 'error';
            session.alert_message = '#e.message#';
            location("../pages/user/index.cfm", "false");
        }

    }
}