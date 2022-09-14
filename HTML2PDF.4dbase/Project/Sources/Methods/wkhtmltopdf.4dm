//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
C_OBJECT:C1216($1)
C_TEXT:C284($2; $3)
C_BLOB:C604($0)

$console:=console

$options:=New object:C1471
$html:=""
$encoding:="utf-8"
$fallback_encoding:="iso-8859-15"

$console.start()

If (Count parameters:C259#0)
	If ($1#Null:C1517)
		$options:=$1
	End if 
End if 

If (Count parameters:C259>1)
	$html:=$2
End if 

If (Count parameters:C259>2)
	If ($3#"")
		$encoding:=$3
	End if 
End if 

C_BLOB:C604($stdIn; $stdOut; $stdErr)

If ($html#"")  //execute wkhtmltopdf only if input contains string
	
	If (Is macOS:C1572)
		$cli_encoding:="utf-8"
	Else 
		$cli_encoding:="utf-16le"
	End if 
	
	$options.value:=""
	
	$path:=wkhtmltopdf_get_path
	
	//could rewrite using for-each in v17
	OB GET PROPERTY NAMES:C1232($options; $properties)
	For ($i; 1; Size of array:C274($properties))
		$property:=$properties{$i}
		_argument($options; $property)
	End for 
	
	Case of 
		: (Is macOS:C1572)
			
			CONVERT FROM TEXT:C1011($html; $encoding; $stdIn)
			
			If (OK=0)
				$console.log(New object:C1471("info"; "encoding '"+$encoding+"' failed. try again with '"+$fallback_encoding+"'."))
				$encoding:=$fallback_encoding
				CONVERT FROM TEXT:C1011($html; $encoding; $stdIn)
			End if 
			
			If (OK=1)
				$command:=$path+" --encoding "+$encoding+$options.value+" - -"
				LAUNCH EXTERNAL PROCESS:C811($command; $stdIn; $stdOut; $stdErr)
			End if 
			
		: (Is Windows:C1573)
			
			//capturing strOut is too slow on windows
			
			$uuid:=Generate UUID:C1066
			$stdInPath:=Temporary folder:C486+$uuid+".html"
			$stdOutPath:=Temporary folder:C486+$uuid+".pdf"
			
			TEXT TO DOCUMENT:C1237($stdInPath; $html; $encoding)
			
			If (OK=0)
				$console.log(New object:C1471("info"; "encoding '"+$encoding+"' failed. try again with '"+$fallback_encoding+"'."))
				$encoding:=$fallback_encoding
				CONVERT FROM TEXT:C1011($html; $encoding; $stdIn)
			End if 
			
			If (OK=1)
				$command:=$path+" --encoding "+$encoding+$options.value+" "+LEP_Escape_path($stdInPath)+" "+LEP_Escape_path($stdOutPath)
				LAUNCH EXTERNAL PROCESS:C811($command)
				
				DOCUMENT TO BLOB:C525($stdOutPath; $stdOut)
				DELETE DOCUMENT:C159($stdInPath)
				DELETE DOCUMENT:C159($stdOutPath)
			End if 
			
	End case 
	
	Case of 
		: (Is macOS:C1572)
			
			//process results
			$err:=Convert to text:C1012($stdErr; $cli_encoding)
			
			$options.errors:=Split string:C1554($err; "\n"; sk trim spaces:K86:2 | sk ignore empty strings:K86:1)
			//[Exit with code 1 due to network error: ContentNotFoundError]
			//could mean invalid local path
			//https://github.com/wkhtmltopdf/wkhtmltopdf/issues/2051
			
			//test stdOut
			$output:=""
			
			$output:=Convert to text:C1012($stdOut; $cli_encoding)
			
			If (Length:C16($output)#0)
				If (Split string:C1554($output; "\n"; sk trim spaces:K86:2 | sk ignore empty strings:K86:1).length=0)
					SET BLOB SIZE:C606($stdOut; 0)  //result is empty
				End if 
			End if 
			
	End case 
	
End if 

$0:=$stdOut

$console.stop()