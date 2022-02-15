component {

    this.name = "Bus Booking";
    this.datasource = "busbooking";
    this.sessionManagement = true;
    this.sessionTimeout = CreateTimeSpan(0, 0, 30, 0);
    this.ormEnabled = true;
    this.ormSettings = { logsql : true };

   function onRequestStart(requestname){ 

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


}