//%attributes = {"invisible":true,"preemptive":"capable"}
If (Not:C34(This:C1470._isStarted))
	
	Use (This:C1470)
		This:C1470._methodCalledOnError:=Method called on error:C704
		ON ERR CALL:C155("m_handler")
		This:C1470._isStarted:=True:C214
	End use 
	
End if 