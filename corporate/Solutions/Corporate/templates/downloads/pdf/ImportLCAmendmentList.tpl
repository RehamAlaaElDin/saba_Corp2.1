<pdf baseFont="Helvetica,Cp1252,false">

<page>
<footer align="center" page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img></right>
<center>

<br />
<br />
<font size="15">Import LC Amendment</font>
<br />
<br />

<font size="8">

<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="2">
  <tr>
    <td bgcolor="DBE5F1">LC Reference</td>
	<td bgcolor="DBE5F1">Transaction Reference</td>
	<td bgcolor="DBE5F1">Beneficiary</td>
	<td bgcolor="DBE5F1">New Expiry Date</td>
	<td bgcolor="DBE5F1">Currency</td>
	<td bgcolor="DBE5F1">Change in Amount</td>
	<td bgcolor="DBE5F1">Status</td>
  </tr>
$%for 1 to ListingForDisplay[1].ImportLetterOfCreditAmendmentsList[C].lastInstance() $
  <tr>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ImportLetterOfCreditAmendmentsList[C].LcId$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ImportLetterOfCreditAmendmentsList[C].TransRef$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ImportLetterOfCreditAmendmentsList[C].Beneficiary$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ImportLetterOfCreditAmendmentsList[C].AmendmentDateForDisplay$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ImportLetterOfCreditAmendmentsList[C].Currency$</td>
	<td bgcolor="DBE5F1" align="right">$$ListingForDisplay[1].ImportLetterOfCreditAmendmentsList[C].Amount$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ImportLetterOfCreditAmendmentsList[C].StatusForDisplay$</td>
  </tr>
$%endfor$
</table>

$%endif$
</pdf>