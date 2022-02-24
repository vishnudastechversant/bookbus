component { 
    function listBooking(){
        booking = queryExecute("SELECT count(br_bookings.seat_no) as bookcount,GROUP_CONCAT(br_bookings.seat_no ORDER BY br_bookings.seat_no  SEPARATOR', ') as seatnumber, SUM(br_bookings.fare) as totalamount,bus_name,bus_type,booked_on,seat_no,departure_time,fullname,status,paid,arrival_time,route_from,route_to,routef.city as cityfrom,routet.city as cityto FROM br_buses INNER JOIN br_bookings ON br_buses.id = br_bookings.bus_id INNER JOIN br_user ON br_bookings.customer=br_user.id INNER JOIN br_bus_routes r ON r.id = br_bookings.route_id INNER JOIN br_city as routef ON r.route_from  = routef.id  INNER JOIN br_city as routet ON r.route_to = routet.id GROUP BY booked_on ORDER BY booked_on ;",{} ); 
        return booking;
    }

    function listBus(){
        bus = queryExecute("SELECT * FROM br_buses", {});
        return bus;
    }

    remote function busReport(bus_id,date){
         report = queryExecute("SELECT * FROM br_bookings INNER JOIN br_user ON br_bookings.customer=br_user.id WHERE br_bookings.bus_id = :busId AND DATE(br_bookings.booked_on) = :bookDate", {
            busId: { cfsqltype: "cf_sql_integer", value: bus_id},
            bookDate: { cfsqltype: "cf_sql_date", value: DateFormat(date,"yyy-mm-dd H:mm:ss")}
         });
         Session.bookingrepo  =  report;
         location('../../pages/admin/bus_report.cfm');
    }
}      