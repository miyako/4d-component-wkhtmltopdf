# 4d-component-wkhtmltopdf
4D wrapper for wkhtmltopdf

### Discussion

It is very hard to use ``libwkhtmltopdf`` as a plugin-style module for 4D. The menu bar is corrupted, the event loop is disrupted...just not worth it. Much easier to run the CLI with ``LAUNCH EXTERNAL PROCESS``. Thankfully the command is now thread safe. 

### Platform

| carbon | cocoa | win32 | win64 |
|:------:|:-----:|:---------:|:---------:|
|<img src="https://cloud.githubusercontent.com/assets/1725068/22371562/1b091f0a-e4db-11e6-8458-8653954a7cce.png" width="24" height="24" />|<img src="https://cloud.githubusercontent.com/assets/1725068/22371562/1b091f0a-e4db-11e6-8458-8653954a7cce.png" width="24" height="24" />|<img src="https://cloud.githubusercontent.com/assets/1725068/22371562/1b091f0a-e4db-11e6-8458-8653954a7cce.png" width="24" height="24" />|<img src="https://cloud.githubusercontent.com/assets/1725068/22371562/1b091f0a-e4db-11e6-8458-8653954a7cce.png" width="24" height="24" />|

### Releases

[1.0](https://github.com/miyako/4d-component-wkhtmltopdf/releases/tag/1.0) 
