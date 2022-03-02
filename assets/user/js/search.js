function handleLocation(loc,sec){
    var url    = "../../cfc/search.cfc";
    var params = "method=locFunction&loc="+loc+"&sec="+sec;
    var xhr    = new XMLHttpRequest();
    xhr.open("get",url+"?"+params);
    xhr.send();
    xhr.onreadystatechange = function()
    {
        if(xhr.readyState == 4){
            if(xhr.status == 200){
                var res = JSON.parse(xhr.responseText);
                console.log(res);
                    for(i=0;i<res.length;i++){
                        var curr = res[i];
                            var html_cont = html_cont+"<li class=list-group-item onclick=listHandle("+curr['id']+",'"+curr['city']+"','"+sec+"')>"+curr['city']+" </li>";
                    }
            }
        }
        if(sec === "from"){
            if(document.getElementById("from").value != ""){
                    document.getElementById("loc-list").innerHTML = html_cont;                
            }           
            else{
                document.getElementById("loc-list").innerHTML = "";
            }
        }
        else{
            if(document.getElementById("to").value != ""){
                document.getElementById("loc-list-to").innerHTML = html_cont;
            }
            else{
                document.getElementById("loc-list-to").innerHTML = "";
            }
        }
    }
}
//To handle select location
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

//To handle form validation

function handleSearch(event){
    //for validation
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
   //after submit
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
        var data = JSON.parse(this.responseText);
        var listing_div = document.getElementById("listing-div");
        
        if(data.STATUS == 'ok'){
            document.getElementById("bus-message").innerHTML = data.MESSAGE;

            data.LIST.forEach(bus => {
                var arrival_time = new Date(bus.ARRIVAL_TIME);
                var departure_time = new Date(bus.DEPARTURE_TIME);
                
                listing_div.innerHTML += `<form action="busSeats.cfm" method="post">
                                            <input type="hidden" name="busId" value="${bus.BUS_ID}">
                                            <input type="hidden" name="totalseats" value="${bus.NO_OF_SEATS}">
                                            <input type="hidden" name="price" value="${bus.PRICE}">
                                            <input type="hidden" name="routeId" value="${bus.ROUTE_ID}">
                                            <input type="hidden" name="year" value="${data.selectedDate.YEAR}">
                                            <input type="hidden" name="month" value="${data.selectedDate.MONTH}">
                                            <input type="hidden" name="day" value="${data.selectedDate.DAY}">
                                            <button class="btn bus-book">
                                                <div class="bus-details">
                                                    <p id="go-time">${arrival_time.toLocaleTimeString()}</p>
                                                    <p id="bus-route">${bus.BUS_NAME}</p>
                                                    <p id="bus-name">${bus.BUS_TYPE}</p>
                                                    <p id="fare">Fare : ${bus.PRICE}</p>
                                                    <p id="reach-time">${departure_time.toLocaleTimeString()}</p>
                                                </div>
                                            </button>
                                        </form>`;
            });        
        }
        else{
            listing_div.innerHTML = "";
            document.getElementById("bus-message").innerHTML = data.MESSAGE;            
        }
    }    
}


//To handle toggle button click

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
