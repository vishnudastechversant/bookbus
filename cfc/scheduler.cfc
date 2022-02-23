component displayname="scheduler"{

    remote function bookingReminder()
        {
            if(structKeyExists(url, 'BookingID'))
            {
                
                getbookingid = listToArray(url.BookingID,",",true,true);
                
                if(arrayLen(getbookingid) > 0)
                    {
                        arrayEach(getbookingid, function(element,index){
                            
                            bookingdata  = getBookingInformation(element);

                            if(arrayLen(bookingdata) == 1)
                                {
                                    resultset       =  bookingdata[1];
                                    reminder        =  'Reminder for your travel with #resultset.bus_name#';
                                    message         =  'Your reminder for travel with #resultset.bus_name#, Your bus starts at #resultset.departure#  and will be reaching your destination at #resultset.arrival#. Have a safe journey.';
                                    email 	        =  resultset.email;
                                    mail_services 	=  new mail(to = email, from = "mbjino@gmail.com", subject = reminder, body = message);
                                    mail_services.send();
                                }
                        })
                    }
            }
        }

    private function getBookingInformation(bookingid)
        {
            try
            {
                allbooking  =   queryExecute(
                                        "SELECT 
                                            bookings.id AS bookingid, 
                                            bookings.customer AS customer, 
                                            bookings.bus_id AS bus_id,  
                                            bookings.seat_no AS seat_no,
                                            bookings.fare AS price, 
                                            bookings.status AS status,
                                            buses.bus_name AS bus_name,
                                            users.email AS email,
                                            routes.departure_time AS departure,
                                            routes.arrival_time AS arrival,
                                            (SELECT city FROM br_city WHERE routes.route_from = id  ) AS route_from,
                                            (SELECT city FROM br_city WHERE routes.route_to = id  ) AS route_to
                                        FROM 
                                            br_bookings AS bookings
                                        LEFT JOIN 
                                            br_user AS users 
                                        ON 
                                            users.id = bookings.customer
                                        LEFT JOIN
                                            br_bus_routes AS routes 
                                        ON
                                            routes.id = bookings.route_id
                                        LEFT JOIN
                                            br_buses AS buses 
                                        ON
                                            buses.id = bookings.bus_id    
                                        WHERE 
                                            bookings.id = :bookingid", 
                                    {
                                        bookingid: { cfsqltype: "cf_sql_integer", value: bookingid }
                                    }, 
                                    {
                                        returntype = "array"
                                    }
                                );
                return allbooking;
            }
            catch(any e)
            {
                return 'error';
            }
        }    

}