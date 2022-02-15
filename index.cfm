<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="icon" href="assets/bus_logo.png">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/index.css">
    <title>Bus Ticket Reservation</title>
</head>
<body>
    
    <cfinclude  template="header.cfm">

    <div id="searchResult"></div>
        
    <div class="banner">
        <img src="assets/banner.png" alt="banner">
    </div>

    <div class="modal fade" id="loginModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="loginModalLabel">Login</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="components/user.cfc?method=login" method="post">
                        <div class="form-div">
                            <label>User Name</label>
                            <input type="text" class="form-input" name="userName" placeholder="Enter your User Name" required>
                        </div>
                        <div class="form-div">
                            <label>Password</label>
                            <input type="password" class="form-input" name="password" placeholder="Password" required>
                        </div>
                        <button class="btn btn-success">Submit</button>
                    </form>

                    <div class="social-login">
                        <a href="javascript:void(0);" onclick="FbLogin();" id="fbLink">
                            <button class="social-btn fb">f</button>
                        </a>
                        <a href="components/user.cfc?method=googleLogin">
                            <button class="social-btn google">G</button>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="registerModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="registerModalLabel">Register</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="components/user.cfc?method=register" method="post">
                        <input type="text" class="form-input" name="name" placeholder="Enter your name" required>
                        <input type="text" class="form-input" name="userName" placeholder="Enter your user name" required>
                        <input type="text" class="form-input" name="emailId" placeholder="Enter your emailid" required>
                        <input type="text" class="form-input" name="phoneNumber" placeholder="Enter your phone number" required>
                        <select class="form-input" name="role" required>
                            <option disabled selected value="">select your role</option>
                        </select>
                        <input type="password" class="form-input" id="password" name="password" placeholder="Enter your password" required>
                        <input type="password" class="form-input" id="cPassword" name="cPassword" placeholder="Confirm password">
                        <p id="message"></p>
                        <button class="btn btn-success" id="registerBtn" name="submit">Submit</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    
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