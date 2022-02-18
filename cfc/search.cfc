component { 
    remote function locFunction(required string loc,sec) { 
        cfquery( name="loclist",result="xResult" ) { 
            writeOutput("SELECT id,city FROM br_city
            WHERE city LIKE "); cfqueryparam( cfsqltype="cf_sql_varchar", VALUE=loc&'%');
        }
       //return loclist;
        cfoutput(QUERY="loclist" ) {
                writeOutput("<li class=""list-group-item"" onclick=""listHandle('#id#','#city#','#sec#')"">#city#</li>"
            );
        }
    }

    remote function Listfunction(required string loc_f,loc_t,date) { 

        data = structNew();
        date1  = DateFormat(date,"e");
        today  = DateFormat(Now(),"yyy-mm-dd");
        list   ="";

        try {

            if (today == date ) {
                myQuery = queryExecute(
                    "SELECT * FROM br_bus_routes 
                    WHERE route_from = :fid AND route_to = :tid AND available_today = :f;", 
                    {
                        fid: { cfsqltype: "cf_sql_integer", value: loc_f },
                        tid: { cfsqltype: "cf_sql_integer", value: loc_t },
                        f: { cfsqltype: "cf_sql_integer", value: 1 }
                    }
                ); 
            }
            else{
                myQuery = queryExecute(
                    "SELECT * FROM br_bus_routes 
                    WHERE route_from = :fid AND route_to = :tid AND FIND_IN_SET(:dt, bus_days);", 
                    {
                        fid: { cfsqltype: "cf_sql_integer", value: loc_f },
                        tid: { cfsqltype: "cf_sql_integer", value: loc_t },
                        dt: { cfsqltype: "cf_sql_varchar", value: date1 },
                        db: { cfsqltype: "cf_sql_integer", value: 1 }
                    }
                );
            }
            
            data.status 	= 	'ok';
            data.bus_id	    =	myQuery.bus_id;
            cfoutput( query="myQuery" ) {

                myQuery1 = queryExecute(
                    "SELECT * FROM br_buses 
                    WHERE id = :bid;", 
                    {
                        bid: { cfsqltype: "cf_sql_integer", value: myQuery.bus_id }
                    }
                );
                bus_name     =  myQuery1.bus_name;
                totalseats   =  myQuery1.no_of_seats;
                list         =  writeOutput("#myQuery.id#,#bus_name#,#myQuery.departure_time#,#myQuery.arrival_time#,#myQuery.price#,#totalseats#<br>");
            }
                data.status 	        = 	'ok';
                data.list	            =	list;
                data.selectedDate.year	= DateFormat(date,"y");
                data.selectedDate.month	= DateFormat(date,"m");
                data.selectedDate.day	= DateFormat(date,"d");
                writeOutput(serializeJSON(data));
        }
        catch(Exception e){
            data.status 	= 	'error';
            data.message	=	e.message;
            writeOutput(serializeJSON(data));
        }
    }
}