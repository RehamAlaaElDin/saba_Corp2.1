<pdf baseFont="Helvetica,Cp1252,false">

<page>
<footer page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img></right>
<center>

<br />
<br />
<font size="15">Bulk master list</font>
<br />
<br />


<font size="8">
$%if BulkPaymentsList[C].lastInstance() != -1$
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="2">
  <tr>
    <td bgcolor="DBE5F1" ><b>Description</b></td>
	<td bgcolor="DBE5F1" ><b>Account name</b></td>
	<td bgcolor="DBE5F1" ><b>Payment date</b></td>
	<td bgcolor="DBE5F1" ><b>Number of items</b></td>
	<td bgcolor="DBE5F1" ><b>Total Value Uploaded</b></td>
	<td bgcolor="DBE5F1" ><b>Status</b></td>
  </tr>
$%for 1 to BulkPaymentsList[C].lastInstance() $
  <tr>
    <td bgcolor="DBE5F1">$$BulkPaymentsList[C].DisplayDescription$</td>
    <td bgcolor="DBE5F1">$$BulkPaymentsList[C].ActiveAccount$</td>
	<td bgcolor="DBE5F1">$$BulkPaymentsList[C].PaymentValueDate$</td>
	<td bgcolor="DBE5F1">$$BulkPaymentsList[C].TotalItems$</td>
	<td bgcolor="DBE5F1">$$BulkPaymentsList[C].TotalValueUploaded$</td>
	<td bgcolor="DBE5F1">$$BulkPaymentsList[C].Status$</td>
  </tr>
$%endfor$
</table>
$%endif$
</pdf>
