// SelPort.cpp : implementation file
//

#include "stdafx.h"
#include "KeTerm.h"
#include "SelPort.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CSelPort dialog


CSelPort::CSelPort(CWnd* pParent /*=NULL*/)
	: CDialog(CSelPort::IDD, pParent)
{
	//{{AFX_DATA_INIT(CSelPort)
	m_port = 0;
	//}}AFX_DATA_INIT
}


void CSelPort::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CSelPort)
	DDX_Control(pDX, IDC_EDIT1, m_CtrlPort);
	DDX_Text(pDX, IDC_EDIT1, m_port);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CSelPort, CDialog)
	//{{AFX_MSG_MAP(CSelPort)
	ON_COMMAND(ID_ABOUT, OnAbout)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSelPort message handlers

void CSelPort::OnAbout() 
{
	// TODO: Add your command handler code here
	
}

BOOL CSelPort::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	// TODO: Add extra initialization here  
	
	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}
