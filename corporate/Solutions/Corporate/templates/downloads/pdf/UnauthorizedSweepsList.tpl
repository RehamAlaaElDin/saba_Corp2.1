<pdf baseFont="Helvetica,Cp1252,false">

<page>
<footer page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img></right>
<center>

<br />
<br />
<font size="15">Pending Sweeps</font>
<br />
<br />

<font size="8">

<table width="100%" border="1" bordercolor="ffffff" cellspacing="2" cellpadding="2">
  <tr>
    <td bgcolor="DBE5F1">Id</td>
	<td bgcolor="DBE5F1">Primary Account</td>
	<td bgcolor="DBE5F1">Secondary Account</td>
	<td bgcolor="DBE5F1">Frequency</td>
	<td bgcolor="DBE5F1">Next Sweep Date</td>
  </tr>
$%for 1 to SweepsUnauthorisedList[C].lastInstance() $
  <tr>
    <td bgcolor="DBE5F1">$$SweepsUnauthorisedList[C].Id$</td>
    <td bgcolor="DBE5F1">$$SweepsUnauthorisedList[C].AccountFrom[1].AccountFrom$</td>
	<td bgcolor="DBE5F1">$$SweepsUnauthorisedList[C].AccountTo[1].AccountTo$</td>
	<td bgcolor="DBE5F1">$$SweepsUnauthorisedList[C].Frequency$</td>
	<td bgcolor="DBE5F1">$$SweepsUnauthorisedList[C].NextRunDate$</td>
  </tr>
$%endfor$
</table>

$%endif$
</pdf>