<pdf baseFont="Helvetica,Cp1252,false">

<page>
<footer align="center" page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img></right>
<center>
<br />
<br />
<font size="15">Outward Collection Amendments</font>
<br />
<br />

<font size="8">		
<table width="100%" border="0" bordercolor="ffffff" cellspacing="2" cellpadding="2">
<tr><td bgcolor="95B3D7">Customer Name: $$InputParameters[1].UserId$ </td></tr>
</table>

$%if OutwardCollectionsAmendmentListUI[C].lastInstance() != -1$
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="2">
  <tr>
    <td bgcolor="DBE5F1"><b>Collection Reference</b></td>
	<td bgcolor="DBE5F1"><b>Transaction Reference</b></td>
	<td bgcolor="DBE5F1"><b>Type</b></td>
	<td bgcolor="DBE5F1"><b>Drawee</b></td>
	<td bgcolor="DBE5F1"><b>Lodge Date</b></td>
	<td bgcolor="DBE5F1"><b>Currency</b></td>
	<td bgcolor="DBE5F1"><b>Amount</b></td>
  </tr>
$%for 1 to OutwardCollectionsAmendmentListUI[C].lastInstance() $
  <tr>
    <td bgcolor="DBE5F1">$$OutwardCollectionsAmendmentListUI[C].CollnRef$</td>
	<td bgcolor="DBE5F1">$$OutwardCollectionsAmendmentListUI[C].TransRef$</td>
	<td bgcolor="DBE5F1">$$OutwardCollectionsAmendmentListUI[C].TypeOfColl$</td>
	<td bgcolor="DBE5F1">$$OutwardCollectionsAmendmentListUI[C].Drawee$</td>
	<td bgcolor="DBE5F1">$$OutwardCollectionsAmendmentListUI[C].LodgeDate$</td>
	<td bgcolor="DBE5F1">$$OutwardCollectionsAmendmentListUI[C].Currency$</td>
	<td bgcolor="DBE5F1" align="right">$$OutwardCollectionsAmendmentListUI[C].Amount$</td>
  </tr>
$%endfor$
</table>
$%endif$
</font>
</pdf>


