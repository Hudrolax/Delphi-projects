; CLW file contains information for the MFC ClassWizard

[General Info]
Version=1
LastClass=CKeTermDlg
LastTemplate=CDialog
NewFileInclude1=#include "stdafx.h"
NewFileInclude2=#include "KeTerm.h"

ClassCount=4
Class1=CKeTermApp
Class2=CKeTermDlg
Class3=CAboutDlg

ResourceCount=8
Resource1=IDD_ABOUTBOX
Resource2=IDR_MAINFRAME
Resource3=IDD_KETERM_DIALOG
Resource4=IDD_KETERM_DIALOG (English (U.S.))
Resource5=IDD_DIALOG1
Resource6=IDR_TOOLBAR1
Resource7=IDD_ABOUTBOX (English (U.S.))
Class4=CSelPort
Resource8=IDR_MENU1

[CLS:CKeTermApp]
Type=0
HeaderFile=KeTerm.h
ImplementationFile=KeTerm.cpp
Filter=N

[CLS:CKeTermDlg]
Type=0
HeaderFile=KeTermDlg.h
ImplementationFile=KeTermDlg.cpp
Filter=D
BaseClass=CDialog
VirtualFilter=dWC
LastObject=IDC_EDIT2

[CLS:CAboutDlg]
Type=0
HeaderFile=KeTermDlg.h
ImplementationFile=KeTermDlg.cpp
Filter=D

[DLG:IDD_ABOUTBOX]
Type=1
ControlCount=4
Control1=IDC_STATIC,static,1342177283
Control2=IDC_STATIC,static,1342308352
Control3=IDC_STATIC,static,1342308352
Control4=IDOK,button,1342373889
Class=CAboutDlg


[DLG:IDD_KETERM_DIALOG]
Type=1
ControlCount=3
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_STATIC,static,1342308352
Class=CKeTermDlg

[DLG:IDD_KETERM_DIALOG (English (U.S.))]
Type=1
Class=CKeTermDlg
ControlCount=2
Control1=IDC_EDIT1,edit,1352732868
Control2=IDC_EDIT2,edit,1352732868

[DLG:IDD_ABOUTBOX (English (U.S.))]
Type=1
Class=CAboutDlg
ControlCount=4
Control1=IDC_STATIC,static,1342177283
Control2=IDC_STATIC,static,1342308480
Control3=IDC_STATIC,static,1342308352
Control4=IDOK,button,1342373889

[TB:IDR_TOOLBAR1]
Type=1
Class=?
Command1=ID_BUTTON32771
Command2=ID_BUTTON32772
CommandCount=2

[MNU:IDR_MENU1]
Type=1
Class=?
Command1=ID_DEVICE_CONNECT
Command2=ID_DEVICE_DISCONNECT
Command3=ID_ABOUT
CommandCount=3

[DLG:IDD_DIALOG1]
Type=1
Class=CSelPort
ControlCount=4
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_STATIC,static,1342308352
Control4=IDC_EDIT1,edit,1350631552

[CLS:CSelPort]
Type=0
HeaderFile=SelPort.h
ImplementationFile=SelPort.cpp
BaseClass=CDialog
Filter=D
LastObject=CSelPort
VirtualFilter=dWC

