<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="icon" href="assets/bus_logo.png">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <title>Bus Ticket Reservation</title>
</head>
<body>
    <div class="nav">
        <div class="logo">
            <img src="assets/bus_logo.png" class="logo-img" alt="logo">
            <p>Ticket+</p>
        </div>
        <div class="search-box">
            <form class="search-form" action="" method="post">
                <div class="form-div">
                    <label>Pick-Up From</label>
                    <input type="text" class="form-input" name="from" id="from" placeholder="where are you from" required onkeyup="handleLocation(this.value,'from')">
                    <input type="hidden" name="loc_id_from" id="loc_id_from" value=""/>
                    <span id="loc-list"> </span> 
                </div>
                <div class="exchange">
                    <i class="fa fa-exchange"></i>
                </div>
                <div class="form-div">
                    <label>Drop To</label>
                    <input type="text" class="form-input" name="to" id="to" placeholder="select your destination" required onkeyup="handleLocation(this.value,'to')">
                    <input type="hidden" name="loc_id_to" id="loc_id_to" value=""/>
                    <span id="loc-list-to"> </span>
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
            <cfif structKeyExists(session, "userId")>
                <cfoutput>
                    <div class="dropdown">
                        <button class="btn btn-secondary drpbtn dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fa fa-user"></i> #session.name#
                        </button>
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                            <li><a class="dropdown-item" href="components/user.cfc?method=logout">Logout</a></li>
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
</body>
</html>

<!--- To handle location list
<script>
    function handleLocation(loc,sec){
    $.ajax({
        type: "GET",
        dataType: "html",
        url: "cfc/search.cfc?method=locFunction",
        data: {loc:loc,sec:sec},
            success:function(res){
                if(sec === "from"){
                    $('#loc-list').html(res);
                }
                else{
                    $('#loc-list-to').html(res);
                }
            
            }
        });
    }
</script>
--->
<script>
function handleLocation(loc,sec){
    var url    = "cfc/search.cfc";
    var params = "method=locFunction&loc="+loc+"&sec="+sec;
    var xhr    = new XMLHttpRequest();
    xhr.open("get",url+"?"+params);
    xhr.send();
    xhr.onreadystatechange = function(){
        if(sec === "from"){
            document.getElementById("loc-list").innerHTML = this.responseText;
        }
        else{
           document.getElementById("loc-list-to").innerHTML = this.responseText; 
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
function handleSearch(event) {
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