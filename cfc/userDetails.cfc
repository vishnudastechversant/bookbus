component { 
    public function history(recordperpage,pageno=1) output=true { 

        pageno        = (pageno-1) * recordperpage;
        book_list = queryExecute(
            "SELECT count(booktable.id) as bookcount,GROUP_CONCAT(booktable.seat_no)as seats,bus_name,
            bus_type,SUM(booktable.fare) as fare,booktable.booked_on as booked_on ,departure_time,booktable.bus_id as bus_id,booktable.route_id as routeId,
            arrival_time,route_from,route_to,routef.city as cityfrom,routet.city as cityto FROM br_buses 
            INNER JOIN br_bookings as booktable ON br_buses.id = booktable.bus_id INNER JOIN br_bus_routes r ON r.id = booktable.route_id
            INNER JOIN br_city as routef ON r.route_from  = routef.id  INNER JOIN br_city as routet ON r.route_to  = routet.id
            WHERE customer = :customer_id AND booked_on < :booked_date GROUP BY booked_on,bus_id,routeId ORDER BY booked_on DESC LIMIT :startrecord, :recordperpag;", 
            {
                customer_id: { cfsqltype: "cf_sql_integer", value: session.id},
                booked_date: { cfsqltype: "cf_sql_timestamp", value: DateFormat(Now(),"yyy-mm-dd H:mm:ss")},
                recordperpag: { cfsqltype: "cf_sql_integer", value: recordperpage},
                startrecord: { cfsqltype: "cf_sql_integer", value: pageno}
            }
        );
    
        return book_list;
    }

    public function historyCount() output=true { 
        history_count = queryExecute(
            "SELECT id FROM br_bookings WHERE customer = :customer_id AND booked_on < :booked_date GROUP BY booked_on,bus_id,route_id;", 
            {
                customer_id: { cfsqltype: "cf_sql_integer", value: session.id},
                booked_date: { cfsqltype: "cf_sql_timestamp", value: DateFormat(Now(),"yyy-mm-dd H:mm:ss")}
            }
        );
        return history_count.RecordCount;
    }

    public function upcomming(recordperpage,pageno=1) output=true { 
        pageno        = (pageno-1) * recordperpage;
        book_list = queryExecute(
            "SELECT count(booktable.id) as bookcount,GROUP_CONCAT(booktable.seat_no)as seats,bus_name,
            bus_type,SUM(booktable.fare) as fare,booktable.booked_on as booked_on ,departure_time,booktable.bus_id as bus_id,booktable.route_id as routeId,
            arrival_time,route_from,route_to,routef.city as cityfrom,routet.city as cityto FROM br_buses 
            INNER JOIN br_bookings as booktable ON br_buses.id = booktable.bus_id INNER JOIN br_bus_routes r ON r.id = booktable.route_id
            INNER JOIN br_city as routef ON r.route_from  = routef.id  INNER JOIN br_city as routet ON r.route_to  = routet.id
            WHERE customer = :customer_id AND booked_on > :booked_date GROUP BY booked_on,bus_id,routeId ORDER BY booked_on DESC LIMIT :startrecord, :recordperpag;", 
            {
                customer_id: { cfsqltype: "cf_sql_integer", value: session.id},
                booked_date: { cfsqltype: "cf_sql_timestamp", value: DateFormat(Now(),"yyy-mm-dd H:mm:ss")},
                recordperpag: { cfsqltype: "cf_sql_integer", value: recordperpage},
                startrecord: { cfsqltype: "cf_sql_integer", value: pageno}
            }
        );
        return book_list;
    }

    public function upcommingCount() output=true { 
        history_count = queryExecute(
            "SELECT id FROM br_bookings WHERE customer = :customer_id AND booked_on > :booked_date GROUP BY booked_on,bus_id,route_id;", 
            {
                customer_id: { cfsqltype: "cf_sql_integer", value: session.id},
                booked_date: { cfsqltype: "cf_sql_timestamp", value: DateFormat(Now(),"yyy-mm-dd H:mm:ss")}
            }
        );
        return history_count.RecordCount;
    }

    public function userDetail() output=true { 
        user_detail = queryExecute(
            "SELECT id,fullname,email FROM br_user WHERE id = :customer_id", 
            {
                customer_id: { cfsqltype: "cf_sql_integer", value: session.id}
            }
        );
        return user_detail;
    }

}