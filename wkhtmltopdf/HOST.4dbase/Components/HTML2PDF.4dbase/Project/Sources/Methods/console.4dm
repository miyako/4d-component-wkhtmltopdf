//%attributes = {"invisible":true,"preemptive":"capable"}
C_TEXT:C284($1)
C_OBJECT:C1216($0; $EXPORT)

$name:=Current method name:C684

If (Storage:C1525[$name]=Null:C1517)
	Use (Storage:C1525)
		$EXPORT:=New shared object:C1526
		Storage:C1525[$name]:=$EXPORT
	End use 
Else 
	$EXPORT:=Storage:C1525[$name]
End if 

$FORMULA_NAME:="log"

If ($EXPORT[$FORMULA_NAME]=Null:C1517)
	
	Use ($EXPORT)
		
		$EXPORT._methodCalledOnError:=""
		$EXPORT._isStarted:=False:C215
		$EXPORT.logFile:=Folder:C1567(fk logs folder:K87:17; *).file("wkhtmltopdf.log")
		
		$EXPORT.start:=Formula:C1597(m_start)
		$EXPORT.stop:=Formula:C1597(m_stop)
		
		$EXPORT.getLastError:=Formula:C1597(m_getLastError)
		
		$EXPORT[$FORMULA_NAME]:=Formula:C1597(m_log)
		
	End use 
	
End if 

$0:=$EXPORT