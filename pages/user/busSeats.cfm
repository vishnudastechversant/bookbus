<cfinclude  template="header.cfm">
<cfset layout_name = "layout">
<div class="container">
    <div class="row">
        <div class="col-md-8 bg-success">
            <div class="d-flex justify-content-center">
                <cfinclude  template="layouts/#layout_name#.cfm">
            </div>
        </div>
        <div class="col-md-4"></div>
    </div>
</div>
<cfinclude  template="footer.cfm">