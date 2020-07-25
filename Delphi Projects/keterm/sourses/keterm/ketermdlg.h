// KeTermDlg.h : header file
//

#if !defined(AFX_KETERMDLG_H__E9080D2F_0F91_441D_851F_AC694F434E7A__INCLUDED_)
#define AFX_KETERMDLG_H__E9080D2F_0F91_441D_851F_AC694F434E7A__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
#include "EditEx.h"
#include "SelPort.h"
#define WM_EDITEX_CHANGE WM_USER+1
/////////////////////////////////////////////////////////////////////////////
// CKeTermDlg dialog

class CKeTermDlg : public CDialog
{
// Construction
public:
	CKeTermDlg(CWnd* pParent = NULL);	// standard constructor
  //CKeTermDlg(){};

  int LineCounter;
  LRESULT OnChangeCEditEx(WPARAM wParam, LPARAM lParam);
  void AddDataToWindow(CEditEx* ed, unsigned char* buf, int len);
  void SendDataToDevice(unsigned char* buf, int len);
  
  CMenu m_menu;
  HANDLE m_hFile;
  CSelPort dlg;
  bool bTerminateThread;

// Dialog Data
	//{{AFX_DATA(CKeTermDlg)
	enum { IDD = IDD_KETERM_DIALOG };
	CEditEx	m_out;
	CEditEx	m_in;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CKeTermDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CKeTermDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();		
	afx_msg void OnDeviceConnect();
	afx_msg void OnDeviceDisconnect();
	afx_msg void OnAbout();
	afx_msg void OnDestroy();
	afx_msg void OnVscrollEdit1();
	afx_msg void OnVscrollEdit2();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_KETERMDLG_H__E9080D2F_0F91_441D_851F_AC694F434E7A__INCLUDED_)
