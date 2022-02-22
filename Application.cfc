component {

    this.name = "Bus Booking";
    this.datasource = "busbooking";
    this.sessionManagement = true;
    this.sessionTimeout = CreateTimeSpan(0, 0, 30, 0);
    this.ormEnabled = true;
    this.ormSettings = { logsql : true, datasource = "busbooking", cfclocation = ["entity"] };
    this.mappings["/local"] = getDirectoryFromPath(getCurrentTemplatePath());

    function onRequestStart(requestname){ 
        if(findNoCase("/bookbus/index.cfm",requestname) > 0){
            location("/bookbus/pages/user/index.cfm",false);
        } 
        if(!structKeyExists(session, "id") ){
            if(findNoCase("/bookbus/cfc/booking.cfc",requestname) > 0){
                writeOutput('<center><h1>Login Required</h1>
                <p>Please Login to yout account</p></center>');
                abort;
            }
        }
    }

/*     function onError(Exception,EventName){
        writeOutput('<center><h1>An error occurred</h1>
        <p>Please Contact the developer</p>
        <p>Error details: #Exception.message#</p></center>');
    } */

    function onMissingTemplate(targetPage){
        writeOutput('<center><h1>This Page is not avilable.</h1>
        <p>Please go back:</p></center>');
    }
}