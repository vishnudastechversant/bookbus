<cfinclude  template = "include/header.cfm"  runOnce = "true">

<h1 class="app-page-title">Add New Bus</h1>
<hr class="mb-4">
<div class="row g-4 settings-section align-items-center justify-content-center">
   <div class="col-12 col-md-8">
      <div class="app-card app-card-settings shadow-sm p-4">
         <div class="app-card-body">
            <form class="addbus-form needs-validation" enctype="multipart/form-data" name="addbus-form" id="addbus-form" onsubmit="return addSubmit(event)" novalidate>
               <div class="mb-3">
                  <label for="bus-name" class="form-label">
                     Bus Name
                  </label>
                  <input type="text" class="form-control" name="bus-name" id="bus-name" required>
                  <div class="invalid-feedback">
                     Please provide a valid bus name.
                   </div>
               </div>
               <div class="mb-3">
                  <label for="bus-type" class="form-label">Bus Type</label>
                  <select name="bus-type" class="form-control" id="bus-type" required>
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
                  <select name="layout-type" class="form-control" id="layout-type" required>
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
                  <select name="available-today" class="form-control" id="available-today">
                     <option value="1">Yes</option>
                     <option value="0">No</option>
                  </select>
                  <div class="invalid-feedback">
                     Please choose availability.
                   </div>
               </div>
               <div class="mb-3">
                  <label for="seat-count" class="form-label">Number of seats</label>
                  <input type="number" class="form-control" name="seat-count" id="seat-count" min="0" required>
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
                                 <input type="text" class="form-control" name="route-from" id="route-from" required>
                                 <div class="invalid-feedback">
                                    Please provide route from.
                                 </div>
                              </div>
                           </div>
                           <div class="col-4">
                              <div class="mb-3">
                                 <label for="route-to" class="form-label">Route To</label>
                                 <input type="text" class="form-control" name="route-to" id="route-to" required>
                                 <div class="invalid-feedback">
                                    Please provide route to.
                                  </div>
                              </div>
                           </div>
                           <div class="col-4">
                              <div class="mb-3">
                                 <label for="main-route" class="form-label">Main Route</label>
                                 <select name="main-route" class="form-control" id="main-route">
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
                                 <select name="daily-bus" class="form-control" id="daily-bus">
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
                                 <select name="route-available" class="form-control" id="route-available">
                                    <option value="yes">Yes</option>
                                    <option value="no">No</option>
                                 </select>
                                 <div class="invalid-feedback">
                                    Please choose availability today.
                                 </div>
                              </div>
                           </div>
                           <div class="col-4">
                           </div>
                        </div>
                        <div class="row gx-5 gy-3">
                           <div class="col-4">
                              <div class="mb-3">
                                 <label for="departure-time" class="form-label">Departure Time</label>
                                 <input type="text" class="form-control" name="departure-time" id="departure-time" required>
                                 <div class="invalid-feedback">
                                    Please choose departure time.
                                 </div>
                              </div>
                           </div>
                           <div class="col-4">
                              <div class="mb-3">
                                 <label for="arrival-time" class="form-label">Arrival Time</label>
                                 <input type="text" class="form-control" name="arrival-time" id="arrival-time" required>
                                 <div class="invalid-feedback">
                                    Please choose arrival time.
                                 </div>
                              </div>
                           </div>
                           <div class="col-4">
                           </div>
                        </div>
                        <!--<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>-->
                     </div>
                  </div>
               </div>

               
               <button type="submit" class="btn app-btn-primary" >Save Changes</button>
            </form>
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