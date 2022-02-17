<cfscript>
    csrftoken= CSRFGenerateToken();
</cfscript>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="icon" href="../../assets/bus_logo.png">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../../assets/user/css/style.css">
    <link rel="stylesheet" href="../../assets/user/css/index.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <title>Bus Ticket Reservation</title>
</head>
<body>
    <div class="nav">
        <div class="logo">
            <img src="../../assets/bus_logo.png" class="logo-img" alt="logo">
            <p>Ticket+</p>
        </div>
        <div class="search-box">
            <form class="search-form" action="" method="post">
                <div class="form-div">
                    <label>Pick-Up From</label>
                    <input type="text" class="form-input" name="from" id="from" placeholder="where are you from" onkeyup="handleLocation(this.value,'from')" required>
                    <input type="hidden" name="loc_id_from" id="loc_id_from" value=""/>
                    <ul class="list-group" id="loc-list"></ul>
                </div>
                <div class="exchange">
                    <i class="fa fa-exchange" onclick="handleToggle()"></i>
                </div>
                <div class="form-div">
                    <label>Drop To</label>
                    <input type="text" class="form-input" name="to" id="to" placeholder="select your destination" onkeyup="handleLocation(this.value,'to')" required>
                    <input type="hidden" name="loc_id_to" id="loc_id_to" value=""/>
                    <ul class="list-group" id="loc-list-to"></ul>
                </div>
                <div class="form-div">
                    <label>Date</label>
                    <input type="date" class="form-input" name="date" id="date" required>
                    <span id="jrn-date"> </span>
                </div>
                <button class="btn search-btn" onclick="handleSearch(event)">
                    <i class="fa fa-search"></i>
                </button>
            </form>
        </div>
        <div class="user-details">
            <cfif structKeyExists(session, "id")>
                <cfoutput>
                    <div class="dropdown">
                        <button class="btn btn-secondary drpbtn dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fa fa-user"></i> #session.name#
                        </button>
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                            <li><a class="dropdown-item" href="../../cfc/user.cfc?method=logout">Logout</a></li>
                        </ul>
                    </div>
                </cfoutput>
            <cfelse>
                <a data-bs-toggle="modal" data-bs-target="#loginModal" href="">Login</a>
                <a data-bs-toggle="modal" data-bs-target="#registerModal" href="">Sign up</a>
            </cfif>
        </div>
    </div>  

    <div class="modal fade" id="loginModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="loginModalLabel">Login</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="../../cfc/user.cfc?method=login" method="post">
                        <div class="form-div">
                            <label>Email Id</label>
                            <input type="text" class="form-input" name="emailId" placeholder="Enter your email id" required>
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
                        <a href="../../cfc/user.cfc?method=googleLogin">
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
                    <form action="../../cfc/user.cfc?method=register" method="post">
                        <div class="form-div">
                            <label>Full Name</label>
                            <input type="text" class="form-input" name="name" placeholder="Enter your name" required>
                        </div>
                        <div class="form-div">
                            <label>Email Id</label>
                            <input type="text" class="form-input" name="emailId" placeholder="Enter your emailid" required>
                        </div>
                        <div class="form-div">
                            <label>Role</label>
                            <select class="form-input" name="role" required>
                                <option disabled selected value="">select your role</option>
                                <option value="1">Admin</option>
                                <option value="2">Customer</option>
                            </select>
                        </div>
                        <div class="form-div">
                            <label>Password</label>
                            <input type="password" class="form-input" id="password" name="password" placeholder="Enter your password" required>
                        </div>
                        <div class="form-div">
                            <label>Confirm password</label>
                            <input type="password" class="form-input" id="cPassword" name="cPassword" placeholder="Confirm password">
                        </div>
                        <p id="message"></p>
                        <button class="btn btn-success" id="registerBtn" name="submit">Submit</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

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
                }
                else{
                    if(document.getElementById("to").value != ""){
                        document.getElementById("loc-list-to").innerHTML = this.responseText; 
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

    <!--- To handle search button click --->
    <script>
        function handleSearch(event){
            <!--- for validation --->
            var locfrom = document.getElementById("from").value;
            var locto   = document.getElementById("to").value;
            var jdate   = document.getElementById("date").value;
            if(locfrom ==""){
                event.preventDefault();  
                document.getElementById('loc-list').innerHTML = "please select origin location"; 
            }
            if(locto ==""){
                event.preventDefault(); 
                document.getElementById('loc-list-to').innerHTML = "please select destination location"; 
            }
            if(jdate ===""){
                event.preventDefault(); 
                document.getElementById('jrn-date').innerHTML = "please select date"; 
            }
            else{
                event.preventDefault(); 
                document.getElementById('jrn-date').innerHTML = "";
            }
            if((locfrom !=="") && (!locto !=="")){
                if(locfrom == locto){
                    event.preventDefault(); 
                    document.getElementById('loc-list-to').innerHTML = "Origin and Destination location cannot be the same"; 
                }
            }
        }
    </script>
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

