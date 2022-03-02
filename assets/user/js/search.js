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
        document.getElementById("listing-div").innerHTML = this.responseText;
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
