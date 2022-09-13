//%attributes = {"invisible":true,"preemptive":"capable"}
C_TEXT:C284($1; $0; $path)

If (Count parameters:C259#0)
	
	$path:=$1
	
	C_LONGINT:C283($platform)
	
	_O_PLATFORM PROPERTIES:C365($platform)
	
	Case of 
		: ($platform=Windows:K25:3)
			
			$path:=LEP_Escape($path)
			
		: ($platform=Mac OS:K25:2)
			
			$path:=LEP_Escape(Convert path system to POSIX:C1106($path))
			
	End case 
	
End if 

$0:=$path