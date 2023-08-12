<pdf baseFont="Helvetica,Cp1252,false" charset=UTF-8>
<page>
<footer align="center" page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img></right>
<center>
<br />
<br />
<font size="15">Export LC Drawing</font>
<br />
<br />
<font size="8">
<table width="100%" border="0" bordercolor="ffffff" cellspacing="2" cellpadding="4">
<tr>
<td bgcolor="95B3D7">User Name</td><td bgcolor="95B3D7">$$InputParameters[1].UserId$</td>
</tr>
<tr>
<td bgcolor="95B3D7">Transaction Reference</td><td bgcolor="95B3D7">$$InputParameters[1].ExportLCDrawingList[C].TransRef$</td>
</tr>
</table>

<div style="width:100%;clear:both;">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
<tr><td rowspan="2"><font size="10"><b>LC Summary</b></font></td></tr>
</table>
<font size="8">
<!---LC Details--->
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
  $%if LetterOfCreditOverview[C].Currency != ''$
  <tr>
     <td bgcolor="DBE5F1"><b>LC Currency</b></td>
	 <td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].Currency$</td>
  </tr>
  $%endif$
   $%if LetterOfCreditOverview[C].Amount != ''$
  <tr>
      	<td bgcolor="DBE5F1"><b>LC Amount</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].Amount$</td>
  </tr>
   $%endif$
   $%if LetterOfCreditOverview[C].Beneficiary != ''$
  <tr>
	 <td bgcolor="DBE5F1"><b>Beneficiary</b></td>
	 <td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].Beneficiary$</td>
 </tr>
 $%endif$
 $%if LetterOfCreditOverview[C].OldLcNumber != ''$
	<tr>
	 <td bgcolor="DBE5F1"><b>LC Reference Number</b></td>
	 <td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].OldLcNumber$</td>
	</tr>
  $%endif$
  $%if LetterOfCreditOverview[C].IssueDate != ''$
  <tr>
      	<td bgcolor="DBE5F1"><b>Issue Date</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].IssueDate$</td>
  </tr>
   $%endif$
   $%if LetterOfCreditOverview[C].ExpiryDate != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Expiry Date</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].ExpiryDate$</td>
	</tr>
   $%endif$
  $%if LetterOfCreditOverview[C].PayTerms != ''$ 
  <tr>
	   <td bgcolor="DBE5F1"><b>Payment Terms</b></td>
	   <td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].PayTerms$</td>
  </tr>
  $%endif$
   $%if LetterOfCreditOverview[C].Applicant != ''$
  <tr>  
     <td bgcolor="DBE5F1"><b>Applicant Reference</b></td>
	 <td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].Applicant$</td>
  </tr>
  $%endif$
   $%if LetterOfCreditOverview[C].ClientRef != ''$
  <tr>  
     <td bgcolor="DBE5F1"><b>Client Reference</b></td>
	 <td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].ClientRef$</td>
  </tr>
  $%endif$
   $%if LetterOfCreditOverview[C].LcType != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Type of LC</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].LcType$</td>
	</tr>
   $%endif$
   $%if LetterOfCreditOverview[C].AdviceExpiryDate != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Advice Expiry Date</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].AdviceExpiryDate$</td>
	</tr>
   $%endif$
   $%if LetterOfCreditOverview[C].BeneficiaryAcc != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Beneficiary Account No</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].BeneficiaryAcc$</td>
	</tr>
   $%endif$
   $%if LetterOfCreditOverview[C].ClosingDate != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Closing Date</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].ClosingDate$</td>
	</tr>
   $%endif$
   $%if LetterOfCreditOverview[C].Tenor != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Tenor</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].Tenor$</td>
	</tr>
   $%endif$
   $%if LetterOfCreditOverview[C].IssuingBank[C].IssuingBank != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Issuing Bank</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].IssuingBank[C].IssuingBank$</td>
	</tr>
   $%endif$
   $%if LetterOfCreditOverview[C].AdvisingBkCustno != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Advising Bank Customer No</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].AdvisingBkCustno$</td>
	</tr>
   $%endif$
   $%if LetterOfCreditOverview[C].AdvisingBk[C].AdvisingBk != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Advising Bank</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].AdvisingBk[C].AdvisingBk$</td>
	</tr>
   $%endif$
   $%if LetterOfCreditOverview[C].AdvisingBkAcc != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Advising Bank Account No</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].AdvisingBkAcc$</td>
	</tr>
   $%endif$
   $%if LetterOfCreditOverview[C].ForwardContract[C].ForwardContract != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Forward Contract</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].ForwardContract[C].ForwardContract$</td>
	</tr>
   $%endif$
   $%if LetterOfCreditOverview[C].Applicant_Details[C].ApplicantDetails != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Applicant Details</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].Applicant_Details[C].ApplicantDetails$</td>
	</tr>
   $%endif$
   $%if LetterOfCreditOverview[C].IssBankRef != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Issue Bank Ref</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].IssBankRef$</td>
	</tr>
   $%endif$
   $%if LetterOfCreditOverview[C].ExternalReference != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>External Reference</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].ExternalReference$</td>
	</tr>
   $%endif$
   $%if LetterOfCreditOverview[C].PayTypeEnrich != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Payment Type</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].PayTypeEnrich$</td>
	</tr>
   $%endif$
   $%if LetterOfCreditOverview[C].Beneficiary_Details[C].BeneficiaryDetails != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Beneficiary Details</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].Beneficiary_Details[C].BeneficiaryDetails$</td>
	</tr>
   $%endif$
</table>
</font>
</div>

<div style="width:100%;clear:both;">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
<tr><td rowspan="2"><font size="10"><b>Drawing Details</b></font></td></tr>
</table>
<font size="8">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
	$%if DrawingDetails[C].DrawCcy != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Currency</b></td>
		<td bgcolor="DBE5F1">$$DrawingDetails[C].DrawCcy$</td>
	</tr>
   $%endif$
   $%if DrawingDetails[C].DocumentAmount != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Documents Value</b></td>
		<td bgcolor="DBE5F1">$$DrawingDetails[C].DocumentAmount$</td>
	</tr>
   $%endif$
</table>
</font>
</div>

$%if DrawingDetails[C].DocId[C].DocText[C].DocText != ''$
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
<tr><td rowspan="2"><font size="10"><b>Documents Presented</b></font></td></tr>
</table>
<font size="8">
<div style="width:100%;clear:both;">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
  <tr>
     <td bgcolor="DBE5F1"><b>Document Text</b></td>
	 <td bgcolor="DBE5F1">$$DrawingDetails[C].DocId[C].DocText[C].DocText$</td>
  </tr>
</table>
</div>
</font>
$%endif$

$%if DrawingDetails[C].ConDiscrepancy[1].ConDiscrepancy != ''$
<div style="width:50%;clear:both;">
<br/>
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
<tr><td rowspan="2"><font size="10"><b>Discrepancies</b></font></td></tr>
</table>
<font size="8">
$%if DrawingDetails[1].ConDiscrepancy[C].lastInstance() != -1$
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
  <tr>
    <td bgcolor="DBE5F1"><b>No of Discrepancy</b></td>
	<td bgcolor="DBE5F1"><b>Discrepancy Text</b></td>
  </tr>
$%for 1 to DrawingDetails[1].ConDiscrepancy[C].lastInstance() $
  <tr>
    <td bgcolor="DBE5F1">$$DrawingDetails[1].ConDiscrepancy[C].DiscrepancyHeading$</td>
    <td bgcolor="DBE5F1">$$DrawingDetails[1].ConDiscrepancy[C].ConDiscrepancy$</td>
  </tr>
$%endfor$
</table>
$%endif$
</font>
</div>
$%endif$

<div style="width:100%;clear:both;">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
<tr><td rowspan="2"><font size="10"><b>Payment Details</b></font></td></tr>
</table>
<font size="8">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
   $%if DrawingDetails[C].DocumentAmount != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Total Amount to be Paid</b></td>
		<td bgcolor="DBE5F1">$$DrawingDetails[1].DrawCcy$ $$DrawingDetails[C].DocumentAmount$</td>
	</tr>
   $%endif$
   $%if DrawingDetails[C].PaymentAccount != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Account To Be Credited For The Documents</b></td>
		<td bgcolor="DBE5F1">$$DrawingDetails[C].PaymentAccount$</td>
	</tr>
   $%endif$
   $%if InputParameters[1].ImportLCDrawingList[C].StatusForDisplay != 'Rejected' AND DrawingDetails[C].IbBkToCust[C].IbBkToCust != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Message From Bank</b></td>
		<td bgcolor="DBE5F1">$$DrawingDetails[C].IbBkToCust[C].IbBkToCust$</td>
	</tr>
   $%endif$
   $%if DrawingDetails[C].IbCustToBk[C].IbCustToBk != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Message/Response to Bank</b></td>
		<td bgcolor="DBE5F1">$$DrawingDetails[C].IbCustToBk[C].IbCustToBk$</td>
	</tr>
   $%endif$
</table>
</font>
</div>

$%if InputParameters[1].ExportLCDrawingList[C].StatusForDisplay == 'Rejected' AND DrawingDetails[C].IbBkToCust[C].IbBkToCust != '' $
<div style="width:100%;clear:both;">
<br/>
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
<tr><td rowspan="2"><font size="10"><b>Reason for rejection</b></font></td></tr>
</table>
<font size="8">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
  <tr> 
  <td bgcolor="DBE5F1">$$DrawingDetails[C].IbBkToCust[C].IbBkToCust$</td>
  </tr>
</table>
</font>
</div>
$%endif$

<div style="width:100%;clear:both;">
<br/>
$%if InputParameters[1].ExportLCDrawingList[C].StatusForDisplay == "Approved"$
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
<tr><td rowspan="2"><font size="10"><b>Swift Messages and Advices</b></font></td></tr>
</table>
$%if DeliveryAdvice[C].lastInstance() > 0$
<font size="8">
<table width="100%" border="0" bordercolor="ffffff" cellspacing="2" cellpadding="4">
  <tr>
  <td bgcolor="95B3D7"><b>Message Type</b></td>
  <td bgcolor="95B3D7"><b>Delivered To/From</b></td>
  <td bgcolor="95B3D7"><b>Date</b></td>
  <td bgcolor="95B3D7"><b>Inward / Outward</b></td>  
  </tr>
  $%for 1 to DeliveryAdvice[C].lastInstance() $
  <tr>
  <td bgcolor="DBE5F1">$$DeliveryAdvice[C].MessageType$</td>
  <td bgcolor="DBE5F1">$$DeliveryAdvice[C].ShortName$</td>
  <td bgcolor="DBE5F1">$$DeliveryAdvice[C].BankDate$</td>
  <td bgcolor="DBE5F1">$$DeliveryAdvice[C].MessageCategory$</td>
  </tr>
  $%endfor$
</table>
</font>
$%endif$
$%if DeliveryAdvice[C].lastInstance() == 0$
<font size="8">
<table width="100%" border="0" bordercolor="ffffff" cellspacing="2" cellpadding="4">
  <tr><td bgcolor="DBE5F1">There are no swift details to display</td></tr>
</table>
</font>
$%endif$
$%endif$
</div>

</center>
</page>
</pdf>