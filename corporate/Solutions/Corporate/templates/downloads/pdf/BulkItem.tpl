<pdf baseFont="Helvetica,Cp1252,false">

<page>
<footer page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img></right>
<center>

<br />
<br />
<font size="15">Bulk item details</font>
<br />
<br />

<font size="8">    
<table width="100%" border="0" bordercolor="ffffff" cellspacing="2" cellpadding="2">
<tr><td bgcolor="DBE5F1">Your Reference </td><td bgcolor="DBE5F1">      $$BulkItemInput[1].BulkItemId$</td></tr>
</table>

<font size="8">
<table width="100%" border="0" bordercolor="ffffff" bgcolor="DBE5F1" cellspacing="2" cellpadding="2">
$%if BulkItemInput[1].Customer != ''$
<tr><td> Payee Name</td><td>		 $$BulkItemInput[1].Customer$</td></tr>
$%endif$

$%if BulkItemInput[1].AccountNo != ''$
<tr><td> Account number</td><td>	 $$BulkItemInput[1].AccountNo$</td></tr>
$%endif$

$%if BulkItemInput[1].SortCode != ''$
<tr><td> Sort code</td><td>			 $$BulkItemInput[1].SortCode$</td></tr>
$%endif$

$%if BulkItemInput[1].Reference != ''$
<tr><td> Reference</td><td>			 $$BulkItemInput[1].Reference$</td></tr>
$%endif$

$%if BulkItemInput[1].Currency != ''$
<tr><td> Currency</td><td>			 $$BulkItemInput[1].Currency$</td></tr>
$%endif$

$%if BulkItemInput[1].Amount != ''$
<tr><td> Credit Amount</td><td>		 $$BulkItemInput[1].Amount$</td></tr>
$%endif$

$%if BulkItemInput[1].ValueDate != ''$
<tr><td> Payment date</td><td>		 $$BulkItemInput[1].ValueDate$</td></tr>
$%endif$

$%if BulkItemInput[1].Status != ''$
<tr><td> Status</td><td>			 $$BulkItemInput[1].Status$</td></tr>
$%endif$
</table>
</pdf>