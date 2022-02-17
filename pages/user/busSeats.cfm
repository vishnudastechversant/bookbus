<cfinclude  template="header.cfm">
<cfset layout_name = "layout">
<cfset bus_id = 20>
<cfset total_seats = 50>
<cfset price = 10>
<cfset seat_taken = "5,8,9,25,45,37">
<cfoutput>
    <input type="number" name="price" id="price" value="#price#" hidden/>
</cfoutput>
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
                                    <td id="ticket-total"><h5>TOTAL FARE</h5></td>
                                    <td id="ticket-total-price">0</td>
                                </tr>
                            </tbody>
                        </table>
                        <form method="post" action="../../cfc/booking.cfc?method=setBooking">
                            <cfoutput>
                                <input type="number" name="busId" id="busId" value="#bus_id#" hidden/>
                                <input type="text" name="seats" id="seats" value="" hidden/>
                                <input type="text" name="fare" id="fare" value="0" hidden/>
                            </cfoutput>
                            <button type="submit" class="btn btn-danger col-md-6">Pay Now</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    const maxSeat = 5;
    const seats = [];
    const seatStatus = (busId, seat) => {
        if(document.getElementById(`${busId}_${seat}`).checked){
            if(seats.length>=maxSeat){
                alert("Max Limit Exceeded");
                return;
            }
            seats.push(seat);
            document.getElementById(`span_${busId}_${seat}`).innerHTML='<img src="../../assets/user/img/chair-selected.png" alt="chair">';
        }else{
            const index = seats.indexOf(seat);
            if (index > -1) {
                seats.splice(index, 1);
            }
            document.getElementById(`span_${busId}_${seat}`).innerHTML='<img src="../../assets/user/img/chair.png" alt="chair">';
        }
        const ticketPrice =parseFloat(document.getElementById("price").value*seats.length).toFixed(2)
        document.getElementById("ticket-total-price").innerHTML = ticketPrice;
        document.getElementById("fare").setAttribute('value',ticketPrice);
        const seatsString = seats.toString();
        document.getElementById("seats").setAttribute('value', seatsString );
    }
</script>
<cfinclude  template="footer.cfm">