<pdf baseFont="Helvetica,Cp1252,false">

<page>
<footer align="center" page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img></right>
<center>

<br />
<br />
<font size="15">Issued Guarantee Claim</font>
<br />
<br />

<font size="8">

<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="2">
  <tr>
    <td bgcolor="DBE5F1">Guarantee Reference</td>
	<td bgcolor="DBE5F1">Type</td>
	<td bgcolor="DBE5F1">Beneficiary</td>
	<td bgcolor="DBE5F1">Claim Date</td>
	<td bgcolor="DBE5F1">Currency</td>
	<td bgcolor="DBE5F1">Claim Amount</td>
	<td bgcolor="DBE5F1">Status</td>
  </tr>
$%for 1 to ListingForDisplay[1].GuaranteeClaimsList[C].lastInstance() $
  <tr>
    <td bgcolor="DBE5F1">$$ListingForDisplay[1].GuaranteeClaimsList[C].GteeRef$</td>
    <td bgcolor="DBE5F1">$$ListingForDisplay[1].GuaranteeClaimsList[C].TypeOfMd$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].GuaranteeClaimsList[C].Beneficiary$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].GuaranteeClaimsList[C].ExpiryDateForDisplay$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].GuaranteeClaimsList[C].Currency$</td>
	<td bgcolor="DBE5F1" align="right">$$ListingForDisplay[1].GuaranteeClaimsList[C].Amount$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].GuaranteeClaimsList[C].StatusForDisplay$</td>
  </tr>
$%endfor$
</table>

$%endif$
</pdf>