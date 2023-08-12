<pdf baseFont="Helvetica,Cp1252,false">

<page>
<footer align="center" page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img></right>
<center>

<br />
<br />
<font size="15">Your Collection</font>
<br />
<br />

<font size="8">
<table width="100%" border="0" bordercolor="ffffff" cellspacing="2" cellpadding="2">
<tr><td bgcolor="95B3D7">Account Number:  $$InputParameters[1].AccountNo$</td></tr>
</table>

<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="2">
  <tr>
    <td bgcolor="DBE5F1">Id</td>
	<td bgcolor="DBE5F1">Direction</td>
	<td bgcolor="DBE5F1">Account No</td>
	<td bgcolor="DBE5F1">Currency</td>
	<td bgcolor="DBE5F1">Amount</td>
	<td bgcolor="DBE5F1">Value Date</td>
	<td bgcolor="DBE5F1">Resubmission DD Id</td>
	<td bgcolor="DBE5F1">Status</td>
  </tr>
$%for 1 to RejectedCollectionsList[C].lastInstance() $
  <tr>
    <td bgcolor="DBE5F1">$$RejectedCollectionsList[C].Id$</td>
    <td bgcolor="DBE5F1">$$RejectedCollectionsList[C].Direction$</td>
	<td bgcolor="DBE5F1">$$RejectedCollectionsList[C].AccountNo$</td>
	<td bgcolor="DBE5F1">$$RejectedCollectionsList[C].Currency$</td>
	<td bgcolor="DBE5F1" align="right">$$RejectedCollectionsList[C].Amount$</td>
	<td bgcolor="DBE5F1">$$RejectedCollectionsList[C].ValueDate$</td>
	<td bgcolor="DBE5F1">$$RejectedCollectionsList[C].ResubDdId[1].ResubDdId$</td>
	<td bgcolor="DBE5F1">$$RejectedCollectionsList[C].Status$</td>
  </tr>
$%endfor$
</table>

$%endif$
</pdf>