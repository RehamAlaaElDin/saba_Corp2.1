<pdf baseFont="Helvetica,Cp1252,false" charset=UTF-8>
<page>
<footer align="center" page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img>
<center>
<br />
<br />
<font size="15">Inward Collection Amendment</font>
<br />
<br />
<font size="8">
<table width="100%" border="0" bordercolor="ffffff" cellspacing="2" cellpadding="4">
<tr>
<td bgcolor="95B3D7">User Name</td><td bgcolor="95B3D7">$$Login[1].UserName$</td>
</tr>
<tr>
<td bgcolor="95B3D7">Transaction Reference</td><td bgcolor="95B3D7">$$CollectionDetails[1].LCReference$</td>
</tr>
</table>

$%if Download[1].CollectionDetails[1].InwardCollectionDetails[1].OldAmount != '' OR Download[1].CollectionDetails[1].InwardCollectionDetails[1].OldMaturityDate != ''$
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
<tr><td rowspan="2"><font size="10"><b>Inward Collection Amendment Details</b></font></td></tr>
</table>
<font size="8">
<!---Inward Collection Amendment Details--->
<div style="width:100%;clear:both;">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
  $%if Download[1].CollectionDetails[1].InwardCollectionDetails[1].OldAmount != ''$
  <tr>
     <td bgcolor="DBE5F1"><b>Old amount</b></td>
	 <td bgcolor="DBE5F1">$$Download[1].CollectionDetails[1].InwardCollectionDetails[1].Currency$ $$Download[1].CollectionDetails[1].InwardCollectionDetails[1].OldAmount$</td>
  </tr>
  $%endif$
  $%if Download[1].CollectionDetails[1].InwardCollectionDetails[1].Amount != '' AND Download[1].CollectionDetails[1].InwardCollectionDetails[1].OldAmount != ''$
  <tr>  
     <td bgcolor="DBE5F1"><b>New amount</b></td>
	 <td bgcolor="DBE5F1">$$Download[1].CollectionDetails[1].InwardCollectionDetails[1].Currency$ $$Download[1].CollectionDetails[1].InwardCollectionDetails[1].Amount$</td>
  </tr>
  $%endif$
   $%if Download[1].CollectionDetails[1].InwardCollectionDetails[1].OldMaturityDate != ''$
  <tr>
      	<td bgcolor="DBE5F1"><b>Old maturity date</b></td>
		<td bgcolor="DBE5F1">$$Download[1].CollectionDetails[1].InwardCollectionDetails[1].OldMaturityDate$</td>
  </tr>
   $%endif$
   $%if Download[1].CollectionDetails[1].InwardCollectionDetails[1].MaturityDate != '' AND Download[1].CollectionDetails[1].InwardCollectionDetails[1].OldMaturityDate != ''$
  <tr>
	 <td bgcolor="DBE5F1"><b>New maturity date</b></td>
	 <td bgcolor="DBE5F1">$$Download[1].CollectionDetails[1].InwardCollectionDetails[1].MaturityDate$</td>
 </tr>
 $%endif$
      $%if Download[1].CollectionDetails[1].InwardCollectionDetails[1].Amendments != ''$
  <tr>
      	<td bgcolor="DBE5F1"><b>Amendments</b></td>
		<td bgcolor="DBE5F1">$$Download[1].CollectionDetails[1].InwardCollectionDetails[1].Amendments$</td>
  </tr>
   $%endif$
</table>
</div>
</font>
$%endif$

<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
<tr><td rowspan="2"><font size="10"><b>Inward Collection Details</b></font></td></tr>
</table>
<font size="8">
<!---Inward Collection Details--->
<div style="width:100%;clear:both;">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
  $%if Download[1].CollectionDetails[1].InwardCollectionDetails[1].DrawerReference != ''$
  <tr>
     <td bgcolor="DBE5F1"><b>Remitting bank reference</b></td>
	 <td bgcolor="DBE5F1">$$Download[1].CollectionDetails[1].InwardCollectionDetails[1].DrawerReference$</td>
  </tr>
  $%endif$
  $%if Download[1].CollectionDetails[1].InwardCollectionDetails[1].GuaranteeReference != ''$
  <tr>  
     <td bgcolor="DBE5F1"><b>Shipping guarantee reference</b></td>
	 <td bgcolor="DBE5F1">$$Download[1].CollectionDetails[1].InwardCollectionDetails[1].GuaranteeReference$</td>
  </tr>
  $%endif$
   $%if Download[1].CollectionDetails[1].InwardCollectionDetails[1].Amount != ''$
  <tr>
      	<td bgcolor="DBE5F1"><b>Document amount</b></td>
		<td bgcolor="DBE5F1">$$Download[1].CollectionDetails[1].InwardCollectionDetails[1].Currency$ $$Download[1].CollectionDetails[1].InwardCollectionDetails[1].Amount$</td>
  </tr>
   $%endif$
   $%if Download[1].CollectionDetails[1].InwardCollectionDetails[1].RemittingBankDetails != ''$
  <tr>
	 <td bgcolor="DBE5F1"><b>Remitting bank name and address</b></td>
	 <td bgcolor="DBE5F1">$$Download[1].CollectionDetails[1].InwardCollectionDetails[1].RemittingBankDetails$</td>
 </tr>
 $%endif$
      $%if Download[1].CollectionDetails[1].InwardCollectionDetails[1].AvailableBy != ''$
  <tr>
      	<td bgcolor="DBE5F1"><b>Document against</b></td>
		<td bgcolor="DBE5F1">$$Download[1].CollectionDetails[1].InwardCollectionDetails[1].AvailableBy$</td>
  </tr>
   $%endif$
   $%if Download[1].CollectionDetails[1].InwardCollectionDetails[1].BeneficiaryDetails != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Drawer name and address</b></td>
		<td bgcolor="DBE5F1">$$Download[1].CollectionDetails[1].InwardCollectionDetails[1].BeneficiaryDetails$</td>
	</tr>
   $%endif$
    $%if Download[1].CollectionDetails[1].InwardCollectionDetails[1].Tenor != ''$ 
  <tr>
	   <td bgcolor="DBE5F1"><b>Tenor</b></td>
	   $%if Download[1].CollectionDetails[1].InwardCollectionDetails[1].Days != ''$ 
	   <td bgcolor="DBE5F1">$$Download[1].CollectionDetails[1].InwardCollectionDetails[1].Days$ $$Download[1].CollectionDetails[1].InwardCollectionDetails[1].Tenor$</td>
	   $%endif$
	   $%if Download[1].CollectionDetails[1].InwardCollectionDetails[1].Days == ''$ 
	   <td bgcolor="DBE5F1">$$Download[1].CollectionDetails[1].InwardCollectionDetails[1].Tenor$</td>
	   $%endif$	   
  </tr>
  $%endif$
   $%if Download[1].CollectionDetails[1].InwardCollectionDetails[1].MaturityDate != ''$
  <tr>  
     <td bgcolor="DBE5F1"><b>Maturity date</b></td>
	 <td bgcolor="DBE5F1">$$Download[1].CollectionDetails[1].InwardCollectionDetails[1].MaturityDate$</td>
  </tr>
  $%endif$
    $%if Download[1].CollectionDetails[1].InwardCollectionDetails[1].AcceptedMaturityDate != ''$ 
	<tr>
	    <td bgcolor="DBE5F1"><b>Accepted maturity date</b></td>
		<td bgcolor="DBE5F1">$$Download[1].CollectionDetails[1].InwardCollectionDetails[1].AcceptedMaturityDate$</td>
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

$%if Download[1].CollectionDetails[1].DocumentDetails[C].lastInstance() != -1 AND Download[1].CollectionDetails[1].DocumentDetails[1].DocumentCode != ''$
<font size="8">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
  <tr>
    <td bgcolor="DBE5F1"><b>Document code</b></td>
	<td bgcolor="DBE5F1"><b>Document description</b></td>
	<td bgcolor="DBE5F1"><b>Count of documents</b></td>
  </tr>
$%for 1 to Download[1].CollectionDetails[1].DocumentDetails[C].lastInstance() $
  <tr>
    <td bgcolor="DBE5F1">$$Download[1].CollectionDetails[1].DocumentDetails[C].DocumentCode$</td>
	<td bgcolor="DBE5F1">$$Download[1].CollectionDetails[1].DocumentDetails[C].DocumentDescription$</td>
    <td bgcolor="DBE5F1">$$Download[1].CollectionDetails[1].DocumentDetails[C].Doc1stCopies$</td>
  </tr>
$%endfor$
</table>
</font>
$%endif$

$%if Download[1].CollectionDetails[1].DocumentDetails[1].DocumentCode == ''$
<font size="8">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
  <tr style="border:1px solid #FFFFFF;"><td bgcolor="DBE5F1">No document details available.</td></tr>
</table>
</font>
$%endif$
</div>

<div style="width:100%;clear:both;">
<br />
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
	$%if Download[1].CollectionDetails[1].InwardCollectionDetails[1].Instructions != ''$  
	    <tr>
	<td bgcolor="DBE5F1"><b>Instructions</b></td>
	<td bgcolor="DBE5F1">$$Download[1].CollectionDetails[1].InwardCollectionDetails[1].Instructions$</td>
	  </tr>
$%endif$
</table>
</div>

$%if Download[1].CollectionDetails[1].InwardCollectionDetails[1].ApplicantAccount != ''$

<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
<tr><td rowspan="2"><font size="10"><b>Account Details</b></font></td></tr>
</table>
<font size="8">
<!---Account Details--->
<div style="width:100%;clear:both;">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
   <tr>
     <td bgcolor="DBE5F1"><b>Account to be debited</b></td>
	 <td bgcolor="DBE5F1">$$Download[1].CollectionDetails[1].InwardCollectionDetails[1].ApplicantAccount$</td>
  </tr>
</table>
</div>
</font>
$%endif$

$%if Download[1].CollectionDetails[1].InwardCollectionDetails[1].BnkToCust != '' OR Download[1].CollectionDetails[1].InwardCollectionDetails[1].CustToBnk != ''$

<font size="8">
<div style="width:100%;clear:both;">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
	 
	$%if Download[1].CollectionDetails[1].InwardCollectionDetails[1].BnkToCust != ''$
		<tr>
			<td bgcolor="DBE5F1"><b>Message from Bank</b></td>
			<td bgcolor="DBE5F1">$$Download[1].CollectionDetails[1].InwardCollectionDetails[1].BnkToCust$</td>
		</tr>
	$%endif$
	$%if Download[1].CollectionDetails[1].InwardCollectionDetails[1].CustToBnk != ''$
		<tr>  
			<td bgcolor="DBE5F1"><b>Message/Response to bank</b></td>
			<td bgcolor="DBE5F1">$$Download[1].CollectionDetails[1].InwardCollectionDetails[1].CustToBnk$</td>
		</tr>
	$%endif$
</table>
</div>
</font>
$%endif$

<div style="width:100%;clear:both;">
<br/>
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
<tr><td rowspan="2"><font size="10"><b>Swift Messages and Advices</b></font></td></tr>
</table>
$%if Download[1].DeliveryMessageAdvice[C].lastInstance() != -1$
<font size="8">
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
  <tr>
    <td bgcolor="DBE5F1"><b>Message type</b></td>
	<td bgcolor="DBE5F1"><b>Delivered To/From</b></td>
	<td bgcolor="DBE5F1"><b>Date</b></td>
	<td bgcolor="DBE5F1"><b>Inward/Outward</b></td>
  </tr>
    $%if Download[1].DeliveryMessageAdvice[1].MessageType == ''$
  <tr style="border:1px solid #FFFFFF;"><td colspan='4' bgcolor="DBE5F1">No records available.</td></tr>
  $%endif$
$%for 1 to Download[1].DeliveryMessageAdvice[C].lastInstance() $
  <tr>
    <td bgcolor="DBE5F1">$$Download[1].DeliveryMessageAdvice[C].MessageType$</td>
    <td bgcolor="DBE5F1">$$Download[1].DeliveryMessageAdvice[C].ShortName$</td>
	<td bgcolor="DBE5F1">$$Download[1].DeliveryMessageAdvice[C].BankDate$</td>
	<td bgcolor="DBE5F1">$$Download[1].DeliveryMessageAdvice[C].MessageCategory$</td>
  </tr>
$%endfor$
</table>
</font>
$%endif$
</div>

</pdf>