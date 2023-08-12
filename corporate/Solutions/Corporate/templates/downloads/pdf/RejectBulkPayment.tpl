<pdf baseFont="Helvetica,Cp1252,false">

<page>
<footer page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img></right>
<center>
<br />
<br />
<font size="15">Rejected bulk Payment details</font>
<br />
<br />


<font size="8">
<table width="100%" border="0" cellspacing="2" cellpadding="2"  bgcolor="DBE5F1">
<tr><td>Your reference </td><td> $$RejectBulkPayment[C].id$ </td></tr>
$%if RejectBulkPayment[C].Description != ''$
<tr><td> Description 	</td><td> $$RejectBulkPayment[C].Description$</td></tr>
$%endif$

$%if RejectBulkPayment[C].Account != ''$
<tr><td> Account 	</td><td> $$RejectBulkPayment[C].Account$</td></tr>
$%endif$

$%if RejectBulkPayment[C].TotalAmount != ''$
<tr><td> Total amount  	</td><td> $$RejectBulkPayment[C].TotalAmount$</td></tr>
$%endif$

$%if RejectBulkPayment[C].Reasonforrejection != ''$
<tr><td> Reason for rejection 	</td><td> $$RejectBulkPayment[C].Reasonforrejection$</td></tr>
$%endif$
</table>
</pdf>
