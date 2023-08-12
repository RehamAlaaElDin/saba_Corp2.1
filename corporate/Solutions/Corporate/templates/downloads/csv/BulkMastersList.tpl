Bulk Master List

Description,Account name,Payment Date,Number of items,Total Value Uploaded,Status
$%for 1 to BulkPaymentsList[C].lastInstance() $ "$$BulkPaymentsList[C].DisplayDescription$","$$BulkPaymentsList[C].ActiveAccount$","$$BulkPaymentsList[C].PaymentValueDate$","$$BulkPaymentsList[C].TotalItems$","$$BulkPaymentsList[C].TotalValueUploaded$","$$BulkPaymentsList[C].Status$"
$%endfor$