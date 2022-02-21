<cfinclude  template = "include/header.cfm"  runOnce = "true">

<h1 class="app-page-title">City</h1>
<hr class="mb-4">
<div class="row g-4 settings-section align-items-center justify-content-center">
   <div class="col-12 col-md-8">
      <div class="app-card app-card-settings shadow-sm p-4">
         <div class="app-card-body">
            <form method="post" action="../../cfc/admin/city.cfc" class="settings-form">
              
                <div class="mb-3">
                  <label for="setting-input-2" class="form-label">Select State</label>
                  <select class="form-control">
                    <option value="">--select--</option>
                  </select>
                </div>
               <div class="mb-3">
                  <label for="setting-input-2" class="form-label">City Name</label>
                  <input type="text" class="form-control" id="setting-input-2" required>
               </div>
               
               <button type="submit" class="btn app-btn-primary" >Save</button>
            </form>
         </div>
      </div>
   </div>
</div>

<cfinclude  template = "include/footer.cfm"  runOnce = "true">                    