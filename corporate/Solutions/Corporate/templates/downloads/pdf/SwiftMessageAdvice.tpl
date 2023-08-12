<pdf baseFont="Helvetica,Cp1252,false">

<page>
<footer align="center" page="y"></footer>
<right><img src="$$PROJECTHOME$/images/TCIBIcons/img_logo.jpg" width="100" height="35"></img></right>
<center>

$%IF DeliveryPreviewMessage[C].lastInstance() > '0'$
<font size="15">Advice Details</font>
$%ENDIF$

$%IF DeliveryInwardSwift[C].lastInstance() > '0'$
<font size="15">Swift Details</font>
$%ENDIF$

$%IF DeliveryOutwardSwift[C].lastInstance() > '0'$
<font size="15">Swift Details</font>
$%ENDIF$
<br>
<font size="8">
<!------Outward Advice Details------>
$%IF DeliveryPreviewMessage[C].lastInstance() > '0'$
<div style="width:100%;clear:both;">
<br>
$%if DeliveryPreviewMessage[C].lastInstance() > '0'$
<table width="100%" border="0" bordercolor="ffffff" cellspacing="2" cellpadding="4">
  $%for 1 to DeliveryPreviewMessage[C].lastInstance() $
  <tr style="border:1px solid #FFFFFF;">
  <td bgcolor="DBE5F1">$$DeliveryPreviewMessage[C].MessageDetails$</td>
  </tr>
  $%endfor$
</table>
$%endif$
</div>
$%ENDIF$

<!------Inward Swift Details------>
$%IF DeliveryInwardSwift[C].lastInstance() > '0'$
<div style="width:100%;clear:both;">
<br>
<table width="100%" border="0" bordercolor="ffffff" cellspacing="2" cellpadding="4">
  <tr style="border:1px solid #FFFFFF;">
  <td bgcolor="DBE5F1">$$DeliveryInwardSwift[C].MessageDetails$</td>
  </tr>
</table>
</div>
$%ENDIF$

<!------Outward Swift Details------>
$%IF DeliveryOutwardSwift[C].lastInstance() > '0'$
<div style="width:100%;clear:both;">
<br>
<table width="100%" border="0" bordercolor="ffffff" cellspacing="2" cellpadding="4">
  <tr style="border:1px solid #FFFFFF;">
  <td bgcolor="DBE5F1">$$DeliveryOutwardSwift[C].MessageDetails$</td>
  </tr>
</table>
</div>
$%ENDIF$
</pdf>