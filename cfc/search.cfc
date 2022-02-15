component { 
    remote function locFunction(required string loc,sec) { 
        cfquery( name="loclist", datasource="bus_ticket", result="xResult" ) { 
            writeOutput("SELECT id,name FROM city
            WHERE name LIKE "); cfqueryparam( cfsqltype="cf_sql_varchar", VALUE=loc&'%');
        }
 
       //return loclist;
        cfoutput(QUERY="loclist" ) {
                writeOutput("<ul class=""list-group"">
                <li class=""list-group-item"" onclick=""listHandle('#id#','#name#','#sec#')"">#name#</li>
                </ul>"
            );
        }
    }
}