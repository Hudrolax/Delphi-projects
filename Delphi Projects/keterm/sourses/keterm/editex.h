//**************************************************************************
#include "Resource.h"
#include "stdafx.h"
#include "KeTermDlg.h"

#pragma once

#if !defined EDITEX_H
#define EDITEX_H

#define WM_EDITEX_CHANGE WM_USER+1
//**************************************************************************
class CEditEx : public CEdit
{
	DECLARE_DYNAMIC(CEditEx)

public:
	CEditEx();
	virtual ~CEditEx();
  
protected:
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
	DECLARE_MESSAGE_MAP()

private:
	afx_msg HBRUSH CtlColor(CDC* /*pDC*/, UINT /*nCtlColor*/);
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);	
	afx_msg void OnEnChange();

	CBrush m_Brush; 
	CFont m_Font;   
	COLORREF m_ColorBG;   
	COLORREF m_ColorText; 
  
public:   
	void SetColorBG(const COLORREF& color);
	void SetColorText(const COLORREF& color); 	
	void SetEditExFont(const int& height, const int& weight, const CString& fontname);
	void SetEditExFont(LOGFONT* logfont);	
	CFont* GetEditExFont(void);	
	BOOL CreateEditEx(const CRect& rect, CWnd* parent, const unsigned int& ID=0);
};


#endif