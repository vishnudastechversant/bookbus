<cfinclude  template="header.cfm">
<cfset layout_name = "layout">
<cfset bus_id = 20>
<cfset total_seats = 50>
<cfset seat_taken = "5,8,9,25,45,37">
<div class="container">
    <div class="row">
        <div class="col-md-8">
            <div class="d-flex justify-content-center">
                <cfinclude  template="layouts/#layout_name#.cfm">
            </div>
        </div>
        <div class="col-md-4"></div>
    </div>
</div>

<script>
    const seatStatus = (busId, seat) => {
        document.getElementById(`${busId}_${seat}`).checked?document.getElementById(`span_${busId}_${seat}`).innerHTML='<img src="../../assets/user/img/chair-selected.png" alt="chair">':document.getElementById(`span_${busId}_${seat}`).innerHTML='<img src="../../assets/user/img/chair.png" alt="chair">';
    }
</script>
<cfinclude  template="footer.cfm">