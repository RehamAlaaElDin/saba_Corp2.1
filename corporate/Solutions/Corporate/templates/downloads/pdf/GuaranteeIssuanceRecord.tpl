<pdf baseFont="Helvetica,Cp1252,false">
<page>
<footer align="center" page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img></right>
<center>
<br />
<br />
<font size="15">Guarantee Record</font>
<br />
<br />

<font size="8">
<table width="100%" border="0" bordercolor="ffffff" cellspacing="2" cellpadding="2">
<tr><td bgcolor="95B3D7">Transaction Reference</td><td bgcolor="95B3D7"> $$InputParameters[1].GuaranteeId$</td></tr>
</table>

<div style="width:100%;clear:both;">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
  $%if GuaranteeIssuanceRequestDetails[C].Currency != ''$
  <tr>
    <td bgcolor="DBE5F1"><b>Currency</b></td> 
	<td bgcolor="DBE5F1">$$GuaranteeIssuanceRequestDetails[C].Currency$</td>	
  </tr>
   $%endif$
   $%if GuaranteeIssuanceRequestDetails[C].PrincipalAmount != ''$
   <tr>
     <td bgcolor="DBE5F1"><b>Guarantee Amount</b></td>
     <td bgcolor="DBE5F1">$$GuaranteeIssuanceRequestDetails[C].PrincipalAmount$</td>
   </tr>
   $%endif$
   $%if GuaranteeIssuanceRequestDetails[C].Beneficiary[1].Beneficiary != ''$
    <tr>
	 <td bgcolor="DBE5F1"><b>Beneficiary Name</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeIssuanceRequestDetails[C].Beneficiary[1].Beneficiary$</td>
	</tr>
    $%endif$	  
    $%if GuaranteeIssuanceRequestDetails[C].StartDate != ''$
	<tr>
	 <td bgcolor="DBE5F1"><b>Start Date</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeIssuanceRequestDetails[C].StartDate$</td>
	</tr>
    $%endif$	
    $%if GuaranteeIssuanceRequestDetails[C].MaturityDate != ''$  
	<tr>
	 <td bgcolor="DBE5F1"><b>Expiry Date</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeIssuanceRequestDetails[C].MaturityDate$</td>
	</tr>
	$%endif$	
	$%if GuaranteeListDetails[1].GuaranteeListDetails[C].TypeOfMd != ''$  
    <tr>
	 <td bgcolor="DBE5F1"><b>Type Of Guarantee</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeListDetails[1].GuaranteeListDetails[C].TypeOfMd$</td>
	</tr>
	$%endif$
	$%if GuaranteeIssuanceRequestDetails[C].BeneficiaryDetails != ''$  
	<tr>
     <td bgcolor="DBE5F1"><b>Beneficiary Address</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeIssuanceRequestDetails[C].BeneficiaryDetails$</td>
	</tr>
	$%endif$	
	$%if GuaranteeIssuanceRequestDetails[C].ClientReference != ''$  
    <tr>
	 <td bgcolor="DBE5F1"><b>Client Reference</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeIssuanceRequestDetails[C].ClientReference$</td>
	</tr>
	$%endif$	
    $%if GuaranteeIssuanceRequestDetails[C].LimitExReason[C].LimitExReason[C].LimitExReason != ''$  
	<tr>
	 <td bgcolor="DBE5F1"><b>Limit Exceed Remarks</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeIssuanceRequestDetails[C].LimitExReason[C].LimitExReason[C].LimitExReason$</td>
	</tr>
    $%endif$
    $%if WorkingElements[1].FormattedGuaranteeDetails != ''$  
    <tr>
	 <td bgcolor="DBE5F1"><b>Terms And Conditions</b></td>
	 <td bgcolor="DBE5F1">$$WorkingElements[1].FormattedGuaranteeDetails$</td>
	</tr>
	$%endif$	
	$%if GuaranteeIssuanceRequestDetails[C].ChargeDrAccount != ''$   
	<tr>
	 <td bgcolor="DBE5F1"><b>Charges Account</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeIssuanceRequestDetails[C].ChargeDrAccount$</td>
    </tr>
	$%endif$
	$%if GuaranteeIssuanceRequestDetails[C].IbBkToCust[C].IbBkToCust != '' AND GuaranteeListDetails[1].GuaranteeListDetails[C].StatusForDisplay != 'Rejected'$
	<tr>
	 <td bgcolor="DBE5F1"><b>Message From Bank</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeIssuanceRequestDetails[C].IbBkToCust[C].IbBkToCust$</td>
    </tr>  
    $%endif$
    $%if GuaranteeIssuanceRequestDetails[C].Customer != ''$ 
	<tr>
	 <td bgcolor="DBE5F1"><b>Customer</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeIssuanceRequestDetails[C].Customer$</td>
    </tr>
	$%endif$	
	$%if GuaranteeIssuanceRequestDetails[C].CommDrAccount != ''$  
	<tr>
	 <td bgcolor="DBE5F1"><b>Commission Account</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeIssuanceRequestDetails[C].CommDrAccount$</td>
    </tr>
	$%endif$
	$%if GuaranteeIssuanceRequestDetails[C].InvDrAccount != ''$  
	<tr>
	 <td bgcolor="DBE5F1"><b>Invocation Account</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeIssuanceRequestDetails[C].InvDrAccount$</td>
    </tr>
	$%endif$
	$%if GuaranteeIssuanceRequestDetails[C].ProvDrAccount != ''$ 
	<tr>
	 <td bgcolor="DBE5F1"><b>Cash Margin Account</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeIssuanceRequestDetails[C].ProvDrAccount$</td>
    </tr>
	$%endif$
	$%if GuaranteeIssuanceRequestDetails[C].IbCustToBk[C].IbCustToBk != ''$ 
	<tr>
	 <td bgcolor="DBE5F1"><b>Message/Response To Bank</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeIssuanceRequestDetails[C].IbCustToBk[C].IbCustToBk$</td>
    </tr>
	$%endif$
</table>
</div>

$%if GuaranteeIssuanceRequestDetails[C].SgIssued != '' OR GuaranteeIssuanceRequestDetails[C].LcReference != '' OR GuaranteeIssuanceRequestDetails[C].SupportDocs[C].DocumentName != '' OR GuaranteeIssuanceRequestDetails[C].OtherInformation[C].OtherInformation[C].OtherInformation != ''$
<div style="width:100%;clear:both;">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">  
<tr><td rowspan="2"><font size="10"><b>Shipping Details</b></font></td></tr> 
</table>
<font size="8">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
  $%if GuaranteeIssuanceRequestDetails[C].SgIssued != ''$
  <tr>
    <td bgcolor="DBE5F1"><b>Shipping Guarantee Issued</b></td> 
	<td bgcolor="DBE5F1">$$GuaranteeIssuanceRequestDetails[C].SgIssued$</td>	
  </tr>
   $%endif$
   $%if GuaranteeIssuanceRequestDetails[C].LcReference != ''$
   <tr>
     <td bgcolor="DBE5F1"><b>L/C Or Collection Ref</b></td>
     <td bgcolor="DBE5F1">$$GuaranteeIssuanceRequestDetails[C].LcReference$</td>
   </tr>
   $%endif$
   $%if GuaranteeIssuanceRequestDetails[C].SupportDocs[C].SupportDocs != ''$
    <tr>
	 <td bgcolor="DBE5F1"><b>Support Documents</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeIssuanceRequestDetails[C].SupportDocs[C].SupportDocs$</td>
	</tr>
    $%endif$	  
    $%if GuaranteeIssuanceRequestDetails[C].OtherInformation[C].OtherInformation[C].OtherInformation != ''$
	<tr>
	 <td bgcolor="DBE5F1"><b>Additional Information</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeIssuanceRequestDetails[C].OtherInformation[C].OtherInformation[C].OtherInformation$</td>
	</tr>
    $%endif$	
</table>
</font>
</div>
$%endif$

$%if GuaranteeIssuanceRequestDetails[C].IbBkToCust[C].IbBkToCust != '' AND GuaranteeListDetails[1].GuaranteeListDetails[C].StatusForDisplay == 'Rejected'$
<div style="width:100%;clear:both;">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
<tr><td rowspan="2"><font size="10"><b>Reason for Rejection</b></font></td></tr>
</table>
<font size="8">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
  <tr>
	<td bgcolor="DBE5F1"><b>Message From Bank</b></td>
    <td bgcolor="DBE5F1">$$GuaranteeIssuanceRequestDetails[C].IbBkToCust[C].IbBkToCust$</td>
  </tr>
</table>
</font>
</div> 
$%endif$   

 </font>
</center>
</page>
</pdf>