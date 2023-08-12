<pdf baseFont="Helvetica,Cp1252,false">

<page>
<footer align="center" page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img></right>
<center>

<br />
<br />
<font size="15">Export LC Drawing</font>
<br />
<br />

<font size="8">

<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="2">
  <tr>
    <td bgcolor="DBE5F1">LC Reference</td>
	<td bgcolor="DBE5F1">Type</td>
	<td bgcolor="DBE5F1">Drawing Reference</td>
	<td bgcolor="DBE5F1">Applicant</td>
	<td bgcolor="DBE5F1">Document Status</td>
	<td bgcolor="DBE5F1">Date</td>
	<td bgcolor="DBE5F1">Currency</td>
	<td bgcolor="DBE5F1">Amount</td>
	<td bgcolor="DBE5F1">Status</td>
  </tr>
$%for 1 to ListingForDisplay[1].ExportDrawingsList[C].lastInstance() $
  <tr>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ExportDrawingsList[C].IssBankRef$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ExportDrawingsList[C].LcType$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ExportDrawingsList[C].TransRef$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ExportDrawingsList[C].DrApplicant$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ExportDrawingsList[C].DrDoc$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ExportDrawingsList[C].DrDate$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ExportDrawingsList[C].Currency$</td>
	<td bgcolor="DBE5F1" align="right">$$ListingForDisplay[1].ExportDrawingsList[C].Amount$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ExportDrawingsList[C].StatusForDisplay$</td>
  </tr>
$%endfor$
</table>

$%endif$
</pdf>