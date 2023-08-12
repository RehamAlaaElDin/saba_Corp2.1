<pdf baseFont="Helvetica,Cp1252,false">

<page>
<footer align="center" page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img></right>
<center>

<br />
<br />
<font size="15">Your Sweep</font>
<br />
<br />

<font size="8">
<table width="100%" border="0" bordercolor="ffffff" cellspacing="2" cellpadding="2">
<tr><td bgcolor="95B3D7">Account Number:  $$InputParameters[1].AccountFrom$</td></tr>
</table>

<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="2">
  <tr>
    <td bgcolor="DBE5F1">Id</td>
	<td bgcolor="DBE5F1">Primary Account</td>
	<td bgcolor="DBE5F1">Secondary Account</td>
	<td bgcolor="DBE5F1">Sweep Type</td>
	<td bgcolor="DBE5F1">Frequency</td>
  </tr>
$%for 1 to SweepsList[C].lastInstance() $
  <tr>
    <td bgcolor="DBE5F1">$$SweepsList[C].Id$</td>
    <td bgcolor="DBE5F1">$$SweepsList[C].AccountFrom[1].AccountFrom$</td>
	<td bgcolor="DBE5F1">$$SweepsList[C].AccountTo[1].AccountTo$</td>
	<td bgcolor="DBE5F1">$$SweepsList[C].SweepType$</td>
	<td bgcolor="DBE5F1">$$SweepsList[C].Frequency$</td>
  </tr>
$%endfor$
</table>

$%endif$
</pdf>