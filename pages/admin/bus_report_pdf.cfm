<cfdocument format="PDF" filename="file.pdf" overwrite="Yes">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>Bus Daily Report</title>
</head>
<body>
  <cfset repodata = Session.bookingrepo>
  <table class="table" >
    <thead>
     <tr>
        <th class="cell">Sl</th>
        <th class="cell">Customer</th>
        <th class="cell">Seat Number</th>
        <th class="cell">Amount</th>
        <th class="cell">Date</th>
     </tr>
    </thead>
    <tbody>
    <CFSET counter = 1 />
    <cfoutput query="repodata">
    <tr>
        <td class="cell">#counter++#</td>
        <td class="cell">#repodata.fullname#</td>
        <td class="cell">#repodata.seat_no#</td>
        <td class="cell">#repodata.fare#</td>
        <td class="cell">#DateFormat(parsedatetime(repodata.booked_on),'dd/mm/yyyy')#</td>
    </tr>
    </cfoutput> 
    </tbody>
  </table>
</body>
</html>
</cfdocument>
<cfheader name="Content-Disposition" value="attachment;filename=file.pdf">
<cfcontent type="application/octet-stream" file="#expandPath('.')#\file.pdf" deletefile="Yes">