<pdf baseFont="Helvetica,Cp1252,false">
<page>
<footer align="center" page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img>
<center>
<br />
<br />
<font size="15">Sweep Details </font>
<br />
<br />
<font size="8">
<table width="100%" border="0" bordercolor="ffffff" cellspacing="2" cellpadding="2">
<tr><td bgcolor="95B3D7">Customer name </td><td bgcolor="95B3D7"> $$InputParameters[1].CustomerName$ </td></tr>
</table>

<table width="100%" border="0" cellspacing="2" cellpadding="2"> 

<tr><td bgcolor="DBE5F1">Primary Account</td><td bgcolor="DBE5F1">$$ScreenElements[1].Sweep[1].AccountFrom[C].AccountFrom$</td></tr>

<tr><td bgcolor="DBE5F1">Primary Account Balance Type</td><td bgcolor="DBE5F1">$$ScreenElements[1].Sweep[1].AccountFrom[C].FromAcctBalType$</td></tr>

<tr><td bgcolor="DBE5F1">Secondary Account</td><td bgcolor="DBE5F1">$$ScreenElements[1].Sweep[1].AccountTo[C].AccountTo$</td></tr>

<tr><td bgcolor="DBE5F1">Secondary Account Balance Type</td><td bgcolor="DBE5F1">$$ScreenElements[1].Sweep[1].AccountTo[C].ToAcctBalType$</td></tr>

$%if ScreenElements[1].Sweep[1].AccountTo[C].MinimumAmt != ''$
<tr><td bgcolor="DBE5F1">Minimum Balance</td><td bgcolor="DBE5F1">$$ScreenElements[1].Sweep[1].AccountTo[C].MinimumAmt$</td></tr>
$%endif$

$%if ScreenElements[1].Sweep[1].AccountTo[C].MinimumAmt == ''$
<tr><td bgcolor="DBE5F1">Minimum Balance</td><td bgcolor="DBE5F1">0.00</td></tr>
$%endif$

$%if ScreenElements[1].Sweep[1].AccountTo[C].MaximumAmt != ''$
<tr><td bgcolor="DBE5F1">Maximum Balance</td><td bgcolor="DBE5F1">$$ScreenElements[1].Sweep[1].AccountTo[C].MaximumAmt$</td></tr>
$%endif$

$%if ScreenElements[1].Sweep[1].AccountTo[C].MaximumAmt == ''$
<tr><td bgcolor="DBE5F1">Maximum Balance</td><td bgcolor="DBE5F1">0.00</td></tr>
$%endif$

$%if ScreenElements[1].Frequency[1].FrequencyType != ''$ 
<tr><td bgcolor="DBE5F1">Frequency</td><td bgcolor="DBE5F1">$$ScreenElements[1].Frequency[1].FrequencyType$</td></tr>
$%endif$

$%if ScreenElements[1].Frequency[1].FrequencyDisplayFlag == 'M'$
<tr><td bgcolor="DBE5F1">Month</td><td bgcolor="DBE5F1">$$ScreenElements[1].Frequency[1].Month$</td></tr>
$%endif$

$%if ScreenElements[1].Frequency[1].FrequencyDisplayFlag == 'M'$
<tr><td bgcolor="DBE5F1">Days</td><td bgcolor="DBE5F1">$$ScreenElements[1].Frequency[1].Days$</td></tr>
$%endif$

$%if ScreenElements[1].Frequency[1].FrequencyDisplayFlag == 'WEEK'$
<tr><td bgcolor="DBE5F1">Weeks</td><td bgcolor="DBE5F1">$$ScreenElements[1].Frequency[1].Weeks$</td></tr>
$%endif$

</table>
</pdf>

