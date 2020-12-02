![platform](https://img.shields.io/static/v1?label=platform&message=osx-64%20|%20win-32%20|%20win-64&color=blue)

![downloads](https://img.shields.io/github/downloads/miyako/4d-component-wkhtmltopdf/total)

# 4d-component-wkhtmltopdf
4D wrapper for wkhtmltopdf

### Discussion

It is very hard to use ``libwkhtmltopdf`` as a plugin-style module for 4D. The menu bar is corrupted, the event loop is disrupted...just not worth it. Much easier to run the CLI with ``LAUNCH EXTERNAL PROCESS``. Thankfully the command is now thread safe. 

#### About Notarisation

If ``wkhtmltopdf`` is notarised without entitlements,

i.e.

```sh
codesign 
	--verbose 
	--deep 
	--timestamp
	--force 
	--sign "Developer ID Application: keisuke miyako (Y69CWUC25B)" 
	--options=runtime 
```

it will not work anymore.

```
Loading pages (1/6)
Bus error: 10                                                ] 10%
```

It must be codesigned and notarised with sufficient entitlements.

### Usage

Pass the [standard arguments](https://wkhtmltopdf.org/usage/wkhtmltopdf.txt) in camelcase.

```
$path:=Get 4D folder(Current resources folder)+"test.html"

$html:=Document to text($path;"utf-8")

C_OBJECT($options)
$options:=New object
$options.grayscale:=True
$options.dpi:=72
$options.logLevel:="none"
$options.externalLinks:=False
$options.collate:=False
$options.copies:=1
$options.imageDpi:=300
$options.imageQuality:=100
$options.lowquality:=True
$options.orientation:="Landscape"  //Portrait
$options.marginBottom:="0mm"
$options.marginLeft:="0mm"
$options.marginRight:="0mm"
$options.marginTop:="0mm"
  //$options.pageHeight:="30cm"
  //$options.pageWidth:="30cm"
$options.pageSize:="A4"
$options.title:="TEST"
$options.pdfCompression:=False

$options.outline:=True
$options.outlineDepth:=8

$options.background:=True
$options.loadErrorHandling:="skip"  //abort,ignore
$options.loadMediaErrorHandling:="skip"  //abort,ignore
$options.localFileAccess:=True
  //$options.minimumFontSize:=20

$options.zoom:=2

  //repeatable properties not implemented;
  //allow,bypassProxyFor,cookie*,customHeader,post,postFile,runScript,replace

$pdf:=wkhtmltopdf ($options;$html;"utf-8")

  //$pdf is empty in case of conversion failure
  //$options.errors[] may contain error information (may not be failure)
  //$options.value contains the command line string

If (BLOB size($pdf)#0)
	
	$path:=System folder(Desktop)+Generate UUID+".pdf"
	
	BLOB TO DOCUMENT($path;$pdf)
	OPEN URL($path)
	
End if 
```
