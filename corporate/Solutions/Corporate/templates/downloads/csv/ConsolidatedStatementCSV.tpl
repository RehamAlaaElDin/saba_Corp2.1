Consolidated Account Statements

$%for 1 to ConsolidatedAccountStmts.lastInstance() $
Account Number: $$ConsolidatedAccountStmts[C].SelectedAcctNo$
Date,Description,Amount,Balance ($$ConsolidatedAccountStmts[C].SelectedCurrency$) $$ConsolidatedAccountStmts[C].MiniStmtDetails$ 
$%for 1 to ConsolidatedAccountStmts[C].MiniStmtDetails.lastInstance() $$$ConsolidatedAccountStmts[C].MiniStmtDetails[C].BookingDate$,$$ConsolidatedAccountStmts[C].MiniStmtDetails[C].Narrative$,$$ConsolidatedAccountStmts[C].MiniStmtDetails[C].StmtAmount$,$$ConsolidatedAccountStmts[C].MiniStmtDetails[C].StmtBalance$,$$ConsolidatedAccountStmts[C].MiniStmtDetails[C]$
$%endfor$
$%endfor$
