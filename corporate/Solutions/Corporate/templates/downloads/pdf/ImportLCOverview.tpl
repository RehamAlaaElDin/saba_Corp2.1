<pdf baseFont="Helvetica,Cp1252,false" charset=UTF-8>
<page>
<footer align="center" page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img></right>
<center>
<br />
<br />
<font size="15">Import Letter Of Credit</font>
<br />
<br />
<font size="8">
<table width="100%" border="0" bordercolor="ffffff" cellspacing="2" cellpadding="4">
<tr>
<td bgcolor="95B3D7">User Name</td><td bgcolor="95B3D7">$$InputParameters[1].UserId$</td>
</tr>
<tr>
<td bgcolor="95B3D7">Transaction Reference</td><td bgcolor="95B3D7">$$InputParameters[1].LetterOfCreditNo$</td>
</tr>
</table>
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
<tr><td rowspan="2"><font size="10"><b>LC Details</b></font></td></tr>
</table>
<font size="8">
<!---LC Details--->
<div style="width:100%;clear:both;">
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
    $%if LetterOfCreditOverview[C].PercentageDrAmt != ''$ 
  <tr>
	   <td bgcolor="DBE5F1"><b>Tolerance -</b></td>
	   <td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].PercentageDrAmt$</td>
  </tr>
  $%endif$
  $%if LetterOfCreditOverview[C].PercentageCrAmt != ''$ 
  <tr>
	   <td bgcolor="DBE5F1"><b>Tolerance +</b></td>
	   <td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].PercentageCrAmt$</td>
  </tr>
  $%endif$
   $%if LetterOfCreditOverview[C].MaximumCrAmt != ''$
  <tr>  
     <td bgcolor="DBE5F1"><b>Maximum Credit Amount</b></td>
	 <td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].MaximumCrAmt$</td>
  </tr>
  $%endif$
   $%if LetterOfCreditOverview[C].PayTerms != ''$
  <tr>  
     <td bgcolor="DBE5F1"><b>Payment Terms</b></td>
	 <td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].PayTerms$</td>
  </tr>
  $%endif$
   $%if LetterOfCreditOverview[C].ExpiryPlace != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Expiry Place</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].ExpiryPlace$</td>
	</tr>
   $%endif$
   $%if LetterOfCreditOverview[C].ChargesAccount != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Charges Account</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].ChargesAccount$</td>
	</tr>
   $%endif$
   $%if LetterOfCreditOverview[C].CommAccount != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Commission Account</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].CommAccount$</td>
	</tr>
   $%endif$
   $%if LetterOfCreditOverview[C].ProvisAcc != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Margin Account</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].ProvisAcc$</td>
	</tr>
   $%endif$
   $%if LetterOfCreditOverview[C].IbReason[C].IbReason[C].IbReason != '' AND InputParameters[1].ImportLetterOfCreditList[C].StatusForDisplay != 'Rejected'$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Message from Bank</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].IbReason[C].IbReason[C].IbReason$</td>
	</tr>
   $%endif$
   $%if LetterOfCreditOverview[C].IbCustToBk[C].IbCustToBk[C].IbCustToBk != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Message/Response to bank</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].IbCustToBk[C].IbCustToBk[C].IbCustToBk$</td>
	</tr>
   $%endif$
</table>
</div>
</font>

$%if LetterOfCreditOverview[C].Beneficiary_Details[C].BeneficiaryDetails != ''$
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
<tr><td rowspan="2"><font size="10"><b>Beneficiary</b></font></td></tr>
</table>
<font size="8">
<div style="width:100%;clear:both;">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
  <tr>
     <td bgcolor="DBE5F1"><b>Name and address</b></td>
	 <td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].Beneficiary_Details[C].BeneficiaryDetails$</td>
  </tr>
</table>
</div>
</font>
$%endif$

$%if LetterOfCreditOverview[C].AdvisingBk[C].AdvisingBk != ''$
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
<tr><td rowspan="2"><font size="10"><b>Beneficiary Bank</b></font></td></tr>
</table>
<font size="8">
<div style="width:100%;clear:both;">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
  <tr>
     <td bgcolor="DBE5F1"><b>Bene bank name and address</b></td>
	 <td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].AdvisingBk[C].AdvisingBk$</td>
  </tr>
</table>
</div>
</font>
$%endif$

$%if LetterOfCreditOverview[C].LatestShipment != '' OR LetterOfCreditOverview[C].PresentPeriod[C].PresentPeriod != ''$
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
<tr><td rowspan="2"><font size="10"><b>Shipment</b></font></td></tr>
</table>
<font size="8">
<div style="width:100%;clear:both;">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
	$%if LetterOfCreditOverview[C].LatestShipment != ''$
		<tr>
			<td bgcolor="DBE5F1"><b>Latest Shipment Date</b></td>
			<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].LatestShipment$</td>
		</tr>
	$%endif$
	$%if LetterOfCreditOverview[C].PresentPeriod[C].PresentPeriod != ''$
		<tr>
			<td bgcolor="DBE5F1"><b>Presentation Period</b></td>
			<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].PresentPeriod[C].PresentPeriod$</td>
		</tr>
	$%endif$
</table>
</div>
</font>
$%endif$

$%if LetterOfCreditOverview[C].DescGoods[C].DescGoods != '' OR LetterOfCreditOverview[C].DocumentId != '' OR LetterOfCreditOverview[C].DocumentCode[1].DocumentCode != '' OR LetterOfCreditOverview[C].DocumentsReq[C].DocumentsReq != '' OR LetterOfCreditOverview[C].ClausesText[C].ClausesText[C].ClausesText != '' OR LetterOfCreditOverview[C].AdditionlConds[C].AdditionlConds != '' OR LetterOfCreditOverview[C].SupportDocs[C].SupportDocs != '' OR LetterOfCreditOverview[C].ConfirmInst != '' $
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
<tr><td rowspan="2"><font size="10"><b>Document & Terms</b></font></td></tr>
</table>
<font size="8">
<div style="width:100%;clear:both;">
$%if LetterOfCreditOverview[C].DescGoods[C].DescGoods != ''$
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
	<tr>
	    <td bgcolor="DBE5F1"><b>Description Of Goods</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].DescGoods[C].DescGoods$</td>
	</tr>
</table>
$%endif$
$%if LetterOfCreditOverview[C].DocumentId != '' OR LetterOfCreditOverview[C].DocumentCode[1].DocumentCode != ''$
	<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
		$%if LetterOfCreditOverview[C].DocumentId != ''$ 
		<tr>
			<td bgcolor="DBE5F1"><b>Document Id</b></td>
			<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].DocumentId$</td>
		</tr>
		$%endif$
		$%if LetterOfCreditOverview[C].DocumentCode[1].DocumentCode != ''$
			$%for 1 to LetterOfCreditOverview[C].DocumentCode[C].lastInstance() $
			<tr>
				<td bgcolor="DBE5F1"><b>Document Code.$$LetterOfCreditOverview[C].DocumentCode[C].instance()$</b></td>
				<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].DocumentCode[C].DocumentCode$</td>
			</tr>
			<tr>
				<td bgcolor="DBE5F1"><b>Document Text</b></td>
				<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].DocumentCode[C].DocumentTxt[1].DocumentTxt$</td>
			</tr>
			$%endfor$
		$%endif$
	</table>
$%endif$
$%if LetterOfCreditOverview[C].DocumentsReq[C].DocumentsReq != '' OR LetterOfCreditOverview[C].ClausesText[C].ClausesText[C].ClausesText != '' OR LetterOfCreditOverview[C].AdditionlConds[C].AdditionlConds != '' OR LetterOfCreditOverview[C].SupportDocs[C].SupportDocs != '' OR LetterOfCreditOverview[C].ConfirmInst != '' $
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
	$%if LetterOfCreditOverview[C].DocumentsReq[C].DocumentsReq != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Document Required</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].DocumentsReq[C].DocumentsReq$</td>
	</tr>
   $%endif$
   $%if LetterOfCreditOverview[C].ClausesText[C].ClausesText[C].ClausesText != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Additional Conditions code</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].ClausesText[C].ClausesText[C].ClausesText$</td>
	</tr>
   $%endif$
   $%if LetterOfCreditOverview[C].AdditionlConds[C].AdditionlConds != ''$ 
    <tr>
        <td bgcolor="DBE5F1"><b>Other Additional Conditions</b></td>
        <td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].AdditionlConds[C].AdditionlConds$</td>
    </tr>
   $%endif$
   $%if LetterOfCreditOverview[C].SupportDocs[C].SupportDocs != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Support Documents</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].SupportDocs[C].SupportDocs$</td>
	</tr>
   $%endif$
   $%if LetterOfCreditOverview[C].ConfirmInst != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Confirmation Instructions</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].ConfirmInst$</td>
	</tr>
   $%endif$
</table>
$%endif$
</div>
</font>
$%endif$

$%if InputParameters[1].ImportLetterOfCreditList[C].StatusForDisplay == 'Rejected' AND LetterOfCreditOverview[C].IbReason[C].IbReason[C].IbReason != '' $
<div style="width:100%;clear:both;">
<br/>
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
<tr><td rowspan="2"><font size="10"><b>Reason for rejection</b></font></td></tr>
</table>
<font size="8">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
$%if LetterOfCreditOverview[C].IbReason[C].IbReason[C].IbReason != ''$
  <tr> 
  <td bgcolor="DBE5F1"><b>Rejected reason</b></td>
  <td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].IbReason[C].IbReason[C].IbReason$</td>
  </tr>  
$%endif$
</table>
</font>
</div>
$%endif$

<div style="width:100%;clear:both;">
<br/>
$%if InputParameters[1].ImportLetterOfCreditList[C].StatusForDisplay == "Approved"$
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