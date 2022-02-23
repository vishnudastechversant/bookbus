component { 
    public function history(recordperpage,pageno=1) output=true { 

        pageno        = (pageno-1) * recordperpage;
        book_list = queryExecute(
            "SELECT count(br_bookings.id) as bookcount,bus_name,bus_type,fare,booked_on,seat_no,departure_time,
            arrival_time,route_from,route_to,routef.city as cityfrom,routet.city as cityto FROM br_buses 
            INNER JOIN br_bookings ON br_buses.id = br_bookings.bus_id INNER JOIN br_bus_routes r ON r.id = br_bookings.route_id
            INNER JOIN br_city as routef ON r.route_from  = routef.id  INNER JOIN br_city as routet ON r.route_to  = routet.id
            WHERE customer = :customer_id AND booked_on < :booked_date GROUP BY booked_on ORDER BY booked_on DESC LIMIT :startrecord, :recordperpag;", 
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
            "SELECT id FROM br_bookings WHERE customer = :customer_id AND booked_on < :booked_date GROUP BY booked_on;", 
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
            "SELECT count(br_bookings.id) as bookcount,bus_name,bus_type,fare,booked_on,seat_no,departure_time,
            arrival_time,route_from,route_to,routef.city as cityfrom,routet.city as cityto FROM br_buses 
            INNER JOIN br_bookings ON br_buses.id = br_bookings.bus_id INNER JOIN br_bus_routes r ON r.id = br_bookings.route_id
            INNER JOIN br_city as routef ON r.route_from  = routef.id  INNER JOIN br_city as routet ON r.route_to  = routet.id
            WHERE customer = :customer_id AND booked_on > :booked_date GROUP BY booked_on ORDER BY booked_on DESC LIMIT :startrecord, :recordperpag;", 
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
            "SELECT id FROM br_bookings WHERE customer = :customer_id AND booked_on > :booked_date GROUP BY booked_on;", 
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