//%attributes = {"invisible":true,"preemptive":"capable"}
If (This:C1470._isStarted)
	
	Use (This:C1470)
		ON ERR CALL:C155(This:C1470._methodCalledOnError)
		This:C1470._methodCalledOnError:=""
		This:C1470._isStarted:=False:C215
	End use 
	
End if 