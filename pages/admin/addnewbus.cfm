<cfinclude  template = "include/header.cfm"  runOnce = "true">

<h1 class="app-page-title">Add New Bus</h1>
<hr class="mb-4">
<div class="row g-4 settings-section align-items-center justify-content-center">
   <div class="col-12 col-md-8">
      <div class="app-card app-card-settings shadow-sm p-4">
         <div class="app-card-body">
            <cfoutput>
               <cfif structKeyExists(Session, 'admin_status') AND len(trim(Session.admin_status))  > 0 >
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
            <cfdump var="#Session#" />
            <cfoutput>
               <form class="addbus-form needs-validation" method="POST" action="../../cfc/admin/buses.cfc?method=addbus" name="addbus-form" id="addbus-form" onsubmit="return addSubmit(event)" novalidate>
                  <div class="mb-3">
                     <label for="bus-name" class="form-label">
                        Bus Name
                     </label>
                     <input type="text" class="form-control" name="bus_name" id="bus-name" required>
                     <div class="invalid-feedback">
                        Please provide a valid bus name.
                      </div>
                  </div>
                  <div class="mb-3">
                     <label for="bus-type" class="form-label">Bus Type</label>
                     <select name="bus_type" class="form-control" id="bus-type" required>
                        <option selected disabled value="">Select a bus type</option>
                        <option value="Seater">Seater</option>
                        <option value="Sleeper">Sleeper</option>
                        <option value="AC">AC</option>
                        <option value="NonAC">NonAC</option>
                     </select>
                     <div class="invalid-feedback">
                        Please select a bus type.
                     </div>
                  </div>
                  <div class="mb-3">
                     <label for="layout-type" class="form-label">Layout Type</label>
                     <select name="layout_type" class="form-control" id="layout-type" required>
                        <option selected disabled value="">Select a layout type</option>
                        <option value="seater">Seater</option>
                        <option value="sleeper">Sleeper</option>
                     </select>
                     <div class="invalid-feedback">
                        Please select a layout type.
                      </div>
                  </div>
                  <div class="mb-3">
                     <label for="available-today" class="form-label">Available Today (Default Yes)</label>
                     <select name="available_today" class="form-control" id="available-today">
                        <option value="1">Yes</option>
                        <option value="0">No</option>
                     </select>
                     <div class="invalid-feedback">
                        Please choose availability.
                      </div>
                  </div>
                  <div class="mb-3">
                     <label for="seat-count" class="form-label">Number of seats</label>
                     <input type="number" class="form-control" name="seat_count" id="seat-count" min="0" required>
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
                                    <input type="text" class="form-control" name="route_from" id="route-from" required>
                                    <div class="invalid-feedback">
                                       Please provide route from.
                                    </div>
                                 </div>
                              </div>
                              <div class="col-4">
                                 <div class="mb-3">
                                    <label for="route-to" class="form-label">Route To</label>
                                    <input type="text" class="form-control" name="route_to" id="route-to" required>
                                    <div class="invalid-feedback">
                                       Please provide route to.
                                     </div>
                                 </div>
                              </div>
                              <div class="col-4">
                                 <div class="mb-3">
                                    <label for="main-route" class="form-label">Main Route</label>
                                    <select name="main_route" class="form-control" id="main-route">
                                       <option value="yes">Yes</option>
                                       <option value="no">No</option>
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
                                    <label for="daily-bus" class="form-label">Daily Bus</label>
                                    <select name="daily_bus" class="form-control" id="daily-bus">
                                       <option value="yes">Yes</option>
                                       <option value="no">No</option>
                                    </select>
                                    <div class="invalid-feedback">
                                       Please choose daily bus availablitys.
                                    </div>
                                 </div>
                              </div>
                              <div class="col-4">
                                 <div class="mb-3">
                                    <label for="route-available" class="form-label">Available Today</label>
                                    <select name="route_available" class="form-control" id="route-available">
                                       <option value="yes">Yes</option>
                                       <option value="no">No</option>
                                    </select>
                                    <div class="invalid-feedback">
                                       Please choose availability today.
                                    </div>
                                 </div>
                              </div>
                              <div class="col-4">
                                 <div class="mb-3">
                                    <label for="bus-days" class="form-label">Bus Days</label>
                                    <select name="bus_days" class="form-control" id="bus-days" multiple style="height: 200px;">
                                       <option selected disabled value="">Select bus available days</option>
                                       <option value="sun">Sunday</option>
                                       <option value="mon">Monday</option>
                                       <option value="tue">Tuesday</option>
                                       <option value="wed">Wednesday</option>
                                       <option value="thu">Thursday</option>
                                       <option value="fri">Friday</option>
                                       <option value="sat">Saturday</option>
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
                                    <input type="time" class="form-control" name="departure_time" id="departure-time" required>
                                    <div class="invalid-feedback">
                                       Please choose departure time.
                                    </div>
                                 </div>
                              </div>
                              <div class="col-4">
                                 <div class="mb-3">
                                    <label for="arrival-time" class="form-label">Arrival Time</label>
                                    <input type="time" class="form-control" name="arrival_time" id="arrival-time" required>
                                    <div class="invalid-feedback">
                                       Please choose arrival time.
                                    </div>
                                 </div>
                              </div>
                              <div class="col-4">
                                 <cfset csrftoken= CSRFGenerateToken()/>
                                 <input type="hidden" name="csrftoken" value="<cfoutput>#csrfToken#</cfoutput>" />
                              </div>
                           </div>
                           <!--<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>-->
                        </div>
                     </div>
                  </div>

                  
                  <button type="submit" class="btn app-btn-primary" >Save Changes</button>
               </form>
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