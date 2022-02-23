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
                searchList = queryExecute(
                    "SELECT br_bus_routes.id as route_id, bus_id, bus_name, bus_type, no_of_seats, departure_time, arrival_time, price 
                    FROM br_bus_routes INNER JOIN br_buses ON br_bus_routes.bus_id = br_buses.id 
                    WHERE route_from = :from_id AND route_to = :to_id AND br_bus_routes.available_today = :today_available;", 
                    {
                        from_id: { cfsqltype: "cf_sql_integer", value: loc_f },
                        to_id: { cfsqltype: "cf_sql_integer", value: loc_t },
                        today_available: { cfsqltype: "cf_sql_integer", value: 1 }
                    }
                ); 
            }
            else{
                searchList = queryExecute(
                    "SELECT br_bus_routes.id as route_id, bus_id, bus_name, bus_type, no_of_seats, departure_time, arrival_time, price 
                    FROM br_bus_routes INNER JOIN br_buses ON br_bus_routes.bus_id = br_buses.id 
                    WHERE route_from = :from_id AND route_to = :to_id AND FIND_IN_SET(:dt, bus_days);", 
                    {
                        from_id: { cfsqltype: "cf_sql_integer", value: loc_f },
                        to_id: { cfsqltype: "cf_sql_integer", value: loc_t },
                        dt: { cfsqltype: "cf_sql_varchar", value: date1 },
                        db: { cfsqltype: "cf_sql_integer", value: 1 }
                    }
                );
            }
            recordCount = myQuery.recordCount;            
            if(recordCount == 0){
                writeOutput('
                    <div class="bus-details">
                        <p id="bus-message">Sorry result not found</p>
                    </div>
                ');
            }
            else{
                data.status 	= 	'ok';
                list = arrayNew(1);                
                for(row in myQuery){
                    myQuery.currentrow = arrayAppend(list, row);
                }
                data.list = list;
                data.selectedDate.year	= DateFormat(date,"y");
                data.selectedDate.month	= DateFormat(date,"m");
                data.selectedDate.day	= DateFormat(date,"d");
                
                for(bus in data.list){
                    writeOutput('
                        <form action="busSeats.cfm" method="post">
                            <input type="hidden" name="busId" value="#bus.bus_id#">
                            <input type="hidden" name="totalseats" value="#bus.no_of_seats#">
                            <input type="hidden" name="price" value="#bus.price#">
                            <input type="hidden" name="routeId" value="#bus.route_id#">
                            <input type="hidden" name="year" value="#data.selectedDate.year#">
                            <input type="hidden" name="month" value="#data.selectedDate.month#">
                            <input type="hidden" name="day" value="#data.selectedDate.day#">
                            <button class="btn bus-book">
                                <div class="bus-details">
                                    <p id="go-time">#timeformat(bus.arrival_time)#</p>
                                    <p id="bus-route">#bus.bus_name#</p>
                                    <p id="bus-name">#bus.bus_type#</p>
                                    <p id="fare">Fare : #bus.price#</p>
                                    <p id="reach-time">#timeformat(bus.departure_time)#</p>
                                </div>
                            </button>
                        </form>
                    ');
                }
            }            
        }
        catch(Exception e){
            data.status 	= 	'error';
            data.message	=	e.message;
            writeOutput(serializeJSON(data));
        }
    }
}