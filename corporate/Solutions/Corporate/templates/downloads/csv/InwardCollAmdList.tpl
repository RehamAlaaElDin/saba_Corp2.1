Inward Collection Amendments
Customer Name: $$InputParameters[1].UserId$
Collection Reference, Transaction Reference, Type, Drawer,Lodge Date, Currency, Amount
$%for 1 to InwardCollectionAmendmentListUI[C].lastInstance()$$$InwardCollectionAmendmentListUI[C].CollnRef$,$$InwardCollectionAmendmentListUI[C].TransRef$,$$InwardCollectionAmendmentListUI[C].TypeOfColl$,$$InwardCollectionAmendmentListUI[C].Drawer$,$$InwardCollectionAmendmentListUI[C].LodgeDate$,$$InwardCollectionAmendmentListUI[C].Currency$,"$$InwardCollectionAmendmentListUI[C].Amount$"
$%endfor$
