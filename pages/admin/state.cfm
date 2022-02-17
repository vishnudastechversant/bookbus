<cfinclude  template = "include/header.cfm"  runOnce = "true">

<h1 class="app-page-title">State</h1>
<hr class="mb-4">
<div class="row g-4 settings-section align-items-center justify-content-center">
   <div class="col-12 col-md-8">
      <div class="app-card app-card-settings shadow-sm p-4">
         <div class="app-card-body">
         <cfset csrftoken= CSRFGenerateToken()/>
            <form method="post" action="../../cfc/admin/state.cfc?method=addState" class="settings-form">
               <input name="csrftoken" type="hidden" value="#csrfToken#">
               <div class="mb-3">
                  <label for="state_name" class="form-label">State Name</label>
                  <input type="text" name="state_name" class="form-control" required>
               </div>
               <button type="submit" class="btn app-btn-primary" >Save</button>
            </form>
         </div>
      </div>
   </div>
   <cfset allState = entityLoad("state")>
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
                              <cfloop array="#allState#" index="row">
											<tr>
												<td class="cell">git15345</td>
												<td class="cell">#row.State#</td>
												<td class="cell"><a class="btn-sm app-btn-secondary" href="#">View</a></td>
											</tr>
                              </cfloop>   
										</tbody>
									</table>
						        </div>
						    </div>
						</div>
</div>

<cfinclude  template = "include/footer.cfm"  runOnce = "true">                    