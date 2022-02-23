<cfinclude  template="header.cfm">
<cfset user           = createObject("component","bookbus/cfc/userDetails")/>
<cfset user_details   = user.userDetail()/> 

<div class="buses" id="buses" style="display: block;">
    <div class="user-detail">
        <cfoutput>
            <p id="det">Name: #user_details.fullname#<br></p>
            <p id="det">Email:#user_details.email#<br>
        </cfoutput>
    </div>
</div>

<cfinclude  template="footer.cfm">
