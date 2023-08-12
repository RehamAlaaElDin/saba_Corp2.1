<pdf baseFont="Helvetica,Cp1252,false">

<page>
<footer align="center" page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img></right>
<center>
<br />
<br />
<font size="15">Inward Collections</font>
<br />
<br />

<font size="8">		
<table width="100%" border="0" bordercolor="ffffff" cellspacing="2" cellpadding="2">
<tr><td bgcolor="95B3D7">Customer Name: $$InputParameters[1].UserID$ </td></tr>
</table>

$%if InwardCollectionsListUI[C].lastInstance() != -1$
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="2">
  <tr>
    <td bgcolor="DBE5F1"><b>Collection Reference</b></td>
	<td bgcolor="DBE5F1"><b>Transaction Reference</b></td>
	<td bgcolor="DBE5F1"><b>Type</b></td>
	<td bgcolor="DBE5F1"><b>Drawer</b></td>
	<td bgcolor="DBE5F1"><b>Document Status</b></td>
	<td bgcolor="DBE5F1"><b>Lodge Date</b></td>
	<td bgcolor="DBE5F1"><b>Currency</b></td>
	<td bgcolor="DBE5F1"><b>Amount</b></td>
	<td bgcolor="DBE5F1"><b>Status</b></td>
  </tr>
$%for 1 to InwardCollectionsListUI[C].lastInstance() $
  <tr>
    <td bgcolor="DBE5F1">$$InwardCollectionsListUI[C].CollnRef$</td>
	<td bgcolor="DBE5F1">$$InwardCollectionsListUI[C].TransRef$</td>
	<td bgcolor="DBE5F1">$$InwardCollectionsListUI[C].TypeOfColl$</td>
	<td bgcolor="DBE5F1">$$InwardCollectionsListUI[C].Drawer$</td>
	<td bgcolor="DBE5F1">$$InwardCollectionsListUI[C].DocStatus$</td>
	<td bgcolor="DBE5F1">$$InwardCollectionsListUI[C].LodgeDate$</td>
	<td bgcolor="DBE5F1">$$InwardCollectionsListUI[C].Currency$</td>
	<td bgcolor="DBE5F1" align="right">$$InwardCollectionsListUI[C].Amount$</td>
	<td bgcolor="DBE5F1">$$InwardCollectionsListUI[C].StatusForDisplay$</td>
  </tr>
$%endfor$
</table>
$%endif$
</font>
</pdf>


