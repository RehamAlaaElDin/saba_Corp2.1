<pdf baseFont="Helvetica,Cp1252,false">

<page>
<footer page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img></right>
<center>

<br />
<br />
<font size="15">Your Cheques</font>
<br />
<br />

<font size="8">		
<table width="100%" border="0" bordercolor="ffffff" cellspacing="2" cellpadding="2">

<tr><td bgcolor="95B3D7">Customer Number:  $$InputParameters[1].CustomerNo$</td></tr>
</table>


<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="2">
  <tr>
	<td bgcolor="DBE5F1">Account Number</td>
    <td bgcolor="DBE5F1">Payment Stop Reason</td>
	<td bgcolor="DBE5F1">First Cheque Number</td>
	<td bgcolor="DBE5F1">Last Cheque Number</td>	
  </tr>
$%for 1 to PendingStopCheques[C].lastInstance() $
  <tr>
    <td bgcolor="DBE5F1">$$PendingStopCheques[C].Id$</td>
    <td bgcolor="DBE5F1">$$PendingStopCheques[C].PaymStopType.value()$</td>
    <td bgcolor="DBE5F1">$$PendingStopCheques[C].FirstChequeNo$</td>
	<td bgcolor="DBE5F1">$$PendingStopCheques[C].LastChequeNo$</td>
  </tr>
$%endfor$
</table>

$%endif$
</pdf>