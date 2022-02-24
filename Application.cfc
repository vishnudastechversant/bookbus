component {

    this.name = "Bus Booking";
    this.datasource = "busbooking";
    this.sessionManagement  = true;
    this.sessionTimeout = CreateTimeSpan(0, 0, 30, 0);
    this.mappings["/local"] = getDirectoryFromPath(getCurrentTemplatePath());

    function onRequestStart(requestname){ 
        if(findNoCase("/bookbus/index.cfm",requestname) > 0){
            location("/bookbus/pages/user/index.cfm",false);
        }  
        if(findNoCase("/bookbus/pages/admin",requestname) > 0 && structKeyExists(session, "role") && session.role == 2){
            location("/bookbus/pages/user/index.cfm",false);
        }   
        if(findNoCase("/bookbus/pages/user",requestname) > 0 && structKeyExists(session, "role") && session.role == 1){
            location("/bookbus/pages/admin/index.cfm",false);
        } 
        if(!structKeyExists(session, "id") ){
            if(findNoCase("/bookbus/cfc/booking.cfc",requestname) > 0 ||
            findNoCase("/bookbus/pages/user/bookingConfirmed.cfm",requestname) > 0||
            findNoCase("/bookbus/pages/user/bookingHistory.cfm",requestname) > 0 ||
            findNoCase("/bookbus/pages/user/upcommingBooking.cfm",requestname) > 0 || 
            findNoCase("/bookbus/pages/user/profile.cfm",requestname) > 0){
                writeOutput('<center><h1>Login Required</h1>
                <p>Please Login to yout account</p></center>');
                abort;
            }
        }
    }

    function onError(Exception,EventName){
        writeOutput('<center><h1>An error occurred</h1>
        <p>Please Contact the developer</p>
        <p>Error details: #Exception.message#</p></center>');
    } 

    function onMissingTemplate(targetPage){
        writeOutput('<center><h1>This Page is not avilable.</h1>
        <p>Please go back:</p></center>');
    }

    function onSessionEnd(sessionScope, applicationScope){
        writeOutput('<center>
                     <h1>Your session expired. Please login again</h1>
                     <a href="pages/user/index.cfm">Click Here</a>
                     </center>');
    }
}