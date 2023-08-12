Outward Collection Amendments
Customer Name: $$InputParameters[1].UserId$
Collection Reference, Transaction Reference, Type, Drawee, Lodge Date, Currency, Amount
$%for 1 to OutwardCollectionsAmendmentListUI[C].lastInstance()$$$OutwardCollectionsAmendmentListUI[C].CollnRef$,$$OutwardCollectionsAmendmentListUI[C].TransRef$,$$OutwardCollectionsAmendmentListUI[C].TypeOfColl$,$$OutwardCollectionsAmendmentListUI[C].Drawee$,$$OutwardCollectionsAmendmentListUI[C].LodgeDate$,$$OutwardCollectionsAmendmentListUI[C].Currency$,"$$OutwardCollectionsAmendmentListUI[C].Amount$"
$%endfor$
