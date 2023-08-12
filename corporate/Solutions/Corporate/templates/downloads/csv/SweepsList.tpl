Your Sweep

Account Number:  $$InputParameters[1].AccountFrom$

Id,Primary Account,Secondary Account,Sweep Type,Frequency
$%for 1 to SweepsList[C].lastInstance() $$$SweepsList[C].Id$,$$SweepsList[C].AccountFrom[1].AccountFrom$,$$SweepsList[C].AccountTo[1].AccountTo$,$$SweepsList[C].SweepType$,$$SweepsList[C].Frequency$
$%endfor$