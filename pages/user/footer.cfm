
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
            xhttp.open("POST", "../../cfc/user.cfc?method=fbLogin&emailId="+userData.email+"&firstName="+userData.first_name+"&lastName="+userData.last_name+"&token="+userData.id, true);
            xhttp.send();
        }

        document.getElementById("registerBtn").disabled = true

        function checkPassword(){
            var password = document.getElementById("password").value;
            var cPassword = document.getElementById("cPassword").value
            
            if(password == cPassword){
                document.getElementById("registerBtn").disabled = false
                document.getElementById("message").innerHTML = ""
            }
            else{
                document.getElementById("registerBtn").disabled = true
                document.getElementById("message").innerHTML = "Password not matched"
            }
        }

        document.getElementById("cPassword").addEventListener("change", checkPassword);
    </script>

    <script>
        function handleLocation(loc,sec){
            var url    = "../../cfc/search.cfc";
            var params = "method=locFunction&loc="+loc+"&sec="+sec;
            var xhr    = new XMLHttpRequest();
            xhr.open("get",url+"?"+params);
            xhr.send();
            xhr.onreadystatechange = function(){
                if(sec === "from"){
                    if(document.getElementById("from").value != ""){
                        document.getElementById("loc-list").innerHTML = this.responseText;
                    }
                    else{
                        document.getElementById("loc-list").innerHTML = "";
                    }
                }
                else{
                    if(document.getElementById("to").value != ""){
                        document.getElementById("loc-list-to").innerHTML = this.responseText; 
                    }
                    else{
                        document.getElementById("loc-list-to").innerHTML = "";
                    }
                }
            }
        }
    </script>

    <!--- To handle select location--->
    <script>
        function listHandle(id,name,sec) {
            if(sec ==="from"){
                document.getElementById("from").value = name;
                document.getElementById("loc_id_from").value = id;
                document.getElementById("loc-list").innerHTML = "";
            }
            else{
                document.getElementById("to").value = name;
                document.getElementById("loc_id_to").value = id;
                document.getElementById("loc-list-to").innerHTML = "";
            }

        }
    </script>

    <!--- To handle form validation --->
    <script>
        function handleSearch(event){
            <!--- for validation --->
            var locfrom = document.getElementById("from").value;
            var locto   = document.getElementById("to").value;
            var jdate   = document.getElementById("date").value;
            if(locfrom ==""){
                event.preventDefault();  
                document.getElementById('from-error').innerHTML = "please select origin location";
                return false; 
            }
            if(locto ==""){
                event.preventDefault(); 
                document.getElementById('to-error').innerHTML = "please select destination location";
                return false;  
            }
            if(jdate ===""){
                event.preventDefault(); 
                document.getElementById('date-error').innerHTML = "please select date";
                return false;  
            }
            else{
                document.getElementById('jrn-date').innerHTML = "";
            }
            if((locfrom !=="") && (!locto !=="")){
                if(locfrom == locto){
                    event.preventDefault(); 
                    document.getElementById('to-error').innerHTML = "Origin and Destination location cannot be the same";
                    return false;  
                }
            }
            <!--- after submit --->
            var locf_id = document.getElementById("loc_id_from").value;
            var loct_id = document.getElementById("loc_id_to").value;
            var xhr     = new XMLHttpRequest();
            xhr.open("post","../../cfc/search.cfc?method=Listfunction&loc_f="+locf_id+"&loc_t="+loct_id+"&date="+jdate);
            xhr.send();
            xhr.onreadystatechange = function(){
                if(document.getElementById("banner")){
                    document.getElementById("banner").style.display = "none";
                }
                document.getElementById("buses").style.display = "block";
                document.getElementById("listing-div").innerHTML = this.responseText;
            }    
        }
    </script>

    <!--- To handle toggle button click --->
    <script>
        function handleToggle(){
            var locfrom = document.getElementById("from").value;
            var locto   = document.getElementById("to").value;
            var from_id = document.getElementById("loc_id_from").value;
            var to_id   = document.getElementById("loc_id_to").value;

            if((locfrom !=="")&&(locto !=="")){
                document.getElementById("to").value          = locfrom;
                document.getElementById("from").value        = locto;
                document.getElementById("loc_id_from").value = to_id;
                document.getElementById("loc_id_to").value   = from_id;
            }
        }
    </script>
</body>
</html>