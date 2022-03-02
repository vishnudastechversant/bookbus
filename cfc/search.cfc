component { 
    remote function locFunction(required string loc,sec) returnFormat="JSON" {
        try {
            loclist = queryExecute(
                "SELECT id, city FROM br_city 
                 WHERE city Like :location;", 
                {
                    location: { cfsqltype: "cf_sql_varchar", value: loc&'%' }
                }
            ); 
            return loclist;
        }
        catch(Exception e){
            data.status 	= 	'error';
            data.message	=	e.message;
        }
    }

    remote function Listfunction(required string loc_f,loc_t,date) output=false returnFormat="json" { 
        data   = structNew();
        date1  = DateFormat(date,"e");
        today  = DateFormat(Now(),"yyy-mm-dd");
        list   ="";

        try {
            if (today == date ) {
                searchList = queryExecute(
                    "SELECT br_bus_routes.id as route_id, bus_id, bus_name, bus_type, no_of_seats, departure_time, arrival_time, price 
                    FROM br_bus_routes INNER JOIN br_buses ON br_bus_routes.bus_id = br_buses.id 
                    WHERE route_from = :location_from AND route_to = :location_to AND br_bus_routes.available_today = :today_available;", 
                    {
                        location_from: { cfsqltype: "cf_sql_integer", value: loc_f },
                        location_to: { cfsqltype: "cf_sql_integer", value: loc_t },
                        today_available: { cfsqltype: "cf_sql_integer", value: 1 }
                    }
                ); 
            }
            else{
                searchList = queryExecute(
                    "SELECT br_bus_routes.id as route_id, bus_id, bus_name, bus_type, no_of_seats, departure_time, arrival_time, price 
                    FROM br_bus_routes INNER JOIN br_buses ON br_bus_routes.bus_id = br_buses.id 
                    WHERE route_from = :location_from AND route_to = :location_to AND FIND_IN_SET(:dt, bus_days) 
                    OR route_from = :location_from AND route_to = :location_to AND daily_bus = :dailybus;", 
                    {
                        location_from: { cfsqltype: "cf_sql_integer", value: loc_f },
                        location_to: { cfsqltype: "cf_sql_integer", value: loc_t },
                        dt: { cfsqltype: "cf_sql_varchar", value: date1 },
                        db: { cfsqltype: "cf_sql_integer", value: 1 },
                        dailybus: { cfsqltype: "cf_sql_integer", value: 1 }
                    }
                );
            }
            recordCount = searchList.recordCount;            
            if(recordCount == 0){
                data.status = 'error';
                data.message = 'Sorry result not found';

                return data;
            }
            else{
                data.status 	= 	'ok';
                list = arrayNew(1);                
                for(row in searchList){
                    searchList.currentrow = arrayAppend(list, row);
                }
                data.list = list;
                data.selectedDate.year	= DateFormat(date,"y");
                data.selectedDate.month	= DateFormat(date,"m");
                data.selectedDate.day	= DateFormat(date,"d");

                return data;
            }            
        }
        catch(Exception e){
            data.status 	= 	'error';
            data.message	=	e.message;
            return data;
        }
    }
}