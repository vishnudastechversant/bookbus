<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="icon" href="../../assets/bus_logo.png">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../../assets/user/css/style.css">
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
                    <input type="text" class="form-input" name="from" placeholder="where are you from" required>
                </div>
                <div class="exchange">
                    <i class="fa fa-exchange"></i>
                </div>
                <div class="form-div">
                    <label>Drop To</label>
                    <input type="text" class="form-input" name="to" placeholder="select your destination" required>
                </div>
                <div class="form-div">
                    <label>Date</label>
                    <input type="date" class="form-input" name="date" required>
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

    <div>