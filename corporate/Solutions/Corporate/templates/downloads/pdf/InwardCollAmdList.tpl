<pdf baseFont="Helvetica,Cp1252,false">

<page>
<footer align="center" page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img></right>
<center>
<br />
<br />
<font size="15">Inward Collection Amendments</font>
<br />
<br />

<font size="8">		
<table width="100%" border="0" bordercolor="ffffff" cellspacing="2" cellpadding="2">
<tr><td bgcolor="95B3D7">Customer Name: $$InputParameters[1].UserID$ </td></tr>
</table>

$%if InwardCollectionAmendmentListUI[C].lastInstance() != -1$
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="2">
  <tr>
    <td bgcolor="DBE5F1"><b>Collection Reference</b></td>
	<td bgcolor="DBE5F1"><b>Transaction Reference</b></td>
	<td bgcolor="DBE5F1"><b>Type</b></td>
	<td bgcolor="DBE5F1"><b>Drawer</b></td>
	<td bgcolor="DBE5F1"><b>Lodge Date</b></td>
	<td bgcolor="DBE5F1"><b>Currency</b></td>
	<td bgcolor="DBE5F1" align="right"><b>Amount</b></td>
  </tr>
$%for 1 to InwardCollectionAmendmentListUI[C].lastInstance() $
  <tr>
    <td bgcolor="DBE5F1">$$InwardCollectionAmendmentListUI[C].CollnRef$</td>
	<td bgcolor="DBE5F1">$$InwardCollectionAmendmentListUI[C].TransRef$</td>
	<td bgcolor="DBE5F1">$$InwardCollectionAmendmentListUI[C].TypeOfColl$</td>
	<td bgcolor="DBE5F1">$$InwardCollectionAmendmentListUI[C].Drawer$</td>
	<td bgcolor="DBE5F1">$$InwardCollectionAmendmentListUI[C].LodgeDate$</td>
	<td bgcolor="DBE5F1">$$InwardCollectionAmendmentListUI[C].Currency$</td>
	<td bgcolor="DBE5F1">$$InwardCollectionAmendmentListUI[C].Amount$</td>
  </tr>
$%endfor$
</table>
$%endif$
</font>
</pdf>


