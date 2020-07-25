// KeTerm.h : main header file for the KETERM application
//

#if !defined(AFX_KETERM_H__50963B45_4A68_4F1F_A439_3EB9192C73F5__INCLUDED_)
#define AFX_KETERM_H__50963B45_4A68_4F1F_A439_3EB9192C73F5__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CKeTermApp:
// See KeTerm.cpp for the implementation of this class
//

class CKeTermApp : public CWinApp
{
public:
	CKeTermApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CKeTermApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CKeTermApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_KETERM_H__50963B45_4A68_4F1F_A439_3EB9192C73F5__INCLUDED_)
