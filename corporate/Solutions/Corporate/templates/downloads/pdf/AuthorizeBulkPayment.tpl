<pdf baseFont="Helvetica,Cp1252,false">

<page>
<footer page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img></right>
<center>
<br />
<br />
<font size="15">Authorise bulk payment details</font>
<br />
<br />


<font size="8">
<table width="100%" border="0" cellspacing="2" cellpadding="2"  bgcolor="DBE5F1">
<tr><td>Your reference </td><td> $$IRIS[1].BulkMaster[1].BulkMasterId$</td></tr>
$%if IRIS[1].BulkMaster[1].Description[C].Description != ''$
<tr><td> Description	</td><td> $$IRIS[1].BulkMaster[1].Description[C].Description$</td></tr>
$%endif$
$%if IRIS[1].BulkMaster[1].ProcessingDateT24toEdge != ''$
<tr><td> Payment Date 	</td><td> $$IRIS[1].BulkMaster[1].ProcessingDateT24toEdge$</td></tr>
$%endif$
$%if IRIS[1].BulkMaster[1].ActiveAccount != ''$
<tr><td> Account 	</td><td> $$IRIS[1].BulkMaster[1].ActiveAccount$</td></tr>
$%endif$
$%if IRIS[1].BulkMaster[1].TotValueUploaded != ''$
<tr><td> Total Value Uploaded	</td><td> $$IRIS[1].BulkMaster[1].TotValueUploaded$</td></tr>
$%endif$
$%if IRIS[1].BulkMaster[1].Status != ''$
<tr><td> Status 	</td><td> $$IRIS[1].BulkMaster[1].Status$</td></tr>
$%endif$
</table>
</pdf>
