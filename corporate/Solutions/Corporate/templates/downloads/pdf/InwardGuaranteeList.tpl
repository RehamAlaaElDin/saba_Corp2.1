<pdf baseFont="Helvetica,Cp1252,false">

<page>
<footer align="center" page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img></right>
<center>

<br />
<br />
<font size="15">Inward Guarantee</font>
<br />
<br />

<font size="8">

<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="2">
  <tr>
    <td bgcolor="DBE5F1">Guarantee Reference</td>
	<td bgcolor="DBE5F1">Transaction Reference</td>
	<td bgcolor="DBE5F1">Issuing Party</td>
	<td bgcolor="DBE5F1">Expiry Date</td>
	<td bgcolor="DBE5F1">Currency</td>
	<td bgcolor="DBE5F1">Amount</td>
  </tr>
$%for 1 to ListingForDisplay[1].ReceivedGuaranteeList[C].lastInstance() $
  <tr>
    <td bgcolor="DBE5F1">$$ListingForDisplay[1].ReceivedGuaranteeList[C].GteeRef$</td>
    <td bgcolor="DBE5F1">$$ListingForDisplay[1].ReceivedGuaranteeList[C].MdTransRef$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ReceivedGuaranteeList[C].Beneficiary$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ReceivedGuaranteeList[C].MaturityDate$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ReceivedGuaranteeList[C].Currency$</td>
	<td bgcolor="DBE5F1" align="right">$$ListingForDisplay[1].ReceivedGuaranteeList[C].Amount$</td>
  </tr>
$%endfor$
</table>

$%endif$
</pdf>