<cfinclude  template = "include/header.cfm"  runOnce = "true">


			    <div class="row g-3 mb-4 align-items-center justify-content-between">
				    <div class="col-auto">
			            <h1 class="app-page-title mb-0">List All Bus</h1>
				    </div>
				    <div class="col-auto">
					     <div class="page-utilities">
						    <div class="row g-2 justify-content-start justify-content-md-end align-items-center">
							    <div class="col-auto">						    
								    
							    </div>
						    </div>
					    </div>
				    </div>
			    </div>
			   	<cfset busObj  = createObject("component", "local.cfc.admin.buses")>
            	<cfset busData = busObj.getBuses(1) />	
            	<cfoutput>
	               <cfif structKeyExists(Session, 'admin_status') AND len(trim(Session.admin_status))  GT 0 >
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
				<cfset Session.admin_status  = '' />
                <cfset Session.admin_message = '' />
                <cfset Session.admin_form    = structNew() />
			    <div class="tab-content" id="orders-table-tab-content">
			        <div class="tab-pane fade show active" id="orders-all" role="tabpanel" aria-labelledby="orders-all-tab">
					    <div class="app-card app-card-orders-table shadow-sm mb-5">
						    <div class="app-card-body">
							    <div class="table-responsive">
							        <table class="table app-table-hover mb-0 text-left">
										<thead>
											<tr>
												<th class="cell">Bus Name</th>
												<th class="cell">Bus Type</th>
												<th class="cell">Seats</th>
												<th class="cell">Price</th>
												<th class="cell">Bus Days</th>
												<th class="cell">Route</th>
												<th class="cell">Timing</th>
												<th class="cell">Available Today</th>
												<th class="cell">Daily Bus</th>
												<th class="cell"></th>
											</tr>
										</thead>
										<tbody>
											<cfoutput>
												<cfloop query="busData">
													<tr>
														<td class="cell">#busData.bus_name#</td>
														<td class="cell">#busData.bus_type#</td>
														<td class="cell">#busData.no_of_seats#</td>
														<td class="cell">#busData.price#</td>
														<td class="cell">#busData.bus_days#</td>
														<td class="cell">#busData.route_from# -> #busData.route_to#</td>
														<td class="cell">#busData.departure_time# -> #busData.arrival_time#</td>
														<td class="cell">#busData.route_available_today#</td>
														<td class="cell">#busData.daily_bus#</td>
														<td class="cell">
															<a href="./editbus.cfm?busid=#busData.bus_id#">Edit</a>
														</td>
													</tr>
												</cfloop>
											</cfoutput>
										</tbody>
									</table>
						        </div>
						    </div>		
						</div>
						<!--
						<nav class="app-pagination">
							<ul class="pagination justify-content-center">
								<li class="page-item disabled">
									<a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>
							    </li>
								<li class="page-item active"><a class="page-link" href="#">1</a></li>
								<li class="page-item"><a class="page-link" href="#">2</a></li>
								<li class="page-item"><a class="page-link" href="#">3</a></li>
								<li class="page-item">
								    <a class="page-link" href="#">Next</a>
								</li>
							</ul>
						</nav>
						-->
			        </div>
				</div>
		    </div>

<cfinclude  template = "include/footer.cfm"  runOnce = "true">  