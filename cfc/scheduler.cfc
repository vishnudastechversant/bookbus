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
                                    customer        =  resultset.customer;
                                    reminder        =  'Reminder for your travel with #resultset.bus_name#';
                                    message         =  'Your reminder for travel with #resultset.bus_name#, Your bus starts at #resultset.departure#  and will be reaching your destination at #resultset.arrival#. Have a safe journey.';
                                    email 	        =  resultset.email;
                                    mail_services 	=  new mail(to = email, from = "mbjino@gmail.com", subject = reminder, body = message);
                                    mail_services.send();
                                }
                        })

                        cfschedule(
                                    action    = "delete", 
                                    task      = "BookingReminder#customer#"
                                );
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
        
    remote function overallReport()
        {
            admindata       = getAllAdmin();
            if(admindata !== 'error' AND arrayLen(admindata) > 0)
                {
                    arrayEach(admindata, function(admin_element,index){

                    reportdata  = getReportData(admin_element.id);

                    htmlreport  =   '';

                    if(reportdata !== 'error')
                        {
                            if(arrayLen(reportdata) > 0){

                                arrayEach(reportdata, function(element,index){

                                    htmlreport  &=  '<tr>
                                                        <td>#element.bus_name#</td>
                                                        <td>#element.email#</td>
                                                        <td>#element.seat_no#</td>
                                                        <td>#element.price#</td>
                                                        <td>#element.route_from#</td>
                                                        <td>#element.route_to#</td>
                                                        <td>#element.departure#</td>
                                                        <td>#element.arrival#</td>
                                                        <td>#DateFormat(parsedatetime(element.booked_on),'yyyy-mm-dd')#</td>
                                                        <td></td>
                                                    </tr>';

                                });
                                
                            }

                            mailmessage  = '<table border="2">
                                                <tr>
                                                    <th>Bus Name</th>
                                                    <th>Email</th>
                                                    <th>Seat No</th>
                                                    <th>Price</th>
                                                    <th>Route From</th>
                                                    <th>Route To</th>
                                                    <th>Departure</th>
                                                    <th>Arrival</th>
                                                    <th>Booked On</th>
                                                    <th>Check</th>
                                                </tr>
                                                #htmlreport#
                                            </table>';
                            
                            cfhtmltopdf(destination = '../reports/myreport.pdf',overwrite="yes")
                                { 
                                    writeOutput(mailmessage);
                                };

                            subject         =  'Booking report for #DateFormat(Now(),'yyyy-mm-dd')#';
                            message         =  'Hello, Please find today report attached with this email.';
                            admin_email 	=  admin_element.email;
                            //mail_services 	=  new mail(to = email, from = "mbjino@gmail.com", subject = reminder, body = message);
                            //mail_services.send();
                            
                            cfmail(
                                to      = admin_email,
                                from    = "mbjino@gmail.com",
                                subject = subject,
                                type    = "html"
                            )
                            {
                                writeOutput(message);
                                cfmailparam( file="../reports/myreport.pdf" );
                            }
                        }

                    });

                }
        }

    private function getAllAdmin()
        {
            try 
            {
                admindata = queryExecute("SELECT * FROM br_user WHERE user_role = 1", {}, {returntype = "array"});
                return admindata;
            }
            catch(any e)
            {
                return 'error';
            }
        }

    private function getReportData(adminid)
        {
            try
            {
                allbooking  =   queryExecute(
                                        "SELECT 
                                            buses.bus_name AS bus_name, 
                                            users.email AS email, 
                                            bookings.seat_no AS seat_no, 
                                            bookings.fare AS price, 
                                            bookings.status AS status, 
                                            routes.departure_time AS departure, 
                                            routes.arrival_time AS arrival,
                                            bookings.booked_on AS booked_on, 
                                            (SELECT city FROM br_city WHERE routes.route_from = id ) AS route_from, 
                                            (SELECT city FROM br_city WHERE routes.route_to = id ) AS route_to 
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
                                            buses.created_by = :adminid
                                        AND 
                                            bookings.booked_on = '#DateFormat(Now(),'yyyy-mm-dd')#'
                                        GROUP BY 
                                            bookings.seat_no
                                        ORDER BY bookings.seat_no", 
                                    {
                                        adminid: { cfsqltype: "cf_sql_integer", value: adminid }
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