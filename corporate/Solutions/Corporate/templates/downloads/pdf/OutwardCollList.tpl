<pdf baseFont="Helvetica,Cp1252,false">

<page>
<footer align="center" page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img></right>
<center>
<br />
<br />
<font size="15">Outward Collections</font>
<br />
<br />

<font size="8">		
<table width="100%" border="0" bordercolor="ffffff" cellspacing="2" cellpadding="2">
<tr><td bgcolor="95B3D7">Customer Name: $$InputParameters[1].UserId$ </td></tr>
</table>

$%if OutwardCollectionsListUI[C].lastInstance() != -1$
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="2">
  <tr>
    <td bgcolor="DBE5F1"><b>Collection Reference</b></td>
	<td bgcolor="DBE5F1"><b>Transaction Reference</b></td>
	<td bgcolor="DBE5F1"><b>Type</b></td>
	<td bgcolor="DBE5F1"><b>Drawee</b></td>
	<td bgcolor="DBE5F1"><b>Document Status</b></td>
	<td bgcolor="DBE5F1"><b>Lodge Date</b></td>
	<td bgcolor="DBE5F1"><b>Currency</b></td>
	<td bgcolor="DBE5F1"><b>Amount</b></td>
	<td bgcolor="DBE5F1"><b>Status</b></td>
  </tr>
$%for 1 to OutwardCollectionsListUI[C].lastInstance() $
  <tr>
    <td bgcolor="DBE5F1">$$OutwardCollectionsListUI[C].CollnRef$</td>
	<td bgcolor="DBE5F1">$$OutwardCollectionsListUI[C].TransRef$</td>
	<td bgcolor="DBE5F1">$$OutwardCollectionsListUI[C].TypeOfColl$</td>
	<td bgcolor="DBE5F1">$$OutwardCollectionsListUI[C].Drawee$</td>
	<td bgcolor="DBE5F1">$$OutwardCollectionsListUI[C].DocStatus$</td>
	<td bgcolor="DBE5F1">$$OutwardCollectionsListUI[C].LodgeDate$</td>
	<td bgcolor="DBE5F1">$$OutwardCollectionsListUI[C].Currency$</td>
	<td bgcolor="DBE5F1" align="right">$$OutwardCollectionsListUI[C].Amount$</td>
	<td bgcolor="DBE5F1">$$OutwardCollectionsListUI[C].StatusForDisplay$</td>
  </tr>
$%endfor$
</table>
$%endif$
</font>
</pdf>


