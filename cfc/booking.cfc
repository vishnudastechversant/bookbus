component { 
    remote function setBooking(required numeric busId,required string seats,required numeric fare) { 
        seatList = listToArray(seats);
        try{
            cfquery( name="setBooking", result="bookingResults" ){
                writeOutput("insert into br_bookings (customer, bus_id, seat_no, fare, paid, status) values ");
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
}