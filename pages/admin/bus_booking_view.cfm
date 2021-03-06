<cfinclude  template = "include/header.cfm"  runOnce = "true">

<h1 class="app-page-title">Booking List</h1>
<hr class="mb-4">
<div class="row g-4 settings-section align-items-center justify-content-center">
   <cfinvoke component="local.cfc.admin.booking" method="listBooking" returnvariable="listData" >
   <div class="app-card app-card-orders-table mb-5">
      <div class="app-card-body">
         <div class="table-responsive">
            <table class="table mb-0 text-left">
               <thead>
                  <tr>
                     <th class="cell">Sl</th>
                     <th class="cell">Bus Name</th>
                     <th class="cell">Customer Name</th>
                     <th class="cell">Number of Seat</th>
                     <th class="cell">Seat numbers</th>
                     <th class="cell">Booking Status</th>
                     <th class="cell">Total Amount</th>
                     <th class="cell">Payment Status</th>
                     <th class="cell">Date</th>
                  </tr>
               </thead>
               <tbody>
               <CFSET counter = 1 />
               <cfoutput query="listData">
               <cfset date = parseDateTime(listData.booked_on, "m-dd-yy")>
                    <tr>
                        <td class="cell">#counter++#</td>
                        <td class="cell">#listData.bus_name#</td>
                        <td class="cell">#listData.fullname#</td>
                        <td class="cell">#listData.bookcount#</td>
                        <td class="cell">#listData.seatnumber#</td>
                        <td class="cell"><cfif listData.status eq 0><span class="badge bg-warning">Pending</span><cfelseif listData.status eq 1><span class="badge bg-success">Success</span><cfelseif listData.status eq 2><span class="badge bg-danger">Booking Cancelled</span></cfif></td>
                        <td class="cell">#listData.totalamount#</td>
                        <td class="cell"><cfif listData.paid eq 1><span class="badge bg-success">Paid</span><cfelseif listData.paid eq 0><span class="badge bg-danger">Unpaid</span></cfif></td>
                        <td class="cell">#DateFormat(parsedatetime(listData.booked_on),'dd/mm/yyyy')#</td>
                    </tr>
               </cfoutput>   
               </tbody>
            </table>
         </div>
      </div>
   </div>
</div>

<cfinclude  template = "include/footer.cfm"  runOnce = "true">                    