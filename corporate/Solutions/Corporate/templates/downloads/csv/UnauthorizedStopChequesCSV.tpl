Your Cheques

Customer Number:  $$InputParameters[1].CustomerNo$

Account Number,Payment Stop Reason,First Cheque No,Last Cheque No
$%for 1 to PendingStopCheques[C].lastInstance() $$$PendingStopCheques[C].Id$,$$PendingStopCheques[C].PaymStopType.value()$,$$PendingStopCheques[C].FirstChequeNo$,$$PendingStopCheques[C].LastChequeNo$
$%endfor$