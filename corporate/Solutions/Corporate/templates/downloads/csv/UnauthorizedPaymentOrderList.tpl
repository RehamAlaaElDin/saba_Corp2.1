Unauthorized $$!MAINSESSION.TRANSFER_TYPE$
$%if WorkingElements[1].TransferType = 'transfers'$
Debit account,Credit account,Description,Date,Amount
$%for 1 to UnauthorizedPaymentOrderList[C].lastInstance() $$$UnauthorizedPaymentOrderList[C].DebitAccount$,$$UnauthorizedPaymentOrderList[C].CreditAccount$,$$UnauthorizedPaymentOrderList[C].Narrative$,$$UnauthorizedPaymentOrderList[C].PaymentExecutionDate$,$$UnauthorizedPaymentOrderList[C].PaymentAmount$
$%endfor$
$%endif$
$%if WorkingElements[1].TransferType = 'payments'$
Debit account,Payee name,Description,Date,Amount
$%for 1 to UnauthorizedPaymentOrderList[C].lastInstance() $$$UnauthorizedPaymentOrderList[C].DebitAccount$,$$UnauthorizedPaymentOrderList[C].BeneficiaryName$,$$UnauthorizedPaymentOrderList[C].Narrative$,$$UnauthorizedPaymentOrderList[C].PaymentExecutionDate$,$$UnauthorizedPaymentOrderList[C].PaymentAmount$
$%endfor$
$%endif$