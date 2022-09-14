//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($1)

$OK:=OK
$ERROR:=ERROR

$logFile:=This:C1470.logFile

If (Not:C34($logFile.exists))
	$logFile.setText()  //create it
End if 

C_TIME:C306($ref)
$ref:=Append document:C265($logFile.platformPath)

USE CHARACTER SET:C205("utf-8")  //scope=current process

If (Get document size:C479($ref)=0)  //make the content a json array, for easier parsing
	SEND PACKET:C103($ref; "[\n")
Else 
	SET DOCUMENT POSITION:C482($ref; -1; 2)
	SEND PACKET:C103($ref; ",\n")
End if 
SEND PACKET:C103($ref; JSON Stringify:C1217($1; *))
SEND PACKET:C103($ref; "\n]")

USE CHARACTER SET:C205(*)

CLOSE DOCUMENT:C267($ref)

OK:=$OK
ERROR:=$ERROR