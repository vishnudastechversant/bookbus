component { 
    remote function setBooking(required numeric busId,required string seats,required numeric fare,required string date) { 
        if((not isdefined("form.csrfToken")) OR (not CSRFVerifyToken(form.csrfToken))){
            writeOutput('<center><h1>An error occurred</h1>
                        <p>Please Contact the developer</p>
                        <p>Error details: Invalid Request</p></center>');
            exit;
        }
        if(seats == ""){
            writeOutput('<center><h1>An error occurred</h1>
                        <p>Please select your seats</p>
                        <p>Error details: No seat Selected</p></center>');
            exit;
        }
        if(!isNumeric(busId) || busId < 1 ){
            writeOutput('<center><h1>An error occurred</h1>
                        <p>Please select your seats</p>
                        <p>Error details: No seat Selected</p></center>');
            exit;
        }
        seatsFromQuery = listToArray(bookedSeats(busId,date));
        seatList = listToArray(seats);
        
        seatAlreadyTaken = seatList.filter(function(seat){
            return seatsFromQuery.contains(seat);
        });
        if(arrayLen(seatAlreadyTaken) GTE 1){
            writeOutput('<center><h1>An error occurred</h1>
                        <p>Seats you choose was already booked. Please select your seats again</p>
                        <p>Error details: Seat Selected Was Already Booked</p></center>');
            exit;
        }
        writeDump(seatAlreadyTaken);
        try{
            cfquery( name="setBooking", result="bookingResults" ){
                writeOutput("insert into br_bookings (customer, bus_id, seat_no, fare, paid, status, booked_on) values ");
                for (i = 1; i <= arrayLen(seatList); i++){
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
                    cfqueryparam( cfsqltype="cf_sql_integer", value=1 );
                    writeOutput(",");
                    cfqueryparam( cfsqltype="cf_sql_integer", value=1 );
                    writeOutput(",");
                    cfqueryparam( cfsqltype="cf_sql_timestamp", value=LSParseDateTime(date,"English (UK)"));
                    writeOutput(")");
                }
            }
        } catch (any e) {
            writeOutput('<center><h1>An error occurred</h1>
                        <p>Please Contact the developer</p>
                        <p>Error details: #e.message#</p></center>');
            return;
        }
        location("../pages/user/bookingConfirmed.cfm", "false");
    }

    remote function getBookedSeats(required numeric busId, required string date){
        bookedSeats = bookedSeats(busId,date);
        return bookedSeats;
    }

    private function bookedSeats(required numeric busId, required string date){
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
            writeOutput('<center><h1>An error occurred</h1>
                        <p>Please Contact the developer</p>
                        <p>Error details: #e.message#</p></center>');
            return;
        }

    }
}