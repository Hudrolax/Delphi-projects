// KeTermDlg.cpp : implementation file
//

#include "stdafx.h"
#include "KeTerm.h"
#include "KeTermDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

DWORD dwBytesRead, lpdwBytesWritten;
BYTE pBuff[65535];
char buf[256];

UINT StreamReader(void* param);
/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About
class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAboutDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	//{{AFX_MSG(CAboutDlg)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
	//{{AFX_MSG_MAP(CAboutDlg)
		// No message handlers
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CKeTermDlg dialog

CKeTermDlg::CKeTermDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CKeTermDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CKeTermDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CKeTermDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CKeTermDlg)
	DDX_Control(pDX, IDC_EDIT2, m_out);
	DDX_Control(pDX, IDC_EDIT1, m_in);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CKeTermDlg, CDialog)
	//{{AFX_MSG_MAP(CKeTermDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()		
	ON_COMMAND(ID_DEVICE_CONNECT, OnDeviceConnect)
	ON_COMMAND(ID_DEVICE_DISCONNECT, OnDeviceDisconnect)
	ON_COMMAND(ID_ABOUT, OnAbout)
	ON_WM_DESTROY()
	ON_EN_VSCROLL(IDC_EDIT1, OnVscrollEdit1)
  ON_MESSAGE(WM_EDITEX_CHANGE, OnChangeCEditEx)
	ON_EN_VSCROLL(IDC_EDIT2, OnVscrollEdit2)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CKeTermDlg message handlers

BOOL CKeTermDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Add "About..." menu item to system menu.

	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
	// TODO: Add extra initialization here

  LineCounter = 1;
  COLORREF color = RGB(0,128,0);  
  int height = 20;
  int weight = 3;
  CString fontname = "Verdana";

  m_out.SetColorText(color);
  m_out.SetEditExFont(height, weight, fontname);
  m_in.SetColorText(color);
  m_in.SetEditExFont(height, weight, fontname);

  m_hFile = NULL;
  bTerminateThread = false;
   
  m_menu.LoadMenu(IDR_MENU1);
  this->SetMenu(&m_menu);

  m_in.EnableWindow(FALSE);
  m_out.EnableWindow(FALSE);
  
  char start_text[] = "$KE\r\n";

  AddDataToWindow(&m_in, (unsigned char*)start_text, sizeof(start_text));

  m_menu.EnableMenuItem(ID_DEVICE_DISCONNECT, MF_GRAYED);

	
	return TRUE;  // return TRUE  unless you set the focus to a control
}

//**************************************************************************
void CKeTermDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

//**************************************************************************
void CKeTermDlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// The system calls this to obtain the cursor to display while the user drags
//  the minimized window.
//**************************************************************************
HCURSOR CKeTermDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

//**************************************************************************
LRESULT CKeTermDlg::OnChangeCEditEx(WPARAM wParam, LPARAM lParam)
{
	if( (HWND)wParam == m_in.m_hWnd)
	{
		int count = m_in.GetLineCount();
    if(count > this->LineCounter) // Enter key have been pressed
    {      
      int start, end;
      m_in.GetSel(start, end);
      HLOCAL h = m_in.GetHandle();
      LPCTSTR lpszText = (LPCTSTR) ::LocalLock(h);
      
      for(int i = start-3; i > 0; i-- )
      {
        if(lpszText[i] == 0x0A && lpszText[i-1] == 0x0D)
        {
          i++;
          break;
        }
      }

      int len = start - i;
      memcpy(buf, &(lpszText[i]), len);      
      SendDataToDevice((unsigned char*)buf, len);
      ::LocalUnlock(h);
    }
    this->LineCounter = count;
	}
  
	return LRESULT();
}

//**************************************************************************
void CKeTermDlg::OnDeviceConnect() 
{
	// TODO: Add your command handler code here    
  if( dlg.DoModal() == IDOK)
  {
    int port = dlg.m_port;
    if(port <0 || port > 255)
    {
      MessageBox("Uncorrect Port", "Error", MB_ICONERROR);
      return;
    }

    if(this->m_hFile != NULL)
      CloseHandle(m_hFile);

    
    char COM_string[32];
    DCB dcb;	

	  sprintf(COM_string,"\\\\.\\COM%d", port);
	  m_hFile = CreateFile(COM_string, GENERIC_READ|GENERIC_WRITE, 0, NULL,						
	      OPEN_EXISTING, 0,NULL);

	  if(m_hFile!=INVALID_HANDLE_VALUE)
	  {		
      GetCommState(m_hFile, &dcb);

		  dcb.BaudRate  = CBR_9600;  // FORMALLY, CONNECT BAUD DOESN`T MATTER (Virtual Com Port)
		  dcb.ByteSize  = 8;             
		  dcb.Parity    = NOPARITY;        
		  dcb.StopBits  = ONESTOPBIT;    

		  COMMTIMEOUTS CommTimeOuts;
		  CommTimeOuts.ReadIntervalTimeout          = MAXDWORD;
		  CommTimeOuts.ReadTotalTimeoutMultiplier   = 0;
		  CommTimeOuts.ReadTotalTimeoutConstant     = 0;
		  CommTimeOuts.WriteTotalTimeoutMultiplier  = 0;
		  CommTimeOuts.WriteTotalTimeoutConstant    = 1000;
		  SetCommTimeouts(m_hFile, &CommTimeOuts);
		  SetCommState(m_hFile, &dcb);
	  }
	  else 
	  {
		  MessageBox("Can`t Open Port", "Error", MB_ICONERROR);	
		  return;
	  }

    m_menu.EnableMenuItem(ID_DEVICE_DISCONNECT, MF_ENABLED);
    m_menu.EnableMenuItem(ID_DEVICE_CONNECT,    MF_GRAYED);

    bTerminateThread = false;
    AfxBeginThread(StreamReader, this);

    CString s1;
    s1.Format("KeTerm : COM%d Connected", port);
    this->SetWindowText(s1);
    m_in.EnableWindow(TRUE);
    m_out.EnableWindow(TRUE);

    //MessageBox("Open OK", "Info", MB_ICONINFORMATION);	
  }
	
}

//**************************************************************************
void CKeTermDlg::OnDeviceDisconnect() 
{
	// TODO: Add your command handler code here
  bTerminateThread = true;

  if(this->m_hFile != NULL)
      CloseHandle(m_hFile);	

  m_menu.EnableMenuItem(ID_DEVICE_DISCONNECT, MF_GRAYED);
  m_menu.EnableMenuItem(ID_DEVICE_CONNECT,    MF_ENABLED);  

  this->SetWindowText("KeTerm");
  m_in.EnableWindow(FALSE);
  m_out.EnableWindow(FALSE);
}

//**************************************************************************
void CKeTermDlg::AddDataToWindow(CEditEx* ed, unsigned char* buf, int len)
{  
  int edLenght = ed->GetWindowTextLength();

  if(edLenght > 4000)
  {
    ed->SetSel(0, len);
    ed->Clear();
  }
  edLenght = ed->GetWindowTextLength();
  buf[len] = 0; // null terminated  
  ed->SetSel(edLenght, edLenght + len);    
  ed->ReplaceSel((char*)buf);
}

//**************************************************************************
void CKeTermDlg::SendDataToDevice(unsigned char* buf, int len)
{
  if(m_hFile == NULL || buf == NULL || len <= 0)
    return;

  WriteFile(m_hFile, buf, len, &lpdwBytesWritten, NULL);    
}

//**************************************************************************
UINT StreamReader(void* param)
{
  CKeTermDlg* dlg = (CKeTermDlg*)param;
  int i = 0;	
	while(!(dlg->bTerminateThread))
	{
		ReadFile(dlg->m_hFile, pBuff, sizeof(pBuff), &dwBytesRead, NULL);
		if(dwBytesRead > 0)
		{			
		  dlg->AddDataToWindow(&(dlg->m_out), pBuff, dwBytesRead);      
		}
		Sleep(100);
	}
	return 0;  
}

//**************************************************************************
void CKeTermDlg::OnAbout() 
{	
  CAboutDlg dlgAbout;
	dlgAbout.DoModal();	
}

//**************************************************************************
void CKeTermDlg::OnDestroy() 
{
	CDialog::OnDestroy();
		
  bTerminateThread = true;
  if(this->m_hFile != NULL)
      CloseHandle(m_hFile);	
	
}

//**************************************************************************
//**************************************************************************
//**************************************************************************

//**************************************************************************
void CKeTermDlg::OnVscrollEdit1() 
{
	// TODO: Add your control notification handler code here	
  m_in.Invalidate();
}

void CKeTermDlg::OnVscrollEdit2() 
{
	// TODO: Add your control notification handler code here
	m_out.Invalidate();
}
