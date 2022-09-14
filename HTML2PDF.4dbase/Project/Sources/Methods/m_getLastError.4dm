//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($0; $lastError)

//basic stuff

$errorStack:=New collection:C1472

$lastError:=New object:C1471("error"; ERROR; "errorLine"; ERROR LINE; "errorMethod"; ERROR METHOD; "errorFormula"; ERROR FORMULA; "stack"; $errorStack; "callChain"; Get call chain:C1662)

ARRAY LONGINT:C221($codes; 0)
ARRAY TEXT:C222($components; 0)
ARRAY TEXT:C222($messages; 0)

GET LAST ERROR STACK:C1015($codes; $components; $messages)

For ($i; 1; Size of array:C274($codes))
	$errorStack.push(New object:C1471("code"; $codes{$i}; "component"; $components{$i}; "message"; $messages{$i}))
End for 

//add any other properties of interest

$lastError.timestamp:=Timestamp:C1445

$lastError.process:=Get process activity:C1495(Processes only:K5:35).processes.query("number === :1"; Current process:C322)[0]

$lastError.user:=New object:C1471("account"; Current user:C182(4D user account:K5:54); "alias"; Current user:C182(4D user alias:K5:55))

$0:=$lastError