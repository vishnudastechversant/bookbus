<cfif structKeyExists(url, 'id')>
<cfinclude  template = "include/header.cfm"  runOnce = "true">
<cfinvoke component="local.cfc.admin.city" method="selectSingleCity" returnvariable="editData" userId=#url.id# >
<h1 class="app-page-title">Edit City</h1>
<hr class="mb-4">
<div class="row g-4 settings-section align-items-center justify-content-center">
   <div class="col-12 col-md-8">
      <div class="app-card app-card-settings shadow-sm p-4">
       <cfoutput>
         <cfif structKeyExists(Session, 'admin_status')>
            <cfif Session.admin_status EQ 'success'>
               <div class="alert alert-primary" role="alert">
                  #Session.admin_message#
               </div>
            <cfelseif Session.admin_status EQ 'error'>
               <div class="alert alert-danger" role="alert">
                  #Session.admin_message#
               </div>
            </cfif>   
         </cfif>
      </cfoutput>
         <div class="app-card-body">
         <cfset csrftoken= CSRFGenerateToken()/>
            <form method="post" action="../../cfc/admin/city.cfc?method=updateCity" class="settings-form">
            <input name="csrftoken" type="hidden" value="#csrfToken#">
               <cfinvoke component="local.cfc.admin.state"  method="getState" returnvariable="allState">
                <div class="mb-3">
                  <label for="setting-input-2" class="form-label">Select State</label>
                  <select class="form-control" name="state_id">
                     <option value="">--select--</option>
                     <cfoutput query="allState">
                        <option <cfif editData.state_id eq allState.id>selected</cfif> value="#allState.id#">#allState.state#</option>
                     </cfoutput>  
                  </select>
                </div>
               <div class="mb-3">
                <cfoutput>
                  <label for="setting-input-2" class="form-label">City Name</label>
                  <input type="text" name="city" class="form-control" id="setting-input-2" value="#editData.city#" required>
                  <input type="hidden" value="#editData.id#" name="city_id">
                </cfoutput>
               </div>
               
               <button type="submit" class="btn app-btn-primary" >Save</button>
            </form>
         </div>
      </div>
   </div>
   <cfinvoke component="local.cfc.admin.city"  method="getcity" returnvariable="allcity">
   <div class="app-card app-card-orders-table mb-5">
      <div class="app-card-body">
         <div class="table-responsive">
            <table class="table mb-0 text-left">
               <thead>
                  <tr>
                     <th class="cell">Sl</th>
                     <th class="cell">State Name</th>
                     <th class="cell">City Name</th>
                     <th class="cell"></th>
                  </tr>
               </thead>
               <tbody>
               <CFSET counter = 1 />
               <cfoutput query="allcity">
                  <tr>
                     <td class="cell">#counter++#</td>
                     <td class="cell">#allcity.state#</td>
                     <td class="cell">#allcity.city#</td>
                     <td class="cell"><a class="btn-sm app-btn-success" href="edit_city.cfm?id=#allcity.id#">Edit</a> &nbsp <a class="btn-sm app-btn-secondary" href="../../cfc/admin/city.cfc?method=deletCity&id=#allcity.id#"onclick="return confirm('Are you sure you want to Remove?');">Delete</a> </td>
                  </tr>
               </cfoutput>   
               </tbody>
            </table>
         </div>
      </div>
   </div>
</div>

<cfinclude  template = "include/footer.cfm"  runOnce = "true">      
<cfelse>
    <cflocation url="city.cfm"/>
</cfif>