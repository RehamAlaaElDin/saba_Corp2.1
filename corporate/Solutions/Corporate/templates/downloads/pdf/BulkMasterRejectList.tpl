<pdf baseFont="Helvetica,Cp1252,false">

<page>
<footer page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img></right>
<center>
<br />
<br />
<font size="15">Bulk Payments to Reject</font>
<br />
<br />


<font size="8">
$%if BulkPaymentList[C].lastInstance() != -1$
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="2">
  <tr>
	<td bgcolor="DBE5F1" ><b>Description</b></td>
	<td bgcolor="DBE5F1" ><b>Account</b></td>
	<td bgcolor="DBE5F1" ><b>Payment date</b></td>
	<td bgcolor="DBE5F1" ><b>Number of items</b></td>
	<td bgcolor="DBE5F1" ><b>Total value uploaded</b></td>
	<td bgcolor="DBE5F1" ><b>Status</b></td>
  </tr>
$%for 1 to BulkPaymentList[C].lastInstance() $
  <tr>
    <td bgcolor="DBE5F1">$$BulkPaymentList[C].DisplayDescription$</td>
    <td bgcolor="DBE5F1">$$BulkPaymentList[C].AccountNumber$</td>
	<td bgcolor="DBE5F1">$$BulkPaymentList[C].PaymentValueDate$</td>
	<td bgcolor="DBE5F1">$$BulkPaymentList[C].TotalItems$</td>
	<td bgcolor="DBE5F1">$$BulkPaymentList[C].TotalValueUploaded$</td>
	<td bgcolor="DBE5F1">$$BulkPaymentList[C].Status$</td>
  </tr>
$%endfor$
</table>
$%endif$
</pdf>