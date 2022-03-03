<cfset csrftoken= CSRFGenerateToken()/>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="icon" href="../../assets/bus_logo.png">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../../assets/user/css/style.css">
    <link rel="stylesheet" href="../../assets/user/css/index.css">
    <link rel="stylesheet" href="../../assets/fontAwesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="../../assets/bootstrap/css/bootstrap.min.css">
    <script src="../../assets/bootstrap/js/bootstrap.bundle.min.js"></script>
    <title>Bus Ticket Reservation</title>
</head>
<body>
    <div class="nav">
        <div class="logo">
            <img src="../../assets/bus_logo.png" class="logo-img" alt="logo">
            <p>Ticket+</p>
        </div>
        <div class="search-box">
            <cfoutput>
                <form class="search-form" method="post">
                    <div class="form-div">
                        <label>Pick-Up From</label>
                        <input type="text" class="form-input" name="from" id="from" placeholder="where are you from" onkeyup="handleLocation(this.value,'from')" required>
                        <input type="hidden" name="loc_id_from" id="loc_id_from" value=""/>
                        <input name="csrftoken" type="hidden" value="#csrfToken#">
                        <span class="error" id="from-error"></span>
                        <ul class="list-group" id="loc-list"></ul>
                    </div>
                    <div class="exchange">
                        <i class="fa fa-exchange" onclick="handleToggle()"></i>
                    </div>
                    <div class="form-div">
                        <label>Drop To</label>
                        <input type="text" class="form-input" name="to" id="to" placeholder="select your destination" onkeyup="handleLocation(this.value,'to')" required>
                        <input type="hidden" name="loc_id_to" id="loc_id_to" value=""/>
                        <span class="error" id="to-error"></span>
                        <ul class="list-group" id="loc-list-to"></ul>
                    </div>
                    <div class="form-div">
                        <label>Date</label>
                        <input type="date" class="form-input" name="date" id="date" required>
                        <span class="error" id="date-error"></span>
                        <span id="jrn-date"> </span>
                    </div>
                    <button type="button" class="btn search-btn" onClick="handleSearch(event)">
                        <i class="fa fa-search"></i>
                    </button>
                </form>
            </cfoutput>
        </div>
        <div class="user-details">
            <cfif structKeyExists(session, "id")>
                <cfoutput>
                    <div class="dropdown">
                        <button class="btn btn-secondary drpbtn dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fa fa-user"></i> #session.name#
                        </button>
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                            <li><a class="dropdown-item" href="profile.cfm">Profile</a></li>
                            <li><a class="dropdown-item" href="bookingHistory.cfm">Journey Histories</a></li>
                            <li><a class="dropdown-item" href="upcommingBooking.cfm">Upcomming Journeys</a></li>
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
    
<!---     alerts     --->
    <cfoutput>
        <cfif structKeyExists(session, 'alert_status') AND len(trim(session.alert_status))  GT 0 >
            <div class="alert alert-<cfif session.alert_status EQ 'success'>success<cfelseif session.alert_status EQ 'error'>danger</cfif> " role="alert">
                #session.alert_message#
            </div>
        </cfif>
    </cfoutput>

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
                    <cfoutput>
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
                    </cfoutput>
                </div>
            </div>
        </div>
    </div>

    <!--- for listing --->
    <div class="buses" id="buses">
        <span id="listing-div"></span>
        <p id="bus-message"></p>
    </div>
    
