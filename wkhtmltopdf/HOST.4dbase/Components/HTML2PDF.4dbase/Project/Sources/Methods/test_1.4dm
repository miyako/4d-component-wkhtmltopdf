//%attributes = {}
$path:=Get 4D folder:C485(Current resources folder:K5:16)+"test.html"

$html:=Document to text:C1236($path; "utf-8")

C_OBJECT:C1216($options)
$options:=New object:C1471
$options.grayscale:=True:C214
$options.dpi:=72
$options.logLevel:="none"
$options.externalLinks:=False:C215
$options.collate:=False:C215
$options.copies:=1
$options.imageDpi:=300
$options.imageQuality:=100
$options.lowquality:=True:C214
$options.orientation:="Landscape"  //Portrait
$options.marginBottom:="0mm"
$options.marginLeft:="0mm"
$options.marginRight:="0mm"
$options.marginTop:="0mm"
//$options.pageHeight:="30cm"
//$options.pageWidth:="30cm"
$options.pageSize:="A4"
$options.title:="TEST"
$options.pdfCompression:=False:C215

$options.outline:=True:C214
$options.outlineDepth:=8

$options.background:=True:C214
$options.loadErrorHandling:="skip"  //abort,ignore
$options.loadMediaErrorHandling:="skip"  //abort,ignore
$options.localFileAccess:=True:C214
//$options.minimumFontSize:=20

$options.zoom:=2

//repeatable properties not implemented;
//allow,bypassProxyFor,cookie*,customHeader,post,postFile,runScript,replace

$pdf:=wkhtmltopdf($options; $html; "utf-8")

//$pdf is empty in case of conversion failure
//$options.errors[] may contain error information (may not be failure)
//$options.value contains the command line string

If (BLOB size:C605($pdf)#0)
	
	$path:=System folder:C487(Desktop:K41:16)+Generate UUID:C1066+".pdf"
	
	BLOB TO DOCUMENT:C526($path; $pdf)
	OPEN URL:C673($path)
	
End if 