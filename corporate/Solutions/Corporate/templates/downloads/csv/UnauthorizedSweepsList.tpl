Pending Sweep list

Id,Primary Account,Secondary Account,Frequency,Next Sweep Date
$%for 1 to SweepsUnauthorisedList[C].lastInstance() $$$SweepsUnauthorisedList[C].Id$,$$SweepsUnauthorisedList[C].AccountFrom[1].AccountFrom$,$$SweepsUnauthorisedList[C].AccountTo[1].AccountTo$,$$SweepsUnauthorisedList[C].Frequency$,$$SweepsUnauthorisedList[C].NextRunDate$
$%endfor$