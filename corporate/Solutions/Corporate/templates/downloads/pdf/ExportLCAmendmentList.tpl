<pdf baseFont="Helvetica,Cp1252,false">

<page>
<footer page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img></right>
<center>

<br />
<br />
<font size="15">Export LC Amendment</font>
<br />
<br />

<font size="8">

<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="2">
  <tr>
    <td bgcolor="DBE5F1">LC Reference</td>
	<td bgcolor="DBE5F1">Transaction Reference</td>
	<td bgcolor="DBE5F1">Type</td>
	<td bgcolor="DBE5F1">Issuing Bank</td>
	<td bgcolor="DBE5F1">Applicant</td>
	<td bgcolor="DBE5F1">New Expiry Date</td>
	<td bgcolor="DBE5F1">Currency</td>
	<td bgcolor="DBE5F1">Change in Amount</td>
	<td bgcolor="DBE5F1">Status</td>
	<td bgcolor="DBE5F1">Amendment Status</td>
  </tr>
$%for 1 to ListingForDisplay[1].ExportLetterOfCreditAmendmentsList[C].lastInstance() $
  <tr>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ExportLetterOfCreditAmendmentsList[C].IssBankRef$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ExportLetterOfCreditAmendmentsList[C].TransRef$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ExportLetterOfCreditAmendmentsList[C].LcType$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ExportLetterOfCreditAmendmentsList[C].IssuingBank$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ExportLetterOfCreditAmendmentsList[C].Applicant$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ExportLetterOfCreditAmendmentsList[C].AmdDate$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ExportLetterOfCreditAmendmentsList[C].Currency$</td>
	<td bgcolor="DBE5F1" align="right">$$ListingForDisplay[1].ExportLetterOfCreditAmendmentsList[C].Amount$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ExportLetterOfCreditAmendmentsList[C].StatusForDisplay$</td>
	<td bgcolor="DBE5F1">$$ListingForDisplay[1].ExportLetterOfCreditAmendmentsList[C].AmendStatus$</td>
  </tr>
$%endfor$
</table>

$%endif$
</pdf>