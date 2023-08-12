Import LC Drawing

LC Reference,LC Type,Drawing Reference,Beneficiary,Document Status,Date,Currency,Amount,Status
$%for 1 to ListingForDisplay[1].ImportDrawingsList[C].lastInstance() $$$ListingForDisplay[1].ImportDrawingsList[C].LcId$,$$ListingForDisplay[1].ImportDrawingsList[C].LcType$,$$ListingForDisplay[1].ImportDrawingsList[C].TransRef$,$$ListingForDisplay[1].ImportDrawingsList[C].Beneficiary$,$$ListingForDisplay[1].ImportDrawingsList[C].DocStatus$,$$ListingForDisplay[1].ImportDrawingsList[C].DrawingDateForDisplay$,$$ListingForDisplay[1].ImportDrawingsList[C].Currency$,$$ListingForDisplay[1].ImportDrawingsList[C].Amount$,$$ListingForDisplay[1].ImportDrawingsList[C].StatusForDisplay$
$%endfor$