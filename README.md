# Windows Local Enumeration Tool
This is a quick tool to get systeminfo, installed software, running services, users and dump NTLM hashes on computer. 



## To use the samdump2.exe utility, you will need to download and install the pwdump7 tool. You can download the pwdump7 tool from the following link:

https://github.com/AlessandroZ/pwdump7/releases

Once you have downloaded and installed the pwdump7 tool, you will need to add the directory containing the samdump2.exe utility to your PATH environment variable. To do this, follow these steps:

1.  Press the Windows key + R to open the Run dialog.
2.  Type control sysdm.cpl and press Enter.
3.  In the System Properties window, click the Advanced tab.
4.  Click the Environment Variables button.
5.  Under System Variables, scroll down and find the Path variable.
6.  Click the Edit button.
7.  Click the New button.
8.  Type the directory path containing the samdump2.exe utility and click OK.
9.  Click OK to close the Environment Variables window.
10. Click OK to close the System Properties window.

Once you have added the directory containing the samdump2.exe utility to your PATH environment variable, you should be able to run the script without



