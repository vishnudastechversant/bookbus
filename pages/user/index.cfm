    <cfinclude  template="header.cfm">

    <div id="searchResult"></div>
        
    <div class="banner">
        <img src="../../assets/banner.png" alt="banner">
    </div>
    <cfinclude  template="footer.cfm">

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