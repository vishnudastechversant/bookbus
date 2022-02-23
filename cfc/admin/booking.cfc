component { 
    function listBooking(){
        booking = queryExecute("SELECT * FROM br_bookings INNER JOIN br_user ON br_bookings.customer=br_user.id INNER JOIN br_buses ON br_bookings.bus_id=br_buses.id", {});
        return booking;
    }

    function listBus(){
        bus = queryExecute("SELECT * FROM br_buses", {});
        return bus;
    }

    remote function busReport(bus_id,date){
         report = queryExecute("SELECT * FROM br_bookings INNER JOIN br_user ON br_bookings.customer=br_user.id WHERE br_bookings.bus_id = #bus_id#", {});
         Session.bookingrepo  =  report;
         location('../../pages/admin/bus_report.cfm');
    }
}