<cfinclude  template="header.cfm">
<cfset layout_name = "layout">
<cfset bus_id = 20>
<cfset total_seats = 50>
<cfset price = 10>
<cfset seat_taken = "5,8,9,25,45,37">
<div class="container-fluid">
    <div class="row">
        <div class="col-md-8">
            <div class="d-flex justify-content-center">
                <cfinclude  template="layouts/#layout_name#.cfm">
            </div>
        </div>
        <div class="col-md-4">
            <div class="d-flex justify-content-center fair-card">
                <div class="card w-75">
                    <div class="card-body text-center">
                        <h5 class="card-title">Fair Break-Down</h5>
                        <hr>
                        <table class="table table-borderless w-100">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th>Price</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td id="ticket-fare">Ticket Fare<span></span></td>
                                    <td id="ticket-fare-price"></td>
                                </tr>
                                <tr>
                                    <td id="ticket-tax">TAX<span></span></td>
                                    <td id="ticket-tax-price"></td>
                                </tr>
                                <tr>
                                    <td>Discount</td>
                                    <td>0</td>
                                </tr>
                                <tr>
                                    <td id="ticket-total"><h5>TOTAL</h5></td>
                                    <td id="ticket-tax-price"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    const seatStatus = (busId, seat) => {
        document.getElementById(`${busId}_${seat}`).checked?document.getElementById(`span_${busId}_${seat}`).innerHTML='<img src="../../assets/user/img/chair-selected.png" alt="chair">':document.getElementById(`span_${busId}_${seat}`).innerHTML='<img src="../../assets/user/img/chair.png" alt="chair">';
    }
</script>
<cfinclude  template="footer.cfm">