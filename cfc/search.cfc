component { 
    remote function locFunction(required string loc,sec) { 
        cfquery( name="loclist",result="xResult" ) { 
            writeOutput("SELECT id,city FROM br_city
            WHERE city LIKE "); cfqueryparam( cfsqltype="cf_sql_varchar", VALUE=loc&'%');
        }
 
       //return loclist;
        cfoutput(QUERY="loclist" ) {
                writeOutput("<ul class=""list-group"">
                <li class=""list-group-item"" onclick=""listHandle('#id#','#city#','#sec#')"">#city#</li>
                </ul>"
            );
        }
    }
}