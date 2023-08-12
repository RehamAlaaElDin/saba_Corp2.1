Outward Collections
Customer Name: $$InputParameters[1].UserId$
Collection Reference, Transaction Reference, Type, Drawee, Document Status, Lodge Date, Currency, Amount, Status
$%for 1 to OutwardCollectionsListUI[C].lastInstance()$$$OutwardCollectionsListUI[C].CollnRef$,$$OutwardCollectionsListUI[C].TransRef$,$$OutwardCollectionsListUI[C].TypeOfColl$,"$$OutwardCollectionsListUI[C].Drawee$",$$OutwardCollectionsListUI[C].DocStatus$,$$OutwardCollectionsListUI[C].LodgeDate$,$$OutwardCollectionsListUI[C].Currency$,"$$OutwardCollectionsListUI[C].Amount$",$$OutwardCollectionsListUI[C].StatusForDisplay$
$%endfor$
