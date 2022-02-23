<cfinclude  template="header.cfm">
<cfset recordperpage =2/>
<cfset pageno = 1/>

<cfif structKeyExists(url, 'page')>
      <cfset pageno = url.page/>
</cfif>

<!--- get total count --->
<cfset history         = createObject("component","bookbus/cfc/userDetails")/>
<cfset history_count   = history.historyCount()/> 

<!--- get book list --->
<cfset booklist  = createObject("component","bookbus/cfc/userDetails")/>
<cfset list      = booklist.history(recordperpage,pageno)/> 

<div class="buses" id="buses" style="display: block;">
    <cfif list.RecordCount neq 0>
        <CFOUTPUT QUERY="list">
            <div class="bus-details bgclr">
                    <p id="go-time"></p>
                    <p id="bus-route"><b>Date: #DateFormat(parsedatetime(booked_on),'dd/mm/yyyy')#</b></p>
                    <p id="bus-name">Bus Name :#bus_name#</p>
                    <p id="bus-routes"><b>From </b> #cityfrom# <b>To </b>#cityto#</p>
                    <p id="seatz">Seats Selected :#seats#</p>
                    <p id="fare">Fare : Rs #fare#</p>
                    <p id="reach-time">Departure Time : #timeFormat(departure_time,"hh:mm tt")#/Arrival Time :#timeFormat(arrival_time,"hh:mm tt")#</p>
            </div>
        </CFOUTPUT>
    </cfif>
    <cfset x = 1/>
    <nav aria-label="Page navigation example">
        <ul class="pagination">
            <cfloop from="0" to="#history_count-1#" index="i" step="#recordperpage#">
                <cfset y = x++/>
                <cfif pageno eq y>
                    <cfset cl ="active"/>
                <cfelse>
                    <cfset cl =""/>
                </cfif>
                <cfoutput>
                    <li class=""><a class="page-link #cl#" href="bookingHistory.cfm?page=#y#">#y#</a></li>
                </cfoutput>
            </cfloop>
        </ul>
    </nav>
</div>
<cfinclude  template="footer.cfm">
