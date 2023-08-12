<pdf baseFont="Helvetica,Cp1252,false">
<page>
<footer align="center" page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img></right>
<center>
<br />
<br />
<font size="15">Inward Guarantee Amendment Record</font>
<br />
<br />

<font size="8">
<table width="100%" border="0" bordercolor="ffffff" cellspacing="2" cellpadding="2">
<tr><td bgcolor="95B3D7">Transaction Reference</td><td bgcolor="95B3D7"> $$InputParameters[1].GuaranteeId$</td></tr>
</table>

<div style="width:100%;clear:both;">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">  
<tr><td rowspan="2"><font size="10"><b>Guarantee Details</b></font></td></tr> 
</table>
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
   $%if GuaranteeDetails[C].Customer != ''$
    <tr>
	 <td bgcolor="DBE5F1"><b>Issued By</b></td>
	 <td bgcolor="DBE5F1">$$GuaranteeDetails[C].Customer$</td>
	</tr>
    $%endif$
   $%if GuaranteeDetails[C].ValueDate != ''$
	<tr>
		<td bgcolor="DBE5F1"><b>Start Date</b></td>
		<td bgcolor="DBE5F1">$$GuaranteeDetails[C].ValueDate$</td>
	</tr>
    $%endif$
	$%if GuaranteeDetails[C].AdviceExpiryDate != ''$
	<tr>
		<td bgcolor="DBE5F1"><b>Expiry Date</b></td>
		<td bgcolor="DBE5F1">$$GuaranteeDetails[C].AdviceExpiryDate$</td>
	</tr>
    $%endif$
   $%if GuaranteeDetails[C].CategoryName != ''$  
    <tr>
		<td bgcolor="DBE5F1"><b>Type Of Guarantee</b></td>
		<td bgcolor="DBE5F1">$$GuaranteeDetails[C].CategoryName$</td>
	</tr>
	$%endif$
	$%if GuaranteeDetails[C].Reference1 != ''$  
    <tr>
		<td bgcolor="DBE5F1"><b>Issuing Bank Reference</b></td>
		<td bgcolor="DBE5F1">$$GuaranteeDetails[C].Reference1$</td>
	</tr>
	$%endif$
    $%if WorkingElements[1].FormattedGuaranteeDetails != ''$  
	<tr>
		<td bgcolor="DBE5F1"><b>Terms And Conditions</b></td>
		<td bgcolor="DBE5F1">$$WorkingElements[1].FormattedGuaranteeDetails$</td>
	</tr>
	$%endif$
</table>
</div>

<div style="width:100%;clear:both;">
<br />
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
<tr><td rowspan="2"><font size="10"><b>Amendment Details</b></font><font size="8"></td></tr>
</table>
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
<tr><td rowspan="2"><font size="10"><b>Past Amendments</b></font></td></tr>
</table>
<font size="8">
$%if ReceivedGuaranteeHistoryDetails[C].PreviousAmendmentDetails[1].EffectiveDate != ''$
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
  <tr>
    <td bgcolor="DBE5F1"><b>Effective Date</b></td>
	<td bgcolor="DBE5F1"><b>Principal Amount</b></td>
  </tr>
  $%for 1 to ReceivedGuaranteeHistoryDetails[C].PreviousAmendmentDetails[C].lastInstance() $
	<tr>
		<td bgcolor="DBE5F1">$$ReceivedGuaranteeHistoryDetails[C].PreviousAmendmentDetails[C].EffectiveDate$</td>
		<td bgcolor="DBE5F1">$$ReceivedGuaranteeHistoryDetails[C].PreviousAmendmentDetails[C].PrincipalBalance$</td>
	</tr>
  $%endfor$
</font>
</table>
$%endif$
$%if ReceivedGuaranteeHistoryDetails[C].PreviousAmendmentDetails[1].EffectiveDate == ''$
<font size="8">
<table width="100%" border="0" bordercolor="ffffff" cellspacing="2" cellpadding="4">
  <tr><td bgcolor="DBE5F1">There are no past amendments to display</td></tr>
</table>
</font>
$%endif$
</div>

<div style="width:100%;clear:both;">
<br />
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
<tr><td rowspan="2"><font size="10"><b>Future Amendments</b></font></td></tr>
</table>
<font size="8">
$%if GuaranteeDetails[C].PrinMovement[1].MovementEffectiveDate != ''$
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
  <tr>
    <td bgcolor="DBE5F1"><b>Effective Date</b></td>
	<td bgcolor="DBE5F1"><b>Increase/Decrease in Amount</b></td>
  </tr>
$%for 1 to GuaranteeDetails[C].PrinMovement[C].lastInstance() $
  <tr>
    <td bgcolor="DBE5F1">$$GuaranteeDetails[C].PrinMovement[C].MovementEffectiveDate$</td>
    <td bgcolor="DBE5F1">$$GuaranteeDetails[C].PrinMovement[C].PrinMovement$</td>
  </tr>
$%endfor$
</font>
</table>
$%endif$
$%if GuaranteeDetails[C].PrinMovement[1].MovementEffectiveDate == ''$
<font size="8">
<table width="100%" border="0" bordercolor="ffffff" cellspacing="2" cellpadding="4">
  <tr><td bgcolor="DBE5F1">There are no future amendments to display</td></tr>
</table>
</font>
$%endif$
</div>

<div style="width:100%;clear:both;">
<br />
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
	$%if GuaranteeDetails[C].AmendedExpiryDate != ''$  
	    <tr>
	<td bgcolor="DBE5F1"><b>Expiry Date</b></td>
	<td bgcolor="DBE5F1">$$GuaranteeDetails[C].AmendedExpiryDate$</td>
	  </tr>
$%endif$
</table>
</div>

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