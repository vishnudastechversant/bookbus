component { 
    function listBooking(){
        booking = queryExecute("SELECT * FROM br_bookings INNER JOIN br_user ON br_bookings.customer=br_user.id INNER JOIN br_buses ON br_bookings.bus_id=br_buses.id", {});
        return booking;
    }
}