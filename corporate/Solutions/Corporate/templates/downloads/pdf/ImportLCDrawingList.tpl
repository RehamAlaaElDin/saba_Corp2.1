<pdf baseFont="Helvetica,Cp1252,false">

<page>
<footer align="center" page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img></right>
<center>

<br />
<br />
<font size="15">Import LC Drawing</font>
<br />
<br />

<font size="8">

<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="2">
  <tr>
    <td bgcolor="DBE5F1">LC Reference</td>
	<td bgcolor="DBE5F1">LC Type</td>
	<td bgcolor="DBE5F1">Drawing Reference</td>
	<td bgcolor="DBE5F1">Beneficiary</td>
	<td bgcolor="DBE5F1">Document Status</td>
	<td bgcolor="DBE5F1">Date</td>
	<td bgcolor="DBE5F1">Currency</td>
	<td bgcolor="DBE5F1">Amount</td>
	<td bgcolor="DBE5F1">Status</td>
  </tr>
$%for 1 to ListingForDisplay[1].ImportDrawingsList[C].lastInstance() $
  <tr>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ImportDrawingsList[C].LcId$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ImportDrawingsList[C].LcType$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ImportDrawingsList[C].TransRef$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ImportDrawingsList[C].Beneficiary$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ImportDrawingsList[C].DocStatus$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ImportDrawingsList[C].DrawingDateForDisplay$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ImportDrawingsList[C].Currency$</td>
	<td bgcolor="DBE5F1" align="right">$$ListingForDisplay[1].ImportDrawingsList[C].Amount$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ImportDrawingsList[C].StatusForDisplay$</td>
  </tr>
$%endfor$
</table>

$%endif$
</pdf>