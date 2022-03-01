component displayname="scheduler"{

    remote function bookingReminder()
        {
            if(structKeyExists(url, 'BookingID'))
            {
                
                variables.getbookingid = listToArray(url.BookingID,",",true,true);
                
                if(arrayLen(variables.getbookingid) > 0)
                    {
                        arrayEach(variables.getbookingid, function(element,index){
                            
                            variables.bookingdata  = getBookingInformation(element);

                            if(arrayLen(variables.bookingdata) == 1)
                                {
                                    variables.resultset       =  bookingdata[1];
                                    variables.customer        =  resultset.customer;
                                    variables.reminder        =  'Reminder for your travel with #resultset.bus_name#';
                                    variables.message         =  'Your reminder for travel with #resultset.bus_name#, Your bus starts at #resultset.departure#  and will be reaching your destination at #resultset.arrival#. Have a safe journey.';
                                    variables.email 	      =  resultset.email;
                                    variables.mail_services   =  new mail(to = variables.email, from = "mbjino@gmail.com", subject = variables.reminder, body = variables.message);
                                    variables.mail_services.send();
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
                variables.allbooking  =   queryExecute(
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
                return variables.allbooking;
            }
            catch(any e)
            {
                return 'error';
            }
        } 
        
    remote function overallReport()
        {
            variables.admindata       = getAllAdmin();
            if(variables.admindata !== 'error' AND arrayLen(variables.admindata) > 0)
                {
                    arrayEach(variables.admindata, function(admin_element,index){

                    variables.reportdata  = getReportData(admin_element.id);

                    variables.htmlreport  =   '';

                    if(variables.reportdata !== 'error')
                        {
                            if(arrayLen(variables.reportdata) > 0){

                                arrayEach(variables.reportdata, function(element,index){

                                    variables.htmlreport  &=  '<tr>
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

                            variables.mailmessage  = '<table border="2">
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
                                    writeOutput(variables.mailmessage);
                                };

                            variables.subject         =  'Booking report for #DateFormat(Now(),'yyyy-mm-dd')#';
                            variables.message         =  'Hello, Please find today report attached with this email.';
                            variables.admin_email 	  =  admin_element.email;
                            
                            cfmail(
                                to      = variables.admin_email,
                                from    = "mbjino@gmail.com",
                                subject = variables.subject,
                                type    = "html"
                            )
                            {
                                writeOutput(variables.message);
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
                variables.admindata = queryExecute("SELECT * FROM br_user WHERE user_role = 1", {}, {returntype = "array"});
                return variables.admindata;
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
                variables.allbooking  =   queryExecute(
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
                return variables.allbooking;
            }
            catch(any e)
            {
                return 'error';
            }
        }

}