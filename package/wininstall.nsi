; based on https://github.com/AnonymerNiklasistanonym/NsiWindowsInstallerExamples/blob/main/example_03_modern_ui_and_multi_language/windows_installer.nsi

;--------------------------------
;Include Modern UI

!include "MUI2.nsh"


;--------------------------------
;Custom Variables

;Define name of the product
!define PRODUCT "Saint_Helens"

;Define website of the product
!define PRODUCT_URL "https://en.wikipedia.org/wiki/Mount_St._Helens"

!define SRCPATH "..\dist\${PRODUCT}"

!define LangStringUninstallLink "Uninstall ${PRODUCT}"
!define LangStringLicenseLink "License"
!define EXECPATH "$INSTDIR\${PRODUCT}.exe"
!define DISPLAYNAME "Saint Helens"
!define ICONPATH "$INSTDIR\media\${PRODUCT}.ico"

;--------------------------------
;General information

;Properly display all languages
Unicode true

;The name of the installer
Name "${PRODUCT}"

;The output file path of the installer to be created
OutFile "..\dist\${PRODUCT}_install.exe"

;The default installation directory
InstallDir "$PROGRAMFILES64\${PRODUCT}"

;Registry key to check for a install directory from a previous installation
InstallDirRegKey HKLM "Software\${PRODUCT}" "Install_Dir"

;Request application privileges for admin level privileges
RequestExecutionLevel admin

;Show the 'console' in installer
ShowInstDetails "show"

;Show the 'console' in uninstaller
ShowUninstDetails "show"


;--------------------------------
;Interface Settings

;Warn the user before aborting the installer
!define MUI_ABORTWARNING

;Disable component descriptions

!define MUI_COMPONENTSPAGE_NODESC

;Use a custom icon
!define MUI_ICON "..\media\${PRODUCT}.ico"
;!define MUI_UNICON "icon_uninstaller.ico"

;Use a custom picture for the 'Welcome' and 'Finish' page
;!define MUI_HEADERIMAGE_RIGHT
;!define MUI_WELCOMEFINISHPAGE_BITMAP "..\example_files\picture_installer.bmp"
;!define MUI_UNWELCOMEFINISHPAGE_BITMAP "..\example_files\picture_uninstaller.bmp"


;--------------------------------
;Installer pages

;Show a page where the user needs to accept a license

; pyinstaller creates License.txt in dist

!insertmacro MUI_PAGE_LICENSE "${SRCPATH}\media\License.txt"

;Show a page where the user can customize the components to be installed
;!insertmacro MUI_PAGE_COMPONENTS
;Show a page where the user can customize the install directory
!insertmacro MUI_PAGE_DIRECTORY
;Show a page where the progress of the install is listed
!insertmacro MUI_PAGE_INSTFILES


;--------------------------------
;Uninstaller pages

;Show a page where the user needs to confirm the uninstall
!insertmacro MUI_UNPAGE_CONFIRM
;Show a page where the progress of the uninstall is listed
!insertmacro MUI_UNPAGE_INSTFILES


;--------------------------------
;Translations

;Include translations from an external file
;!include "windows_installer_translations.nsi"


;--------------------------------
;Start Function

Function .onInit

  ;Show a dialog where the user can select a supported language
  ;!insertmacro MUI_LANGDLL_DISPLAY

FunctionEnd


;--------------------------------
;After Successful Install Function

Function .onInstSuccess

  ;Open a website
  ExecShell "open" "${PRODUCT_URL}"

  ;Open the application
  ExecShell "open" "${EXECPATH}"

FunctionEnd


;--------------------------------
;Installer Components

;Main component
Section $(LangStringSecMainComponentName) SecMainComponent

  ;Make this component mandatory so the user is not able to disable it
  SectionIn RO


  ;Write the selected (either default or customized) installation path into the
  ;registry
  WriteRegStr HKLM "Software\${PRODUCT}" "Install_Dir" "$INSTDIR"


  ;Set output path to the installation directory
  SetOutPath $INSTDIR

  CreateDirectory "$INSTDIR"

  ;Now you can list files that should be extracted to this output path or create
  ;directories:

  ;Copy a file to the current SetOutPath directory

  File /r "${SRCPATH}\*"
  
  ;https://nsis.sourceforge.io/Docs/Chapter4.html#file


  ;Copy a file to the current SetOutPath directory with a custom name
  ;File "/oname=custom_name.txt" "..\example_files\example.txt"

  ;Create a directory
  ; CreateDirectory "$INSTDIR\Saint_Helens"


  ;Copy a file to the current SetOutPath directory with a custom name
  ;File "/oname=custom_name_in_directory.txt" "..\example_files\example.txt"


  ;Now you can create an uninstaller that will also be recognized by Windows:
  WriteRegStr   HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT}" "DisplayName"          "${PRODUCT}"
  WriteRegStr   HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT}" "UninstallString"      "$\"$INSTDIR\uninstall.exe$\""
  WriteRegStr   HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT}" "QuietUninstallString" "$\"$INSTDIR\uninstall.exe$\" /S"
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT}" "NoModify"        1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT}" "NoRepair"        1
  WriteUninstaller "uninstall.exe"



 ; CreateDirectory "$SMPROGRAMS\${PRODUCT}"
 
  CreateShortcut "$SMPROGRAMS\${DISPLAYNAME}.lnk" "${EXECPATH}" "" "${ICONPATH}" 0
  CreateShortcut "$DESKTOP\${DISPLAYNAME}.lnk" "${EXECPATH}" "" "${ICONPATH}" 0
  CreateShortcut "$SENDTO\${DISPLAYNAME}.lnk" "${EXECPATH}" "" "${ICONPATH}" 0


 ; CreateShortcut "$SMPROGRAMS\${PRODUCT}\${DISPLAYNAME}.lnk" "${EXECPATH}" "${EXECPATH}" 0
 ; CreateShortcut "$SMPROGRAMS\${PRODUCT}\$(LangStringLicenseLink).lnk" "$INSTDIR\media\License.txt" "$INSTDIR\media\License.txt" 0
 ; CreateShortcut "$SMPROGRAMS\${PRODUCT}\$(LangStringUninstallLink).lnk" "$INSTDIR\uninstall.exe" "$INSTDIR\uninstall.exe" 0
  
SectionEnd


;Uninstall component
Section "Uninstall"

  ;Remove registry keys that were set by the installer
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT}"
  DeleteRegKey HKLM "Software\${PRODUCT}"

  ;Remove files that were installed by the installer and the created uninstaller
  ;Add 'RMDir /r "$INSTDIR\folder\*.*"' for every folder that was created
  ;in the installation directory
  RMDir /r "$INSTDIR\*"
  RMDir /r "$INSTDIR\*.*"
  ;Remove shortcuts
  Delete "$SMPROGRAMS\${DISPLAYNAME}.lnk"
  Delete "$DESKTOP\${DISPLAYNAME}.lnk"
  Delete "$SENDTO\${DISPLAYNAME}.lnk"


  ;Remove directories that were created by the installer
  
  RMDir "$INSTDIR"
  
SectionEnd


;--------------------------------
;Installer Components Descriptions

;!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
;  !insertmacro MUI_DESCRIPTION_TEXT ${SecMainComponent} $(LangStringSecMainComponentDescription)
;  !insertmacro MUI_DESCRIPTION_TEXT ${SecOptionalComponent} $(LangStringSecOptionalComponentDescription)
;!insertmacro MUI_FUNCTION_DESCRIPTION_END
