Your Collection

Account Number:  $$InputParameters[1].AccountNo$

Id,Direction,Account No,Currency,Amount,Value Date,Resubmission DD Id,Status
$%for 1 to RejectedCollectionsList[C].lastInstance() $$$RejectedCollectionsList[C].Id$,$$RejectedCollectionsList[C].Direction$,$$RejectedCollectionsList[C].AccountNo$,$$RejectedCollectionsList[C].Currency$,$$RejectedCollectionsList[C].Amount$,$$RejectedCollectionsList[C].ValueDate$,$$RejectedCollectionsList[C].ResubDdId[1].ResubDdId$,$$RejectedCollectionsList[C].Status$
$%endfor$