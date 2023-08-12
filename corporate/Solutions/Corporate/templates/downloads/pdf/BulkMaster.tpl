<pdf baseFont="Helvetica,Cp1252,false">

<page>
<footer page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img></right>
<center>

<br />
<br />
<font size="15">Bulk payment details</font>
<br />
<br />

<font size="8">
<table width="100%" border="0" cellspacing="2" cellpadding="2">
$%if BulkMasterInput[1].BulkMasterId != ''$
<tr><td bgcolor="DBE5F1">Your Reference</td><td bgcolor="DBE5F1">$$BulkMasterInput[1].BulkMasterId$</td></tr>
$%endif$

$%if BulkMasterInput[1].Description[C].Description != ''$
<tr><td bgcolor="DBE5F1">Description</td><td bgcolor="DBE5F1">$$BulkMasterInput[1].Description[C].Description$</td></tr>
$%endif$

$%if BulkMasterInput[1].ProcessingDateT24toEdge != ''$
<tr><td bgcolor="DBE5F1">Payment date</td><td bgcolor="DBE5F1">$$BulkMasterInput[1].ProcessingDateT24toEdge$</td></tr>
$%endif$

$%if BulkMasterInput[1].ClearingDateT24toEdge != ''$
<tr><td bgcolor="DBE5F1">Clearing date</td><td bgcolor="DBE5F1">$$BulkMasterInput[1].ClearingDateT24toEdge$</td></tr>
$%endif$

$%if BulkMasterInput[1].UploadReference != ''$
<tr><td bgcolor="DBE5F1">Upload reference</td><td bgcolor="DBE5F1">$$BulkMasterInput[1].UploadReference$</td></tr>
$%endif$

$%if BulkMasterInput[1].TotValueUploaded != ''$
<tr><td bgcolor="DBE5F1">Total Value Uploaded</td><td bgcolor="DBE5F1">$$BulkMasterInput[1].TotValueUploaded$</td></tr>
$%endif$

$%if BulkMasterInput[1].Status != ''$
<tr><td bgcolor="DBE5F1">Status</td><td bgcolor="DBE5F1">$$BulkMasterInput[1].Status$</td></tr>
$%endif$

$%if BulkMasterInput[1].TotalAmount != ''$
<tr><td bgcolor="DBE5F1">Total amount</td><td bgcolor="DBE5F1">$$BulkMasterInput[1].TotalAmount$</td></tr>
$%endif$

$%if BulkMasterInput[1].ActiveAccount != ''$
<tr><td bgcolor="DBE5F1">Active account</td><td bgcolor="DBE5F1">$$BulkMasterInput[1].ActiveAccount$</td></tr>
$%endif$

$%if BulkMasterInput[1].Currency != ''$
<tr><td bgcolor="DBE5F1">Currency</td><td bgcolor="DBE5F1">$$BulkMasterInput[1].Currency$</td></tr>
$%endif$



</table>
</pdf>