component displayname="scheduler"{

    remote function bookingReminder()
        {
            if(structKeyExists(url, 'BookingID'))
            {
                
                getbookingid = listToArray(url.BookingID,",",true,true);
                
                if(arrayLen(getbookingid) > 0)
                    {
                        arrayEach(getbookingid, function(element,index){
                            
                            bookingid = element;
                            writeOutput('Booking Id: #element#');

                        })
                    }
            }
        }

    private function getBookingInformation()
        {
            
        }    

}