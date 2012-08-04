@ECHO OFF
SET SLMGR=cscript //NOLOGO "%SYSTEMROOT%\System32\slmgr.vbs"
SET BCDEDIT=%SYSTEMROOT%\System32\bcdedit.exe
SET /a COUNT=0
ECHO removing boot entry.
ECHO please wait...
%BCDEDIT% /set {bootmgr} path "\EFI\Microsoft\Boot\bootmgfw.efi" >nul
FOR /F "tokens=2" %%A IN ('%BCDEDIT% /enum BOOTMGR ^| FINDSTR /I /R /C:"{........-.*}"') DO (
	%BCDEDIT% /enum %%A | FIND /I "\EFI\WindSLIC\BOOTX64.EFI" >nul
	IF NOT !ERRORLEVEL!==1 (
		SET /A COUNT=%COUNT%+1
		ECHO found WindSLIC boot entry.
		ECHO deleting %%A
		%BCDEDIT% /delete %%A >nul
		ECHO setting boot order.
		%BCDEDIT% /set {fwbootmgr} displayorder {bootmgr} /addfirst >nul
	)
)
IF %COUNT%==0 ECHO WindSLIC boot entry not found.
"%~dp0Installer_EFI_cli.exe"
ECHO installing certificate...
%SLMGR% -ilc "%~dp0ACER.XRM-MS" >nul
ECHO installing key.
ECHO please wait...
CALL :PRODUCT_VER_CHECK
%SLMGR% -ipk %PID_KEY% >nul
ECHO restart computer to finish activation.
PAUSE
EXIT

:PRODUCT_VER_CHECK

   REG QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "ProductName" | FINDSTR /C:"Windows 7" >nul
   IF ERRORLEVEL 1 ECHO ERROR: not Windows 7 & PAUSE & EXIT

   FOR /F "tokens=3" %%A IN ('REG QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "EditionID"') DO SET EditionID=%%A

   ECHO %EditionID% | FINDSTR /I "Starter" >nul
   IF NOT ERRORLEVEL 1 CALL :STARTER_KEY & GOTO :EOF

   ECHO %EditionID% | FINDSTR /I "HomeBasic" >nul
   IF NOT ERRORLEVEL 1 CALL :HOMEBASIC_KEY & GOTO :EOF

   ECHO %EditionID% | FINDSTR /I "HomePremium" >nul
   IF NOT ERRORLEVEL 1 CALL :HOMEPREMIUM_KEY & GOTO :EOF

   ECHO %EditionID% | FINDSTR /I "Professional" >nul
   IF NOT ERRORLEVEL 1 CALL :PROFESSIONAL_KEY & GOTO :EOF

   ECHO %EditionID% | FINDSTR /I "Ultimate" >nul
   IF NOT ERRORLEVEL 1 CALL :ULTIMATE_KEY & GOTO :EOF

   IF ERRORLEVEL 1 ECHO ERROR: OS is unsupported & PAUSE & EXIT
GOTO :EOF

:STARTER_KEY
   SET MAX_RANDOM=5
   SET /A RANDOM_PID_KEY=%RANDOM% %% %MAX_RANDOM%
   IF '%RANDOM_PID_KEY%'=='0' SET PID_KEY=RDJXR-3M32B-FJT32-QMPGB-GCFF6
   IF '%RANDOM_PID_KEY%'=='1' SET PID_KEY=6K6WB-X73TD-KG794-FJYHG-YCJVG
   IF '%RANDOM_PID_KEY%'=='2' SET PID_KEY=36Q3Y-BBT84-MGJ3H-FT7VD-FG72J
   IF '%RANDOM_PID_KEY%'=='3' SET PID_KEY=RH98C-M9PW4-6DHR7-X99PJ-3FGDB
   IF '%RANDOM_PID_KEY%'=='4' SET PID_KEY=273P4-GQ8V6-97YYM-9YTHF-DC2VP
GOTO :EOF

:HOMEBASIC_KEY
   SET MAX_RANDOM=5
   SET /A RANDOM_PID_KEY=%RANDOM% %% %MAX_RANDOM%
   IF '%RANDOM_PID_KEY%'=='0' SET PID_KEY=MB4HF-2Q8V3-W88WR-K7287-2H4CP
   IF '%RANDOM_PID_KEY%'=='1' SET PID_KEY=89G97-VYHYT-Y6G8H-PJXV6-77GQM
   IF '%RANDOM_PID_KEY%'=='2' SET PID_KEY=36T88-RT7C6-R38TQ-RV8M9-WWTCY
   IF '%RANDOM_PID_KEY%'=='3' SET PID_KEY=DX8R9-BVCGB-PPKRR-8J7T4-TJHTH
   IF '%RANDOM_PID_KEY%'=='4' SET PID_KEY=22MFQ-HDH7V-RBV79-QMVK9-PTMXQ
GOTO :EOF

:HOMEPREMIUM_KEY
   SET MAX_RANDOM=5
   SET /A RANDOM_PID_KEY=%RANDOM% %% %MAX_RANDOM%
   IF '%RANDOM_PID_KEY%'=='0' SET PID_KEY=VQB3X-Q3KP8-WJ2H8-R6B6D-7QJB7
   IF '%RANDOM_PID_KEY%'=='1' SET PID_KEY=38JTJ-VBPFW-XFQDR-PJ794-8447M
   IF '%RANDOM_PID_KEY%'=='2' SET PID_KEY=2QDBX-9T8HR-2QWT6-HCQXJ-9YQTR
   IF '%RANDOM_PID_KEY%'=='3' SET PID_KEY=7JQWQ-K6KWQ-BJD6C-K3YVH-DVQJG
   IF '%RANDOM_PID_KEY%'=='4' SET PID_KEY=6RBBT-F8VPQ-QCPVQ-KHRB8-RMV82
GOTO :EOF

:PROFESSIONAL_KEY
   SET MAX_RANDOM=5
   SET /A RANDOM_PID_KEY=%RANDOM% %% %MAX_RANDOM%
   IF '%RANDOM_PID_KEY%'=='0' SET PID_KEY=YKHFT-KW986-GK4PY-FDWYH-7TP9F
   IF '%RANDOM_PID_KEY%'=='1' SET PID_KEY=2WCJK-R8B4Y-CWRF2-TRJKB-PV9HW
   IF '%RANDOM_PID_KEY%'=='2' SET PID_KEY=32KD2-K9CTF-M3DJT-4J3WC-733WD
   IF '%RANDOM_PID_KEY%'=='3' SET PID_KEY=PT9YK-BC2J9-WWYF9-R9DCR-QB9CK
   IF '%RANDOM_PID_KEY%'=='4' SET PID_KEY=862R9-99CD6-DD6WM-GHDG2-Y8M37
GOTO :EOF

:ULTIMATE_KEY
   SET MAX_RANDOM=5
   SET /A RANDOM_PID_KEY=%RANDOM% %% %MAX_RANDOM%
   IF '%RANDOM_PID_KEY%'=='0' SET PID_KEY=FJGCP-4DFJD-GJY49-VJBQ7-HYRR2
   IF '%RANDOM_PID_KEY%'=='1' SET PID_KEY=VQ3PY-VRX6D-CBG4J-8C6R2-TCVBD
   IF '%RANDOM_PID_KEY%'=='2' SET PID_KEY=2Y4WT-DHTBF-Q6MMK-KYK6X-VKM6G
   IF '%RANDOM_PID_KEY%'=='3' SET PID_KEY=342DG-6YJR8-X92GV-V7DCV-P4K27
   IF '%RANDOM_PID_KEY%'=='4' SET PID_KEY=78FPJ-C8Q77-QV7B8-9MH3V-XXBTK
GOTO :EOF