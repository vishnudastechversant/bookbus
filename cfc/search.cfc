component { 
    remote function locFunction(required string loc,sec) { 
        cfquery( name="loclist",result="xResult" ) { 
            writeOutput("SELECT id,city FROM br_city
            WHERE city LIKE "); cfqueryparam( cfsqltype="cf_sql_varchar", VALUE=loc&'%');
        }
       //return loclist;
        cfoutput(QUERY="loclist" ) {
                writeOutput("<li class=""list-group-item"" onclick=""listHandle('#id#','#city#','#sec#')"">#city#</li>"
            );
        }
    }

    remote function Listfunction(required string loc_f,loc_t,date) { 
        date = DateFormat(date,"e");
        cfquery( name="buslist1",result="xResult" ) { 
            writeOutput("SELECT id,bus_name FROM br_buses
            WHERE available_today = "); cfqueryparam( cfsqltype="cf_sql_integer", VALUE=1);
        }

        myQuery = queryExecute(
        "SELECT * FROM br_bus_routes 
        WHERE available_today = :myid AND FIND_IN_SET :ui ", 
        {
            myid: { cfsqltype: "cf_sql_integer", value: 1 },
            ui: { cfsqltype: "cf_sql_varchar", value:"(Thu,bus_days)"}
        }
        );  
            writeDump(var=myQuery);
    }
}