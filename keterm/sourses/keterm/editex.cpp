//**************************************************************************
#include "stdafx.h"
#include "EditEx.h"

//**************************************************************************
IMPLEMENT_DYNAMIC(CEditEx, CEdit)
CEditEx::CEditEx()
{
	m_Brush.CreateSolidBrush(RGB(255,255,255));
	m_ColorText = RGB(0,0,0);
	m_Font.CreatePointFont(80, "Microsoft Sans Serif");
}

//**************************************************************************
CEditEx::~CEditEx()
{	
	if(m_Brush.m_hObject != NULL)
		m_Brush.DeleteObject();
	if(m_Font.m_hObject != NULL)
		m_Font.DeleteObject();
}

//**************************************************************************
BEGIN_MESSAGE_MAP(CEditEx, CEdit)
	ON_WM_CTLCOLOR_REFLECT()
	ON_WM_CREATE()
	ON_CONTROL_REFLECT(EN_CHANGE, OnEnChange)
	ON_WM_PAINT()
END_MESSAGE_MAP()


//**************************************************************************
HBRUSH CEditEx::CtlColor(CDC* pDC, UINT nCtlColor)
{	
	pDC->SetBkMode(TRANSPARENT);
	pDC->SetTextColor(m_ColorText);
	return m_Brush;
}

//**************************************************************************
BOOL CEditEx::PreCreateWindow(CREATESTRUCT& cs)
{
	if (!CEdit::PreCreateWindow(cs))
		return FALSE;

	cs.dwExStyle |= WS_EX_CLIENTEDGE;	
}

//**************************************************************************
int CEditEx::OnCreate(LPCREATESTRUCT lpCreateStruct)
{
	if (CEdit::OnCreate(lpCreateStruct) == -1)
		return -1;
	
	SetFont(&m_Font);
	return 0;
}

//**************************************************************************
BOOL CEditEx::CreateEditEx(const CRect& rect, CWnd* parent, const unsigned int& ID)
{
	BOOL result = Create(WS_VISIBLE|ES_AUTOHSCROLL, rect, parent, ID);
	SetMargins(5,5);
	return result;
}

//**************************************************************************
void CEditEx::SetColorBG(const COLORREF& color)
{	
	if(m_Brush.m_hObject != NULL)
		m_Brush.DeleteObject();
	
	m_Brush.CreateSolidBrush(color);
	Invalidate();
}

//**************************************************************************
void CEditEx::SetColorText(const COLORREF& color)
{
	m_ColorText = color;
	Invalidate();
}

//**************************************************************************
void CEditEx::SetEditExFont(const int& height, const int& weight, const CString& fontname)
{
	LOGFONT lf;
	memset(&lf, 0, sizeof(LOGFONT)); 
	lf.lfHeight = height;  
	lf.lfWeight = weight;
	lf.lfCharSet = RUSSIAN_CHARSET;
	strcpy(lf.lfFaceName, fontname);
	if(m_Font.m_hObject != NULL)
		m_Font.DeleteObject();
	VERIFY(m_Font.CreateFontIndirect(&lf)); 
	SetFont(&m_Font);
}

//**************************************************************************
void CEditEx::SetEditExFont(LOGFONT* logfont)
{
	if(m_Font.m_hObject != NULL)
		m_Font.DeleteObject();
	VERIFY(m_Font.CreateFontIndirect(logfont)); 
	SetFont(&m_Font);
}

//**************************************************************************
void CEditEx::OnEnChange()
{
  CEdit::Invalidate(TRUE);
	GetParent()->SendMessage( WM_EDITEX_CHANGE, (WPARAM)m_hWnd);
  
}

