<pdf baseFont="Helvetica,Cp1252,false">

<page>
<footer align="center" page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img></right>
<center>

<br />
<br />
<font size="15">Import Letter of Credit</font>
<br />
<br />

<font size="8">

<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="2">
  <tr>
    <td bgcolor="DBE5F1">LC Reference</td>
	<td bgcolor="DBE5F1">LC Type</td>
	<td bgcolor="DBE5F1">Beneficiary</td>
	<td bgcolor="DBE5F1">Issue Date</td>
	<td bgcolor="DBE5F1">Expiry Date</td>
	<td bgcolor="DBE5F1">Currency</td>
	<td bgcolor="DBE5F1">Amount</td>
	<td bgcolor="DBE5F1">Status</td>
  </tr>
$%for 1 to ListingForDisplay[1].ImportLetterOfCreditList[C].lastInstance() $
  <tr>
    <td bgcolor="DBE5F1">$$ListingForDisplay[1].ImportLetterOfCreditList[C].TransRef$</td>
    <td bgcolor="DBE5F1">$$ListingForDisplay[1].ImportLetterOfCreditList[C].LcType$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ImportLetterOfCreditList[C].LcBeneVal$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ImportLetterOfCreditList[C].IssueDateForDisplay$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ImportLetterOfCreditList[C].ExpiryDateForDisplay$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ImportLetterOfCreditList[C].Currency$</td>
	<td bgcolor="DBE5F1" align="right">$$ListingForDisplay[1].ImportLetterOfCreditList[C].Amount$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ImportLetterOfCreditList[C].StatusForDisplay$</td>
  </tr>
$%endfor$
</table>

$%endif$
</pdf>