<pdf baseFont="Helvetica,Cp1252,false" charset=UTF-8>
<page>
<footer align="center" page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img>
<center>
<br />
<br />
<font size="15">Inward Collection</font>
<br />
<br />
<font size="8">
<table width="100%" border="0" bordercolor="ffffff" cellspacing="2" cellpadding="4">
<tr>
<td bgcolor="95B3D7">User Name</td><td bgcolor="95B3D7">$$InputParameters[1].UserID$</td>
</tr>
<tr>
<td bgcolor="95B3D7">Transaction Reference</td><td bgcolor="95B3D7">$$InputParameters[1].LetterOfCreditNo$</td>
</tr>
</table>
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
<tr><td rowspan="2"><font size="10"><b>Inward Collection Details</b></font></td></tr>
</table>
<font size="8">
<!---Inward Collection Details--->
<div style="width:100%;clear:both;">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
  $%if LetterOfCreditOverview[C].ExternalReference != ''$
  <tr>
     <td bgcolor="DBE5F1"><b>Drawer's reference</b></td>
	 <td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].ExternalReference$</td>
  </tr>
  $%endif$
   $%if LetterOfCreditOverview[C].Amount != ''$
  <tr>
      	<td bgcolor="DBE5F1"><b>Document amount</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].Currency$ $$LetterOfCreditOverview[C].Amount$</td>
  </tr>
   $%endif$
   $%if LetterOfCreditOverview[C].AdvisingBk[C].AdvisingBk != ''$
  <tr>
	 <td bgcolor="DBE5F1"><b>Remitting bank name and address</b></td>
	 <td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].AdvisingBk[C].AdvisingBk$</td>
 </tr>
 $%endif$
      $%if LetterOfCreditOverview[C].PayTerms != ''$
  <tr>
      	<td bgcolor="DBE5F1"><b>Document against</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].PayTerms$</td>
  </tr>
   $%endif$
   $%if LetterOfCreditOverview[C].Beneficiary_Details[C].BeneficiaryDetails != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Drawer name and address</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].Beneficiary_Details[C].BeneficiaryDetails$</td>
	</tr>
   $%endif$
    $%if LetterOfCreditOverview[C].Tenor != ''$ 
  <tr>
	   <td bgcolor="DBE5F1"><b>Tenor</b></td>
	   $%if LetterOfCreditOverview[C].Days != ''$ 
	   <td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].Days$ $$LetterOfCreditOverview[C].Tenor$</td>
	   $%endif$
	   $%if LetterOfCreditOverview[C].Days == ''$ 
	   <td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].Tenor$</td>
	   $%endif$	   
  </tr>
  $%endif$
   $%if LetterOfCreditOverview[C].ExpiryDate != ''$
  <tr>  
     <td bgcolor="DBE5F1"><b>Maturity date</b></td>
	 <td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].ExpiryDate$</td>
  </tr>
  $%endif$
    $%if LetterOfCreditOverview[C].DateAccepted != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Accepted maturity date</b></td>
		<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].DateAccepted$</td>
	</tr>
   $%endif$
</table>
</div>
</font>

<div style="width:100%;clear:both;">
<br/>
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
<tr><td rowspan="2"><font size="10"><b>Documents and Instructions</b></font></td></tr>
</table>

$%if LetterOfCreditOverview[C].DocumentCode[C].lastInstance() != -1 AND LetterOfCreditOverview[C].DocumentCode[C].DocumentCode != ''$
<font size="8">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
  <tr>
    <td bgcolor="DBE5F1"><b>Document code</b></td>
	<td bgcolor="DBE5F1"><b>Document description</b></td>
	<td bgcolor="DBE5F1"><b>Count of documents</b></td>
  </tr>
$%for 1 to LetterOfCreditOverview[C].DocumentCode[C].lastInstance() $
  <tr>
    <td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].DocumentCode[C].DocumentCode$</td>
	<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].DocumentCode[C].DocumentTxt[C].DocumentTxt$</td>
    <td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].DocumentCode[C].Doc1stCopies$</td>
  </tr>
$%endfor$
</table>
</font>
$%endif$

$%if LetterOfCreditOverview[C].DocumentCode[C].DocumentCode == ''$
<font size="8">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
  <tr style="border:1px solid #FFFFFF;"><td bgcolor="DBE5F1">No documents to display</td></tr>
</table>
</font>
$%endif$
</div>

<div style="width:100%;clear:both;">
<br />
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
	$%if LetterOfCreditOverview[C].AdditionlConds[C].AdditionlConds != ''$  
	    <tr>
	<td bgcolor="DBE5F1"><b>Instructions</b></td>
	<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].AdditionlConds[C].AdditionlConds$</td>
	  </tr>
$%endif$
</table>
</div>

$%if LetterOfCreditOverview[C].ApplicantAcc != '' OR LetterOfCreditOverview[C].IbReason[C].IbReason[C].IbReason != '' OR LetterOfCreditOverview[C].IbCustToBk[C].IbCustToBk[C].IbCustToBk != ''$

<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
<tr><td rowspan="2"><font size="10"><b>Account Details</b></font></td></tr>
</table>
<font size="8">
<!---Account Details--->
<div style="width:100%;clear:both;">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
  $%if LetterOfCreditOverview[C].ApplicantAcc != ''$
  <tr>
     <td bgcolor="DBE5F1"><b>Account to be debited</b></td>
	 <td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].ApplicantAcc$</td>
  </tr>
  $%endif$
  $%if InputParameters[1].InwardCollectionsList[C].EventStatus == 'Approved' OR InputParameters[1].InwardCollectionsList[C].EventStatus == 'PendBankApproval'$
	 $%if LetterOfCreditOverview[C].IbReason[C].IbReason[C].IbReason != ''$
		<tr>
			<td bgcolor="DBE5F1"><b>Message from Bank</b></td>
			<td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].IbReason[C].IbReason[C].IbReason$</td>
		</tr>
	$%endif$
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
$%endif$

$%if InputParameters[1].InwardCollectionsList[C].EventStatus == 'Rejected' AND LetterOfCreditOverview[C].IbReason[C].IbReason[C].IbReason != '' $
<div style="width:100%;clear:both;">
<br/>
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
<tr><td rowspan="2"><font size="10"><b>Reason for rejection</b></font></td></tr>
</table>
<font size="8">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
$%if LetterOfCreditOverview[C].IbReason[C].IbReason[C].IbReason != ''$
  <tr> 
  <td bgcolor="DBE5F1">$$LetterOfCreditOverview[C].IbReason[C].IbReason[C].IbReason$</td>
  </tr>  
$%endif$
</table>
</font>
</div>
$%endif$

<div style="width:100%;clear:both;">
<br/>
$%if InputParameters[1].InwardCollectionsList[C].EventStatus == "Approved"$
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

</pdf>