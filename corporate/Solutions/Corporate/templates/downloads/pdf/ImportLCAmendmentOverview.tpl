<pdf baseFont="Helvetica,Cp1252,false" charset=UTF-8>
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
<table width="100%" border="0" bordercolor="ffffff" cellspacing="2" cellpadding="4">
<tr>
<td bgcolor="95B3D7">User Name</td><td bgcolor="95B3D7">$$InputParameters[1].UserId$</td>
</tr>
<tr>
<td bgcolor="95B3D7">Transaction Reference</td><td bgcolor="95B3D7">$$InputParameters[1].LCAmendmentNo$</td>
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
</table>
</div>
</font>

<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
<tr><td rowspan="2"><font size="10"><b>LC Amendment Details</b></font></td></tr>
</table>
<font size="8">
<!---LC Details--->
<div style="width:100%;clear:both;">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
  $%if LCAmendmentOverview[C].IncDecAmount != ''$
  <tr>
     <td bgcolor="DBE5F1"><b>Increase/Decrease LC Amount</b></td>
	 <td bgcolor="DBE5F1">$$LCAmendmentOverview[C].IncDecAmount$</td>
  </tr>
  $%endif$
   $%if LCAmendmentOverview[C].IbLimitExceed[C].IbLimitExceed != ''$
  <tr>
      	<td bgcolor="DBE5F1"><b>Limit Exceed Remarks</b></td>
		<td bgcolor="DBE5F1">$$LCAmendmentOverview[C].IbLimitExceed[C].IbLimitExceed$</td>
  </tr>
   $%endif$
   $%if LCAmendmentOverview[C].DecCrAmount != ''$
  <tr>
	 <td bgcolor="DBE5F1"><b>New Debit Tolerance</b></td>
	 <td bgcolor="DBE5F1">$$LCAmendmentOverview[C].DecCrAmount$</td>
 </tr>
 $%endif$
   $%if LCAmendmentOverview[C].IncCrAmount != ''$
	<tr>
      	<td bgcolor="DBE5F1"><b>New Credit Tolerance</b></td>
		<td bgcolor="DBE5F1">$$LCAmendmentOverview[C].IncCrAmount$</td>
	</tr>
   $%endif$
   $%if LCAmendmentOverview[C].AddAmtCovered[C].AddAmtCovered != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Additional Amount Covered</b></td>
		<td bgcolor="DBE5F1">$$LCAmendmentOverview[C].AddAmtCovered[C].AddAmtCovered$</td>
	</tr>
   $%endif$
   $%if LCAmendmentOverview[C].MaximumCrAmt != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>New Max Credit Amount</b></td>
		<td bgcolor="DBE5F1">$$LCAmendmentOverview[C].MaximumCrAmt$</td>
	</tr>
   $%endif$
   $%if LCAmendmentOverview[C].NewAdvExpDate != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>New LC Expiry Date</b></td>
		<td bgcolor="DBE5F1">$$LCAmendmentOverview[C].NewAdvExpDate$</td>
	</tr>
   $%endif$
   $%if LCAmendmentOverview[C].IbCustToBk[C].IbCustToBk != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Response To Bank</b></td>
		<td bgcolor="DBE5F1">$$LCAmendmentOverview[C].IbCustToBk[C].IbCustToBk$</td>
	</tr>
   $%endif$
   $%if LCAmendmentOverview[C].ShipDespatch != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Place Of Taking In Charge</b></td>
		<td bgcolor="DBE5F1">$$LCAmendmentOverview[C].ShipDespatch$</td>
	</tr>
   $%endif$
   $%if LCAmendmentOverview[C].OtherDespatchDet != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Port Of Loading</b></td>
		<td bgcolor="DBE5F1">$$LCAmendmentOverview[C].OtherDespatchDet$</td>
	</tr>
   $%endif$
   $%if LCAmendmentOverview[C].Transportation != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Port Of Discharge</b></td>
		<td bgcolor="DBE5F1">$$LCAmendmentOverview[C].Transportation$</td>
	</tr>
   $%endif$
   $%if LCAmendmentOverview[C].FinalDestination != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Final Destination</b></td>
		<td bgcolor="DBE5F1">$$LCAmendmentOverview[C].FinalDestination$</td>
	</tr>
   $%endif$
   $%if LCAmendmentOverview[C].ShipmentPeriod[C].ShipmentPeriod != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Shipment Period</b></td>
		<td bgcolor="DBE5F1">$$LCAmendmentOverview[C].ShipmentPeriod[C].ShipmentPeriod$</td>
	</tr>
   $%endif$
   $%if LCAmendmentOverview[C].LatestShipment != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Latest Shipment Date</b></td>
		<td bgcolor="DBE5F1">$$LCAmendmentOverview[C].LatestShipment$</td>
	</tr>
   $%endif$
   $%if LCAmendmentOverview[C].Narrative[C].Narrative[C].Narrative != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Narrative</b></td>
		<td bgcolor="DBE5F1">$$LCAmendmentOverview[C].Narrative[C].Narrative[C].Narrative$</td>
	</tr>
   $%endif$
   $%if LCAmendmentOverview[C].IbBkToCust[C].IbBkToCust != '' AND InputParameters[1].ImportLCAmendmentList[C].StatusForDisplay != 'Rejected'$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Message From Bank</b></td>
		<td bgcolor="DBE5F1">$$LCAmendmentOverview[C].IbBkToCust[C].IbBkToCust$</td>
	</tr>
   $%endif$
</table>
</div>
</font>

$%if InputParameters[1].ImportLCAmendmentList[C].StatusForDisplay == 'Rejected' AND LCAmendmentOverview[C].IbBkToCust[C].IbBkToCust != '' $
<div style="width:100%;clear:both;">
<br/>
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
<tr><td rowspan="2"><font size="10"><b>Reason for rejection</b></font></td></tr>
</table>
<font size="8">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
$%if LCAmendmentOverview[C].IbBkToCust[C].IbBkToCust != ''$
  <tr> 
    <td bgcolor="DBE5F1"><b>Rejected reason</b></td>
  <td bgcolor="DBE5F1">$$LCAmendmentOverview[C].IbBkToCust[C].IbBkToCust$</td>
  </tr>  
$%endif$
</table>
</font>
</div>
$%endif$

<div style="width:100%;clear:both;">
<br/>
$%if InputParameters[1].ImportLCAmendmentList[C].StatusForDisplay == "Approved"$
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