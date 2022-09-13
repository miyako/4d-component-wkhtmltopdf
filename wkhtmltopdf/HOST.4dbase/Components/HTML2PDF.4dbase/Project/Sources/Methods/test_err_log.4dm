//%attributes = {}
$console:=console

If (False:C215)
	
	$console.start()
	
	ASSERT:C1129(False:C215)
	
	$console.stop()
	
End if 

$path:=Get 4D folder:C485(Current resources folder:K5:16)+"test.html"

$html:=Document to text:C1236($path; "utf-8")

$pdf:=wkhtmltopdf($options; ""; "some invalid encoding")

$pdf:=wkhtmltopdf($options; $html; "some invalid encoding")