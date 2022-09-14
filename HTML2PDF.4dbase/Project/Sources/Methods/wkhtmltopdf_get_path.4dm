//%attributes = {"invisible":true,"preemptive":"capable"}
C_TEXT:C284($0; $path)

$path:=Get 4D folder:C485(Current resources folder:K5:16)+\
"wkhtmltopdf"+Folder separator:K24:12

C_LONGINT:C283($platform)
_O_PLATFORM PROPERTIES:C365($platform)

Case of 
	: ($platform=Mac OS:K25:2)
		
		//the executable flag is lost during c/s transfer
		If (Application type:C494=4D Remote mode:K5:5)
			SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_CURRENT_DIRECTORY"; $path+"macOS")
			SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_BLOCKING_EXTERNAL_PROCESS"; "true")
			LAUNCH EXTERNAL PROCESS:C811("chmod 555 wkhtmltopdf")
		End if 
		
		$path:=$path+"macOS"+Folder separator:K24:12+"wkhtmltopdf"
		
	: ($platform=Windows:K25:3)
		
		$path:=$path+"Windows64"+Folder separator:K24:12+"wkhtmltopdf.exe"
		
		SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
		
End case 

$0:=LEP_Escape_path($path)