
    <script>
        //login with fb
        window.fbAsyncInit = function() {
            FB.init({
            appId      : '2505849812882244',
            xfbml      : true,
            version    : 'v12.0'
            });
            FB.AppEvents.logPageView();
        };

        (function(d, s, id){
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) {return;}
            js = d.createElement(s); js.id = id;
            js.src = "https://connect.facebook.net/en_US/sdk.js";
            fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));
      
        function FbLogin() {
            FB.login(function (response) {
                if (response.authResponse) {
                    getFbUserData();
                } else {
                    document.getElementById('status').innerHTML = 'User cancelled login or did not fully authorize.';
                }
            }, {scope: 'email'});
        }
      
        function getFbUserData(){
            FB.api('/me', {locale: 'en_US', fields: 'id,first_name,last_name,email,link,gender,locale,picture'},
            function (response) {                
                saveUserData(response);                
            });
        }

        // Save user data to the database
        function saveUserData(userData){
            var data = JSON.stringify(userData);

            const xhttp = new XMLHttpRequest();
            xhttp.onload = function(){
                window.location.href = "dashboard.cfm"
            }
            xhttp.open("POST", "components/user.cfc?method=fbLogin&emailId="+userData.email+"&firstName="+userData.first_name+"&lastName="+userData.last_name, true);
            xhttp.send();
        }
    </script>
</body>
</html>