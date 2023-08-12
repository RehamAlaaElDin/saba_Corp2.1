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
<tr><td bgcolor="95B3D7">Transaction Reference</td><td bgcolor="95B3D7"> $$InputParameters[1].GuaranteeId$ </td></tr>
</table>

<div style="width:100%;clear:both;">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
  $%if GuaranteeDetails[C].Currency != ''$
  <tr>
    <td bgcolor="DBE5F1"><b>Currency</b></td> 
	<td bgcolor="DBE5F1">$$GuaranteeDetails[C].Currency$</td>	
  </tr>
   $%endif$
   $%if GuaranteeDetails[C].PrincipalAmount != ''$
   <tr>
     <td bgcolor="DBE5F1"><b>Guarantee Amount</b></td>
     <td bgcolor="DBE5F1">$$GuaranteeDetails[C].PrincipalAmount$</td>
   </tr>
   $%endif$
   $%if GuaranteeDetails[C].BenefCust1[C].BenefCustName != ''$
    <tr>
	 <td bgcolor="DBE5F1"><b>Beneficiary Name</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeDetails[C].BenefCust1[C].BenefCustName$</td>
	</tr>
    $%endif$	  
    $%if GuaranteeDetails[C].DealDate != ''$
	<tr>
	 <td bgcolor="DBE5F1"><b>Start Date</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeDetails[C].DealDate$</td>
	</tr>
    $%endif$	
    $%if GuaranteeDetails[C].MaturityDate != ''$  
	<tr>
	 <td bgcolor="DBE5F1"><b>Expiry Date</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeDetails[C].MaturityDate$</td>
	</tr>
	$%endif$	
	$%if GuaranteeDetails[C].CategoryName != ''$  
    <tr>
	 <td bgcolor="DBE5F1"><b>Type Of Guarantee</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeDetails[C].CategoryName$</td>
	</tr>
	$%endif$
	$%if GuaranteeDetails[C].BenAddress[C].BenAddress != ''$  
	<tr>
     <td bgcolor="DBE5F1"><b>Beneficiary Address</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeDetails[C].BenAddress[C].BenAddress$</td>
	</tr>
	$%endif$	
	$%if GuaranteeDetails[C].Reference2 != ''$  
    <tr>
	 <td bgcolor="DBE5F1"><b>Client Reference</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeDetails[C].Reference2$</td>
	</tr>
	$%endif$	
    $%if GuaranteeDetails[C].LimitExReason != ''$  
	<tr>
	 <td bgcolor="DBE5F1"><b>Limit Exceed Remarks</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeDetails[C].LimitExReason$</td>
	</tr>
    $%endif$
    $%if WorkingElements[1].FormattedGuaranteeDetails != ''$  
    <tr>
	 <td bgcolor="DBE5F1"><b>Terms And Conditions</b></td>
	 <td bgcolor="DBE5F1">$$WorkingElements[1].FormattedGuaranteeDetails$</td>
	</tr>
	$%endif$	
	$%if GuaranteeDetails[C].ChargeDate[C].ChargeAccount != ''$   
	<tr>
	 <td bgcolor="DBE5F1"><b>Charges Account</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeDetails[C].ChargeDate[C].ChargeAccount$</td>
    </tr>
	$%endif$
	$%if GuaranteeDetails[C].IbBkToCust != ''$   
	<tr>
	 <td bgcolor="DBE5F1"><b>Message From Bank</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeDetails[C].IbBkToCust$</td>
    </tr>  
    $%endif$
    $%if GuaranteeDetails[C].Customer != ''$ 
	<tr>
	 <td bgcolor="DBE5F1"><b>Customer</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeDetails[C].Customer$</td>
    </tr>
	$%endif$	
	$%if GuaranteeDetails[C].CsnDate[C].CsnAccount != ''$  
	<tr>
	 <td bgcolor="DBE5F1"><b>Commission Account</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeDetails[C].CsnDate[C].CsnAccount$</td>
    </tr>
	$%endif$
	$%if GuaranteeDetails[C].InvDrAccount != ''$  
	<tr>
	 <td bgcolor="DBE5F1"><b>Invocation Account</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeDetails[C].InvDrAccount$</td>
    </tr>
	$%endif$
	$%if GuaranteeDetails[C].ProvDrAccount != ''$ 
	<tr>
	 <td bgcolor="DBE5F1"><b>Cash Margin Account</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeDetails[C].ProvDrAccount$</td>
    </tr>
	$%endif$
	$%if GuaranteeDetails[C].IbCustToBk != ''$ 
	<tr>
	 <td bgcolor="DBE5F1"><b>Message/Response To Bank</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeDetails[C].IbCustToBk$</td>
    </tr>
	$%endif$
</table>
</div>

$%if GuaranteeDetails[C].SgIssued != '' OR GuaranteeDetails[C].LcReference != '' OR GuaranteeDetails[C].SupportDocs != '' OR GuaranteeDetails[C].OtherInformation != ''$
<div style="width:100%;clear:both;">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">  
<tr><td rowspan="2"><font size="10"><b>Shipping Details</b></font></td></tr> 
</table>
<font size="8">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
  $%if GuaranteeDetails[C].SgIssued != ''$
  <tr>
    <td bgcolor="DBE5F1"><b>Shipping Guarantee Issued</b></td> 
	<td bgcolor="DBE5F1">$$GuaranteeDetails[C].SgIssued$</td>	
  </tr>
   $%endif$
   $%if GuaranteeDetails[C].LcReference != ''$
   <tr>
     <td bgcolor="DBE5F1"><b>L/C Or Collection Ref</b></td>
     <td bgcolor="DBE5F1">$$GuaranteeDetails[C].LcReference$</td>
   </tr>
   $%endif$
   $%if GuaranteeDetails[C].SupportDocs != ''$
    <tr>
	 <td bgcolor="DBE5F1"><b>Support Documents</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeDetails[C].SupportDocs$</td>
	</tr>
    $%endif$	  
    $%if GuaranteeDetails[C].OtherInformation != ''$
	<tr>
	 <td bgcolor="DBE5F1"><b>Additional Information</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeDetails[C].OtherInformation$</td>
	</tr>
    $%endif$	
</table>
</font>
</div>
$%endif$

$%if InvocationHistoryDetails[C].lastInstance() > 0 $
<div style="width:100%;clear:both;">
<br />
<br />
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
<tr><td rowspan="2"><font size="10"><b>Invocation History</b></font></td></tr>
</table>
<font size="8">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
  <tr>
    <td bgcolor="DBE5F1"><b>Amount</b></td>
	<td bgcolor="DBE5F1"><b>Date</b></td>
	<td bgcolor="DBE5F1"><b>Action</b></td>
  </tr>
$%for 1 to InvocationHistoryDetails[C].lastInstance() $
  <tr>
    <td bgcolor="DBE5F1">$$InvocationHistoryDetails[C].HistoryData[C].Amount$</td>
    <td bgcolor="DBE5F1">$$InvocationHistoryDetails[C].HistoryData[C].Date$</td>
	<td bgcolor="DBE5F1">$$InvocationHistoryDetails[C].HistoryData[C].Action$</td>
  </tr>
$%endfor$
</table>
</font>
</div>
$%endif$

<div style="width:100%;clear:both;">
<br/>
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
</div>

</font>
</center>
</page>
</pdf>