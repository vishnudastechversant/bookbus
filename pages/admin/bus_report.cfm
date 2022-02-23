<cfinclude  template = "include/header.cfm"  runOnce = "true">

<h1 class="app-page-title"></h1>
<hr class="mb-4">
<div class="row g-4 settings-section align-items-center justify-content-center">
   <div class="col-12 col-md-8">
      <div class="app-card app-card-settings shadow-sm p-4">
         <div class="app-card-body">
         <cfset csrftoken= CSRFGenerateToken()/>
            <form method="post" action="../../cfc/admin/booking.cfc?method=busReport" class="settings-form">
            <input name="csrftoken" type="hidden" value="#csrfToken#">
               <cfinvoke component="local.cfc.admin.booking"  method="listBus" returnvariable="allbus">
                <div class="mb-3">
                  <label for="setting-input-2" class="form-label">Select Bus</label>
                  <select class="form-control" name="bus_id">
                     <option value="">--select--</option>
                     <cfoutput query="allbus">
                        <option value="#allbus.id#">#allbus.bus_name#</option>
                     </cfoutput>  
                  </select>
                </div>
               <div class="mb-3">
                  <label for="setting-input-2" class="form-label">Date</label>
                  <input type="date" name="date" class="form-control" id="setting-input-2" required>
               </div>
               
               <button type="submit" class="btn app-btn-primary" >Search</button>
            </form>
         </div>
      </div>
   </div>
   <cfif structKeyExists(Session, 'bookingrepo')>
   <cfset repodata = Session.bookingrepo>
   <div class="app-card app-card-orders-table mb-5">
   <a href="bus_report_pdf.cfm" class="btn-sm app-btn-secondary">Print PDF</a>
      <div class="app-card-body">
         <div class="table-responsive">
            <table class="table mb-0 text-left">
               <thead>
                  <tr>
                     <th class="cell">Sl</th>
                     <th class="cell">Customer</th>
                     <th class="cell">Seat Number</th>
                     <th class="cell">Amount</th>
                     <th class="cell">Date</th>
                  </tr>
               </thead>
               <tbody>
               <CFSET counter = 1 />
               <cfoutput query="repodata">
                  <tr>
                     <td class="cell">#counter++#</td>
                     <td class="cell">#repodata.fullname#</td>
                     <td class="cell">#repodata.seat_no#</td>
                     <td class="cell">#repodata.fare#</td>
                     <td class="cell">#DateFormat(parsedatetime(repodata.booked_on),'dd/mm/yyyy')#</td>
                  </tr>
               </cfoutput>   
               </tbody>
            </table>
         </div>
      </div>
   </div>
   </cfif>
</div>

<cfinclude  template = "include/footer.cfm"  runOnce = "true">                    