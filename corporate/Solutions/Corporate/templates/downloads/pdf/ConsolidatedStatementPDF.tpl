<pdf baseFont="Helvetica,Cp1252,false">

<page>
<footer page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img></right>
<center>

<br />
<br />
<font size="15">Consolidated Account Statements</font>
<br />
<br />

<font size="8">		

$%if ConsolidatedAccountStmts.lastInstance() != -1$
$%for 1 to ConsolidatedAccountStmts.lastInstance() $
<table width="100%" border="0" bordercolor="ffffff" cellspacing="2" cellpadding="4">
<tr><td bgcolor="95B3D7">Account Number: $$ConsolidatedAccountStmts[C].SelectedAcctNo$</td></tr>
</table>
<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="5" cellsfitpage="true">
<tr>
    <td bgcolor="DBE5F1"><b>Date</b></td>
	<td bgcolor="DBE5F1"><b>Description</b></td>
    <td bgcolor="DBE5F1"><b>Amount &nbsp;($$ConsolidatedAccountStmts[C].SelectedCurrency$)</b></td>
	<td bgcolor="DBE5F1"><b>Balance &nbsp;($$ConsolidatedAccountStmts[C].SelectedCurrency$)</b></td>
  </tr>
$%if ConsolidatedAccountStmts[C].MiniStmtDetails.lastInstance() != -1$
$%for 1 to ConsolidatedAccountStmts[C].MiniStmtDetails.lastInstance() $
  <tr>
    <td bgcolor="DBE5F1">$$ConsolidatedAccountStmts[C].MiniStmtDetails[C].BookingDate$</td>
    <td bgcolor="DBE5F1">$$ConsolidatedAccountStmts[C].MiniStmtDetails[C].Narrative$</td>
	<td bgcolor="DBE5F1">$$ConsolidatedAccountStmts[C].MiniStmtDetails[C].StmtAmount$</td>
 	<td bgcolor="DBE5F1">$$ConsolidatedAccountStmts[C].MiniStmtDetails[C].StmtBalance$</td>
  </tr>
$%endfor$
$%endif$
</table>
$%endfor$
$%endif$
<br />
</pdf>
























