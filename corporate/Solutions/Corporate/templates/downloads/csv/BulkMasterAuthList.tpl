Pending Approval Bulk Master List

Description,Account,Payment date,Number of items,Total value uploaded,Status
$%for 1 to BulkPaymentList[C].lastInstance() $$$BulkPaymentList[C].DisplayDescription$,$$BulkPaymentList[C].AccountNumber$,$$BulkPaymentList[C].PaymentValueDate$,$$BulkPaymentList[C].TotalItems$,"$$BulkPaymentList[C].TotalValueUploaded$",$$BulkPaymentList[C].Status$
$%endfor$