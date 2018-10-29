# 4d-component-wkhtmltopdf
4D wrapper for wkhtmltopdf

### Discussion

It is very hard to use ``libwkhtmltopdf`` as a plugin-style module for 4D. The menu bar is corrupted, the event loop is disrupted...just not worth it. Much easier to run the CLI with ``LAUNCH EXTERNAL PROCESS``. Thankfully the command is now thread safe. 
