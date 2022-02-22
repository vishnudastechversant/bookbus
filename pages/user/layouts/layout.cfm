<img src="../../assets/user/img/chair-taken.png" alt="chair" class="d-none">
<img src="../../assets/user/img/chair-selected.png" alt="chair" class="d-none">
<table class="table table-borderless bus">
    <tbody>
        <tr>
            <td colspan="6"></td>
        </tr>
        <tr>
            <td colspan="2"></td>
            <td><img src="../../assets/user/img/blank.png" alt="blank" height="50" width="50"></td>
            <td colspan="2"></td>
            <td><img src="../../assets/user/img/chair-taken.png" alt="drivers" height="76" width="76"></td>
        </tr>
        <tr>
            <td></td>
            <td colspan="5"><hr></td>
        </tr>
        <tr>
            <td colspan="2"></td>
            <td><img src="../../assets/user/img/blank.png" alt="blank" height="50" width="50"></td>
            <td colspan="3"></td>
        </tr>
        <cfloop index="seat_number" from="1" to="#total_seats#" step="5">
            <cfoutput>
                <tr>
                    <cfif seat_number LTE total_seats>
                        <td id="td_#bus_id#_#seat_number#">
                            <label class="seat #listFind(seat_taken,seat_number)?'seat-taken':''#" for="#bus_id#_#seat_number#">
                                <span id="span_#bus_id#_#seat_number#">
                                    <img src="../../assets/user/img/chair#listFind(seat_taken,seat_number)?'-taken':''#.png" alt="chair">
                                </span>
                                <input type="checkbox" name="seats" #listFind(seat_taken,seat_number) GT 0?'disabled':''# id="#bus_id#_#seat_number#" onChange="seatStatus(#bus_id#,#seat_number#)"/>
                            </lable>
                        </td>
                    <cfelse>
                        <td></td>
                    </cfif>
                    <cfif seat_number+1 LTE total_seats>
                        <td id="td_#bus_id#_#seat_number+1#">
                            <label class="seat #listFind(seat_taken,seat_number+1)?'seat-taken':''#" for="#bus_id#_#seat_number+1#">
                                <span id="span_#bus_id#_#seat_number+1#">
                                    <img src="../../assets/user/img/chair#listFind(seat_taken,seat_number+1)?'-taken':''#.png" alt="chair">
                                </span>
                                <input type="checkbox" name="seats" #listFind(seat_taken,seat_number+1) GT 0?'disabled':''# id="#bus_id#_#seat_number+1#" onChange="seatStatus(#bus_id#,#seat_number+1#)"/>
                            </lable>
                        </td>
                    <cfelse>
                        <td></td>
                    </cfif>
                    <td></td>
                    <cfif seat_number+2 LTE total_seats>
                        <td id="td_#bus_id#_#seat_number+2#">
                            <label class="seat #listFind(seat_taken,seat_number+2)?'seat-taken':''#" for="#bus_id#_#seat_number+2#">
                                <span id="span_#bus_id#_#seat_number+2#">
                                    <img src="../../assets/user/img/chair#listFind(seat_taken,seat_number+2)?'-taken':''#.png" alt="chair">
                                </span>
                                <input type="checkbox" name="seats" #listFind(seat_taken,seat_number+2) GT 0?'disabled':''# id="#bus_id#_#seat_number+2#" onChange="seatStatus(#bus_id#,#seat_number+2#)"/>
                            </lable>
                        </td>
                    <cfelse>
                        <td></td>
                    </cfif>
                    <cfif seat_number+3 LTE total_seats>
                        <td id="td_#bus_id#_#seat_number+3#">
                            <label class="seat #listFind(seat_taken,seat_number+3)?'seat-taken':''#" for="#bus_id#_#seat_number+3#">
                                <span id="span_#bus_id#_#seat_number+3#">
                                    <img src="../../assets/user/img/chair#listFind(seat_taken,seat_number+3)?'-taken':''#.png" alt="chair">
                                </span>
                                <input type="checkbox" name="seats" #listFind(seat_taken,seat_number+3) GT 0?'disabled':''# id="#bus_id#_#seat_number+3#" onChange="seatStatus(#bus_id#,#seat_number+3#)"/>
                            </lable>
                        </td>
                    <cfelse>
                        <td></td>
                    </cfif>
                    <cfif seat_number+4 LTE total_seats>
                        <td id="td_#bus_id#_#seat_number+4#">
                            <label class="seat #listFind(seat_taken,seat_number+4)?'seat-taken':''#" for="#bus_id#_#seat_number+4#">
                                <span id="span_#bus_id#_#seat_number+4#">
                                    <img src="../../assets/user/img/chair#listFind(seat_taken,seat_number+4)?'-taken':''#.png" alt="chair">
                                </span>
                                <input type="checkbox" name="seats" #listFind(seat_taken,seat_number+4) GT 0?'disabled':''# id="#bus_id#_#seat_number+4#" onChange="seatStatus(#bus_id#,#seat_number+4#)"/>
                            </lable>
                        </td>
                    <cfelse>
                        <td></td>
                    </cfif>
                </tr>
            </cfoutput>
        </cfloop>
    </tbody>
</table>