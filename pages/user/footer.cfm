    <cfif structKeyExists(session, 'alert_status') AND len(trim(session.alert_status))  GT 0 >
        <cfset structDelete(session, "alert_status")>
        <cfset structDelete(session, "alert_message")>
    </cfif>

    <script>
        setTimeout(() => {
            document.querySelectorAll('.alert').forEach(function(alert) {
                alert.classList.add('d-none');
            });
        }, 3000);
    </script>

    <script type="text/javascript" src="../../assets/user/js/search.js"></script> 
    <script>
        var today = new Date().toISOString().split('T')[0];
        document.getElementsByName("date")[0].setAttribute('min', today);
    
        window.fbAsyncInit = function() {
            FB.init({
            appId      : '2505849812882244',
            xfbml      : true,
            version    : 'v12.0'
            });
            FB.AppEvents.logPageView();
        };
    
    <script type="text/javascript" src="../../assets/user/js/login.js"></script> 
    <script type="text/javascript" src="../../assets/user/js/search.js"></script> 
    <script type="text/javascript" src="../../assets/user/js/search.js"></script>
    

</body>
</html>