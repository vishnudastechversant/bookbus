<cfinclude  template = "include/header.cfm"  runOnce = "true">

<h1 class="app-page-title">Add New Bus</h1>
<hr class="mb-4">
<div class="row g-4 settings-section align-items-center justify-content-center">
   <div class="col-12 col-md-8">
      <div class="app-card app-card-settings shadow-sm p-4">
         <div class="app-card-body">
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
            <cfset cityObj  = createObject("component", "local.cfc.admin.buses")>
            <cfset citydata = cityObj.getCity() />
            <cfoutput>
               <form class="addbus-form needs-validation" method="POST" action="../../cfc/admin/buses.cfc?method=addbus" name="addbus-form" id="addbus-form" onsubmit="return addSubmit(event)" novalidate>
                  <div class="mb-3">
                     <label for="bus-name" class="form-label">
                        Bus Name
                     </label>
                     <input type="text" class="form-control" name="bus_name" id="bus-name" value="<cfif structKeyExists(Session,'admin_form') AND structKeyExists(Session.admin_form, 'bus_name')>#Session.admin_form.bus_name#</cfif>" required>
                     <div class="invalid-feedback">
                        Please provide a valid bus name.
                      </div>
                  </div>
                  <div class="mb-3">
                     <cfif structKeyExists(Session,'admin_form') AND structKeyExists(Session.admin_form, 'bus_type')>
                           <cfset sel_bus_type = Session.admin_form.bus_type />
                        <cfelse>
                           <cfset sel_bus_type = '' />
                     </cfif>
                     <label for="bus-type" class="form-label">Bus Type</label>
                     <select name="bus_type" class="form-control" id="bus-type" required>
                        <option <cfif sel_bus_type EQ ''>selected="selected"</cfif> disabled value="">Select a bus type</option>
                        <option value="Seater" <cfif sel_bus_type EQ 'Seater'>selected="selected"</cfif>>Seater</option>
                        <option value="Sleeper" <cfif sel_bus_type EQ 'Sleeper'>selected="selected"</cfif>>Sleeper</option>
                        <option value="AC" <cfif sel_bus_type EQ 'AC'>selected="selected"</cfif>>AC</option>
                        <option value="NonAC" <cfif sel_bus_type EQ 'NonAC'>selected="selected"</cfif>>NonAC</option>
                     </select>
                     <div class="invalid-feedback">
                        Please select a bus type.
                     </div>
                  </div>
                  <div class="mb-3">
                     <cfif structKeyExists(Session,'admin_form') AND structKeyExists(Session.admin_form, 'layout_type')>
                           <cfset sel_layout_type = Session.admin_form.layout_type />
                        <cfelse>
                           <cfset sel_layout_type = '' />
                     </cfif>
                     <label for="layout-type" class="form-label">Layout Type</label>
                     <select name="layout_type" class="form-control" id="layout-type" required>
                        <option <cfif sel_layout_type EQ ''>selected="selected"</cfif> disabled value="">Select a layout type</option>
                        <option value="1" <cfif sel_layout_type EQ '1'>selected="selected"</cfif>>Seater</option>
                        <option value="2" <cfif sel_layout_type EQ '2'>selected="selected"</cfif>>Sleeper</option>
                     </select>
                     <div class="invalid-feedback">
                        Please select a layout type.
                      </div>
                  </div>
                  <div class="mb-3">
                     <cfif structKeyExists(Session,'admin_form') AND structKeyExists(Session.admin_form, 'available_today')>
                           <cfset sel_available_type = Session.admin_form.available_today />
                        <cfelse>
                           <cfset sel_available_type = '' />
                     </cfif>
                     <label for="available-today" class="form-label">Available Today (Default Yes)</label>
                     <select name="available_today" class="form-control" id="available-today">
                        <option <cfif sel_available_type EQ '1'>selected="selected"</cfif> value="1">Yes</option>
                        <option <cfif sel_available_type EQ '0'>selected="selected"</cfif> value="0">No</option>
                     </select>
                     <div class="invalid-feedback">
                        Please choose availability.
                      </div>
                  </div>
                  <div class="mb-3">
                     <label for="seat-count" class="form-label">Number of seats</label>
                     <input type="number" class="form-control" name="seat_count" id="seat-count" min="0" value="<cfif structKeyExists(Session,'admin_form') AND structKeyExists(Session.admin_form, 'seat_count')>#Session.admin_form.seat_count#</cfif>"   required>
                     <div class="invalid-feedback">
                        Please select number of seats.
                      </div>
                  </div>
                  <div class="mb-1">
                     <div class="app-card-footer mt-auto">
                        <h5>Add Route For Bus</h5>
                     </div>
                  </div>
                  <div class="app-card alert alert-dismissible shadow-sm mb-4" role="alert">
                     <div class="inner">
                        <div class="app-card-body p-3 p-lg-4">
                           <div class="row gx-5 gy-3">
                              <div class="col-4">
                                 <div class="mb-3">
                                    <label for="route-from" class="form-label">Route From</label>
                                    <cfif structKeyExists(Session,'admin_form') AND structKeyExists(Session.admin_form, 'route_from')>
                                          <cfset sel_route_from = Session.admin_form.route_from />
                                       <cfelse>
                                          <cfset sel_route_from = '' />
                                    </cfif>
                                    <select name="route_from" class="form-control" id="route-from">
                                       <option <cfif sel_layout_type EQ ''>selected="selected"</cfif> disabled value="">Select a city</option>
                                       <cfloop query="citydata">
                                         <option <cfif sel_route_from EQ citydata.id>selected="selected"</cfif> value="#citydata.id#">#citydata.city#</option>
                                       </cfloop>
                                    </select>
                                    
                                    <div class="invalid-feedback">
                                       Please provide route from.
                                    </div>
                                 </div>
                              </div>
                              <div class="col-4">
                                 <div class="mb-3">
                                    <label for="route-to" class="form-label">Route To</label>
                                    <cfif structKeyExists(Session,'admin_form') AND structKeyExists(Session.admin_form, 'route_from')>
                                          <cfset sel_route_to = Session.admin_form.route_to />
                                       <cfelse>
                                          <cfset sel_route_to = '' />
                                    </cfif>
                                    <select name="route_to" class="form-control" id="route-to">
                                       <option <cfif sel_route_to EQ ''>selected="selected"</cfif> disabled value="">Select a city</option>
                                       <cfloop query="citydata">
                                         <option <cfif sel_route_from EQ citydata.id>selected="selected"</cfif> value="#citydata.id#">#citydata.city#</option>
                                       </cfloop>
                                    </select>
                                    <div class="invalid-feedback">
                                       Please provide route to.
                                     </div>
                                 </div>
                              </div>
                              <div class="col-4">
                                 <div class="mb-3">
                                    <cfif structKeyExists(Session,'admin_form') AND structKeyExists(Session.admin_form, 'main_route')>
                                          <cfset sel_main_route = Session.admin_form.main_route />
                                       <cfelse>
                                          <cfset sel_main_route = '' />
                                    </cfif>
                                    <label for="main-route" class="form-label">Main Route</label>
                                    <select name="main_route" class="form-control" id="main-route">
                                       <option <cfif sel_main_route EQ 'yes'>selected="selected"</cfif>  value="yes">Yes</option>
                                       <option <cfif sel_main_route EQ 'no'>selected="selected"</cfif>  value="no">No</option>
                                    </select>
                                    <div class="invalid-feedback">
                                       Please choose main route.
                                    </div>
                                 </div>
                              </div>
                           </div>
                           <div class="row gx-5 gy-3">
                              <div class="col-4">
                                 <div class="mb-3">
                                    <cfif structKeyExists(Session,'admin_form') AND structKeyExists(Session.admin_form, 'daily_bus')>
                                          <cfset sel_daily_bus = Session.admin_form.daily_bus />
                                       <cfelse>
                                          <cfset sel_daily_bus = '' />
                                    </cfif>
                                    <label for="daily-bus" class="form-label">Daily Bus</label>
                                    <select name="daily_bus" class="form-control" id="daily-bus">
                                       <option <cfif sel_daily_bus EQ 'yes'>selected="selected"</cfif> value="yes">Yes</option>
                                       <option <cfif sel_daily_bus EQ 'no'>selected="selected"</cfif> value="no">No</option>
                                    </select>
                                    <div class="invalid-feedback">
                                       Please choose daily bus availablitys.
                                    </div>
                                 </div>
                              </div>
                              <div class="col-4">
                                 <div class="mb-3">
                                    <cfif structKeyExists(Session,'admin_form') AND structKeyExists(Session.admin_form, 'route_available')>
                                          <cfset sel_route_available = Session.admin_form.route_available />
                                       <cfelse>
                                          <cfset sel_route_available = '' />
                                    </cfif>
                                    <label for="route-available" class="form-label">Available Today</label>
                                    <select name="route_available" class="form-control" id="route-available">
                                       <option <cfif sel_route_available EQ 'yes'>selected="selected"</cfif> value="yes">Yes</option>
                                       <option <cfif sel_route_available EQ 'no'>selected="selected"</cfif> value="no">No</option>
                                    </select>
                                    <div class="invalid-feedback">
                                       Please choose availability today.
                                    </div>
                                 </div>
                              </div>
                              <div class="col-4">
                                 <div class="mb-3">
                                    <cfif structKeyExists(Session,'admin_form') AND structKeyExists(Session.admin_form, 'bus_days')>
                                          <cfset sel_bus_days = Session.admin_form.bus_days />
                                       <cfelse>
                                          <cfset sel_bus_days = '' />
                                    </cfif>
                                    <label for="bus-days" class="form-label">Bus Days</label>
                                    <select name="bus_days" class="form-control" id="bus-days" multiple style="height: 200px;">
                                       <option selected disabled value="">Select bus available days</option>
                                       <option value="sun" <cfif FindNoCase('sun',sel_bus_days)>selected="selected"</cfif> >Sunday</option>
                                       <option value="mon" <cfif FindNoCase('mon',sel_bus_days)>selected="selected"</cfif> >Monday</option>
                                       <option value="tue" <cfif FindNoCase('tue',sel_bus_days)>selected="selected"</cfif> >Tuesday</option>
                                       <option value="wed" <cfif FindNoCase('wed',sel_bus_days)>selected="selected"</cfif> >Wednesday</option>
                                       <option value="thu" <cfif FindNoCase('thu',sel_bus_days)>selected="selected"</cfif> >Thursday</option>
                                       <option value="fri" <cfif FindNoCase('fri',sel_bus_days)>selected="selected"</cfif> >Friday</option>
                                       <option value="sat" <cfif FindNoCase('sat',sel_bus_days)>selected="selected"</cfif> >Saturday</option>
                                    </select>
                                    <div class="invalid-feedback">
                                       Please choose availability today.
                                    </div>
                                 </div>
                              </div>
                           </div>
                           <div class="row gx-5 gy-3">
                              <div class="col-4">
                                 <div class="mb-3">
                                    <label for="departure-time" class="form-label">Departure Time</label>
                                    <input type="time" class="form-control" name="departure_time" id="departure-time" value="<cfif structKeyExists(Session,'admin_form') AND structKeyExists(Session.admin_form, 'departure_time')>#Session.admin_form.departure_time#</cfif>" required>
                                    <div class="invalid-feedback">
                                       Please choose departure time.
                                    </div>
                                 </div>
                              </div>
                              <div class="col-4">
                                 <div class="mb-3">
                                    <label for="arrival-time" class="form-label">Arrival Time</label>
                                    <input type="time" class="form-control" name="arrival_time" id="arrival-time" value="<cfif structKeyExists(Session,'admin_form') AND structKeyExists(Session.admin_form, 'arrival_time')>#Session.admin_form.arrival_time#</cfif>"  required>
                                    <div class="invalid-feedback">
                                       Please choose arrival time.
                                    </div>
                                 </div>
                              </div>
                              <div class="col-4">
                                 <cfset csrftoken= CSRFGenerateToken()/>
                                 <input type="hidden" name="csrftoken" value="<cfoutput>#csrfToken#</cfoutput>" />
                                 <div class="mb-3">
                                    <label for="bus-price" class="form-label">Price</label>
                                    <input type="number" class="form-control" name="bus_price" id="bus-price" value="<cfif structKeyExists(Session,'admin_form') AND structKeyExists(Session.admin_form, 'bus_price')>#Session.admin_form.bus_price#</cfif>"  required>
                                    <div class="invalid-feedback">
                                       Please add bus price.
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>

                  
                  <button type="submit" class="btn app-btn-primary" >Save Changes</button>
               </form>

               <cfset Session.admin_status  = '' />
               <cfset Session.admin_message = '' />
               <cfset Session.admin_form    = structNew() />
            </cfoutput>
         </div>
      </div>
   </div>
</div>
<script>
   (function () {
     'use strict'

     var forms = document.querySelectorAll('.needs-validation')

     Array.prototype.slice.call(forms)
       .forEach(function (form) {
         form.addEventListener('submit', function (event) {
           if (!form.checkValidity()) {
             event.preventDefault()
             event.stopPropagation()
           }

           form.classList.add('was-validated')
         }, false)
       })
   })()
</script>
<cfinclude  template = "include/footer.cfm"  runOnce = "true">                    