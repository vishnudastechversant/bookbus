<cfif structKeyExists(url, 'id')>
<cfinclude  template = "include/header.cfm"  runOnce = "true">
<cfinvoke component="local.cfc.admin.state" method="selectSingleState" returnvariable="editData" userId=#url.id# >
<h1 class="app-page-title">Edit State</h1>
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
            <form method="post" action="../../cfc/admin/state.cfc?method=updateState" class="settings-form">
               <input name="csrftoken" type="hidden" value="#csrfToken#">
               <div class="mb-3">
                    <cfoutput>
                        <label for="state_name" class="form-label">State Name</label>
                        <input type="text" name="state_name" class="form-control" value="#editData.state#" required>
                        <input type="hidden" name="state_id" value="#editData.id#" />
                    </cfoutput>
               </div>
               <button type="submit" class="btn app-btn-primary" >Save</button>
            </form>
         </div>
      </div>
   </div>
   <cfinvoke component="local.cfc.admin.state"  method="getState" returnvariable="allState">
   <div class="app-card app-card-orders-table mb-5">
    <div class="app-card-body">
	    <div class="table-responsive">
	        <table class="table mb-0 text-left">
				<thead>
					<tr>
						<th class="cell">Sl</th>
						<th class="cell">State Name</th>
						<th class="cell"></th>
					</tr>
				</thead>
				<tbody>
            <CFSET counter = 1 />
            <cfoutput query="allState">
					<tr>
						<td class="cell">#counter++#</td>
						<td class="cell">#allState.state#</td>
						<td class="cell"><a class="btn-sm app-btn-success" href="edit_state.cfm?id=#allState.id#">Edit</a> &nbsp <a class="btn-sm app-btn-secondary" href="../../cfc/admin/state.cfc?method=deleteState&id=#allState.id#"onclick="return confirm('Are you sure you want to Remove?');">Delete</a> </td>
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
    <cflocation url="state.cfm"/>
</cfif>