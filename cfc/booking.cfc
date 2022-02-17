component { 
    remote function setBooking(required numeric busId,required string seats,required numeric fare) { 
        seatList = listToArray(seats);
        cfquery( name="setBooking", result="bookingResults" ){
            writeOutput("insert into br_bookings (customer, bus_id, seat_no, fare, paid, status) values ");
            for (i = 1; i <= arrayLen(seatList); i++){
                if(i> 1 ) { writeOutput(",");}
                writeOutput("(");
                cfqueryparam( cfsqltype="cf_sql_integer", value=3 );
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


    }
}