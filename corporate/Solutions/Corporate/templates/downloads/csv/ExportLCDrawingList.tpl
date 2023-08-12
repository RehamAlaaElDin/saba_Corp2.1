Export LC Drawing

LC Reference,Type,Drawing Reference,Applicant,Document Status,Date,Currency,Amount,Status
$%for 1 to ListingForDisplay[1].ExportDrawingsList[C].lastInstance() $$$ListingForDisplay[1].ExportDrawingsList[C].IssBankRef$,$$ListingForDisplay[1].ExportDrawingsList[C].LcType$,$$ListingForDisplay[1].ExportDrawingsList[C].TransRef$,$$ListingForDisplay[1].ExportDrawingsList[C].DrApplicant$,$$ListingForDisplay[1].ExportDrawingsList[C].DrDoc$,$$ListingForDisplay[1].ExportDrawingsList[C].DrDate$,$$ListingForDisplay[1].ExportDrawingsList[C].Currency$,$$ListingForDisplay[1].ExportDrawingsList[C].AmountForCSVDownload$,$$ListingForDisplay[1].ExportDrawingsList[C].StatusForDisplay$
$%endfor$