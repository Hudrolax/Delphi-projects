#if !defined(AFX_SELPORT_H__9120C90D_C0E5_4C27_9E52_DCDEEB1AFE28__INCLUDED_)
#define AFX_SELPORT_H__9120C90D_C0E5_4C27_9E52_DCDEEB1AFE28__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// SelPort.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CSelPort dialog

class CSelPort : public CDialog
{
// Construction
public:
	CSelPort(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CSelPort)
	enum { IDD = IDD_DIALOG1 };
	CEdit	m_CtrlPort;
	int		m_port;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSelPort)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CSelPort)
	afx_msg void OnAbout();
	virtual BOOL OnInitDialog();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SELPORT_H__9120C90D_C0E5_4C27_9E52_DCDEEB1AFE28__INCLUDED_)
