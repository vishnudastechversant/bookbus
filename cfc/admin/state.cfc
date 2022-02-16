component { 
    remote function addState(string state_name) { 

        response = structNew()
			try{
				result = queryExecute("INSERT INTO br_state( state ) VALUES( :state)",{state :{cfsqltype: "cf_sql_varchar", value: "#arguments.state_name#"}},{});
				response.status = 	"success";
			}
			catch (any e)
			{
				response.status = "error";
				response.text 	= #e.message#;
			}
			return response;
    }

    remote function getState(){
        data = structNew();
        try {
                ORMReload()
                currcontact		= 	entityLoad("state")
                data.status 	= 	'ok';
                data.message	=	currcontact;
                writeOutput(serializeJSON(data));
            }
        catch(Exception e)
            {
                data.status 	= 	'error';
                data.message	=	e.message;
                writeOutput(serializeJSON(data));
            }
    }
}
