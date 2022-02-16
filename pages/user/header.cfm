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
                    <input type="text" class="form-input" name="from" placeholder="where are you from" onkeyup="handleLocation(this.value,'from')" required>
                    <input type="hidden" name="loc_id_from" id="loc_id_from" value=""/>
                    <span id="loc-list"> </span>
                </div>
                <div class="exchange">
                    <i class="fa fa-exchange"></i>
                </div>
                <div class="form-div">
                    <label>Drop To</label>
                    <input type="text" class="form-input" name="to" placeholder="select your destination" onkeyup="handleLocation(this.value,'to')" required>
                    <input type="hidden" name="loc_id_to" id="loc_id_to" value=""/>
                    <span id="loc-list-to"> </span>
                </div>
                <div class="form-div">
                    <label>Date</label>
                    <input type="date" class="form-input" name="date" required>
                    <span id="jrn-date"> </span>
                </div>
                <button class="btn search-btn">
                    <i class="fa fa-search"></i>
                </button>
            </form>
        </div>
        <div class="user-details">
            <cfif structKeyExists(session, "userId")>
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
                <!--<button class="btn" onclick="loginPopup()">Login</button>-->
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
                        <input type="text" class="form-input" name="name" placeholder="Enter your name" required>
                        <input type="text" class="form-input" name="userName" placeholder="Enter your user name" required>
                        <input type="text" class="form-input" name="emailId" placeholder="Enter your emailid" required>
                        <input type="text" class="form-input" name="phoneNumber" placeholder="Enter your phone number" required>
                        <select class="form-input" name="role" required>
                            <option disabled selected value="">select your role</option>
                            <option value="1">Admin</option>
                            <option value="2">Bus Owner</option>
                            <option value="3">Traveller</option>
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
