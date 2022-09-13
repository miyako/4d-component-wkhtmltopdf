//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($1)
C_TEXT:C284(${2})

If ($2#"value")  //internal prop.
	
	$valueType:=Value type:C1509($1[$2])
	
	//convert camel case property name to long argument name
	$argument:=""
	For ($i; 1; Length:C16($2))
		$char:=$2[[$i]]
		$lower:=Lowercase:C14($char)
		If (Character code:C91($char)#Character code:C91($lower))
			$argument:=$argument+"-"+$lower
		Else 
			$argument:=$argument+$char
		End if 
	End for 
	
	If ($argument#"read-args-from-stdin")  //this prop. makes no sense in our context
		
		Case of 
			: ($valueType=Is boolean:K8:9)
				
				$enable_disable:=New collection:C1472("externalLinks"; "forms"; "internalLinks"; "javascript"; "localFileAccess")
				$enable_only:=New collection:C1472("grayscale"; "lowquality"; "quiet"; "extendedHelp"; "help"; "htmldoc"; "license"; "manpage"; "readme"; "useXserver"; "version"; "dumpDefaultTocXsl"; "defaultHeader"; "keepRelativeLinks")
				
				If ($1[$2])
					
					Case of 
						: ($2="pdfCompression")
							
						: ($enable_disable.indexOf($2)#-1)
							$1.value:=$1.value+" --enable-"+$argument
						Else 
							$1.value:=$1.value+" --"+$argument
					End case 
					
				Else 
					Case of 
						: ($enable_only.indexOf($2)#-1)
							//ignore this option
						: ($enable_disable.indexOf($2)#-1)
							$1.value:=$1.value+" --disable-"+$argument
						Else 
							$1.value:=$1.value+" --no-"+$argument
					End case 
					
				End if 
				
			: ($valueType=Is real:K8:4) | ($valueType=Is text:K8:3)
				
				$specify_path:=New collection:C1472("dumpOutline"; "cookieJar"; "cacheDir"; "checkboxSvg"; "sslKeyPath"; "sslCrtPath"; "radiobuttonSvg"; "radiobuttonCheckedSvg")
				
				Case of 
					: ($specify_path.indexOf($2)#-1)
						$1.value:=$1.value+" --"+$argument+" "+LEP_Escape_path(String:C10($1[$2]))
					Else 
						$1.value:=$1.value+" --"+$argument+" "+LEP_Escape(String:C10($1[$2]))
				End case 
				
		End case 
		
	End if 
	
End if 