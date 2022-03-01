    <cfif structKeyExists(session, 'alert_status') AND len(trim(session.alert_status))  GT 0 >
        <cfset structDelete(session, "alert_status")>
        <cfset structDelete(session, "alert_message")>
    </cfif>
    
    <script type="text/javascript" src="../../assets/user/js/login.js"></script> 
    <script type="text/javascript" src="../../assets/user/js/search.js"></script>
    
</body>
</html>