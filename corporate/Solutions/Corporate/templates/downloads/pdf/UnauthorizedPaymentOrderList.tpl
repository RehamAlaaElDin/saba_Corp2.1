<pdf baseFont="Helvetica,Cp1252,false">

<page>
<footer page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img></right>
<center>

<br />
<br />
$%if WorkingElements[1].TransferType = 'transfers'$
<font size="15">Unauthorized transfers</font>
$%endif$
$%if WorkingElements[1].TransferType = 'payments'$
<font size="15">Unauthorized payments</font>
$%endif$
<br />
<br />

<font size="8">		

<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="2">
  <tr>
    <td bgcolor="DBE5F1">Debit account</td>
	$%if WorkingElements[1].TransferType = 'transfers'$
	<td bgcolor="DBE5F1">Credit account</td>
	$%endif$
	$%if WorkingElements[1].TransferType = 'payments'$
	<td bgcolor="DBE5F1">Payee name</td>
	$%endif$	
	<td bgcolor="DBE5F1">Description</td>
	<td bgcolor="DBE5F1">Date</td>
    <td bgcolor="DBE5F1">Amount</td>
  </tr>
$%for 1 to UnauthorizedPaymentOrderList[C].lastInstance() $
  <tr>
    <td bgcolor="DBE5F1">$$UnauthorizedPaymentOrderList[C].DebitAccount$</td>
	$%if WorkingElements[1].TransferType = 'transfers'$
    <td bgcolor="DBE5F1">$$UnauthorizedPaymentOrderList[C].CreditAccount$</td>
	$%endif$
	$%if WorkingElements[1].TransferType = 'payments'$
    <td bgcolor="DBE5F1">$$UnauthorizedPaymentOrderList[C].BeneficiaryName$</td>
	$%endif$
	<td bgcolor="DBE5F1">$$UnauthorizedPaymentOrderList[C].Narrative$</td>
	<td bgcolor="DBE5F1">$$UnauthorizedPaymentOrderList[C].PaymentExecutionDate$</td>
	<td bgcolor="DBE5F1" align="right">$$UnauthorizedPaymentOrderList[C].PaymentAmount$</td>
  </tr>
$%endfor$
</table>

$%endif$
</pdf>