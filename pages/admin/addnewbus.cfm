<cfinclude  template = "include/header.cfm"  runOnce = "true">

<h1 class="app-page-title">Add New Bus</h1>
<hr class="mb-4">
<div class="row g-4 settings-section align-items-center justify-content-center">
   <div class="col-12 col-md-8">
      <div class="app-card app-card-settings shadow-sm p-4">
         <div class="app-card-body">
            <form class="settings-form">
               <div class="mb-3">
                  <label for="setting-input-1" class="form-label">
                     Business Name
                     <span class="ms-2" data-container="body" data-bs-toggle="popover" data-trigger="hover" data-placement="top" data-content="This is a Bootstrap popover example. You can use popover to provide extra info.">
                        <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-info-circle" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                           <path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                           <path d="M8.93 6.588l-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588z"/>
                           <circle cx="8" cy="4.5" r="1"/>
                        </svg>
                     </span>
                  </label>
                  <input type="text" class="form-control" id="setting-input-1" value="Lorem Ipsum Ltd." required>
               </div>
               <div class="mb-3">
                  <label for="setting-input-2" class="form-label">Contact Name</label>
                  <input type="text" class="form-control" id="setting-input-2" value="Steve Doe" required>
               </div>
               <div class="mb-3">
                  <label for="setting-input-3" class="form-label">Business Email Address</label>
                  <input type="email" class="form-control" id="setting-input-3" value="hello@companywebsite.com">
               </div>

               <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" value="" id="settings-checkbox-3">
                    <label class="form-check-label" for="settings-checkbox-3">
                        Keep user app search history
                    </label>
                </div>
                <div class="form-check form-switch mb-3">
                    <input class="form-check-input" type="checkbox" id="settings-switch-1" checked>
                    <label class="form-check-label" for="settings-switch-1">Project notifications</label>
                </div>
               <div class="app-card-body">
                    <div class="mb-2"><strong>Status:</strong> <span class="badge bg-success">Active</span></div>
                    <div class="mb-4"><strong>Invoices:</strong> <a href="#">view</a></div>
				</div>
               <button type="submit" class="btn app-btn-primary" >Save Changes</button>
            </form>
         </div>
      </div>
   </div>
</div>

<cfinclude  template = "include/footer.cfm"  runOnce = "true">                    