// qrdemo.cpp : Defines the entry point for the application.
//

#include "stdafx.h"
#include "qrdemo.h"
#include "QRPainter.h"
#include "font.h"
#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <stddef.h>
#include "tty.h"

#define MAX_LOADSTRING 100
// Global Variables:
HINSTANCE hInst;								// current instance
TCHAR szTitle[MAX_LOADSTRING];					// The title bar text
TCHAR szWindowClass[MAX_LOADSTRING];			// the main window class name

CQRPainter g_qrPainter("qrdemo");

// Forward declarations of functions included in this code module:
ATOM				MyRegisterClass(HINSTANCE hInstance);
BOOL				InitInstance(HINSTANCE, int);
LRESULT CALLBACK	WndProc(HWND, UINT, WPARAM, LPARAM);
INT_PTR CALLBACK	About(HWND, UINT, WPARAM, LPARAM);

int APIENTRY WinMain(_In_ HINSTANCE hInstance,
                     _In_opt_ HINSTANCE hPrevInstance,
                     _In_ LPSTR     lpCmdLine,
                     _In_ int       nCmdShow)
{
	UNREFERENCED_PARAMETER(hPrevInstance);
	UNREFERENCED_PARAMETER(lpCmdLine);
	
	MSG msg;
	HACCEL hAccelTable;

	// Initialize global strings
	LoadString(hInstance, IDS_APP_TITLE, szTitle, MAX_LOADSTRING);
	LoadString(hInstance, IDC_QRDEMO, szWindowClass, MAX_LOADSTRING);
	MyRegisterClass(hInstance);

    if (lpCmdLine && *lpCmdLine)
        g_qrPainter.InitializeData(lpCmdLine);

	// Perform application initialization:
	if (!InitInstance (hInstance, nCmdShow))
	{
		return FALSE;
	}

	hAccelTable = LoadAccelerators(hInstance, MAKEINTRESOURCE(IDC_QRDEMO));

	// Main message loop:
	while (GetMessage(&msg, NULL, 0, 0))
	{
		if (!TranslateAccelerator(msg.hwnd, hAccelTable, &msg))
		{
			TranslateMessage(&msg);
			DispatchMessage(&msg);
		}
	}

	return (int) msg.wParam;
}



//
//  FUNCTION: MyRegisterClass()
//
//  PURPOSE: Registers the window class.
//
ATOM MyRegisterClass(HINSTANCE hInstance)
{
	WNDCLASSEX wcex;

	wcex.cbSize = sizeof(WNDCLASSEX);

	wcex.style			= CS_HREDRAW | CS_VREDRAW;
	wcex.lpfnWndProc	= WndProc;
	wcex.cbClsExtra		= 0;
	wcex.cbWndExtra		= 0;
	wcex.hInstance		= hInstance;
	wcex.hIcon			= LoadIcon(hInstance, MAKEINTRESOURCE(IDI_QRDEMO));
	wcex.hCursor		= LoadCursor(NULL, IDC_ARROW);
	wcex.hbrBackground	= (HBRUSH)(COLOR_WINDOW+1);
	wcex.lpszMenuName	= MAKEINTRESOURCE(IDC_QRDEMO);
	wcex.lpszClassName	= szWindowClass;
	wcex.hIconSm		= LoadIcon(wcex.hInstance, MAKEINTRESOURCE(IDI_SMALL));

	return RegisterClassEx(&wcex);
}

//
//   FUNCTION: InitInstance(HINSTANCE, int)
//
//   PURPOSE: Saves instance handle and creates main window
//
//   COMMENTS:
//
//        In this function, we save the instance handle in a global variable and
//        create and display the main program window.
//
BOOL InitInstance(HINSTANCE hInstance, int nCmdShow)
{
   HWND hWnd;

   hInst = hInstance; // Store instance handle in our global variable

   hWnd = CreateWindow(szWindowClass, szTitle, WS_OVERLAPPEDWINDOW,
      CW_USEDEFAULT, 0, CW_USEDEFAULT, 0, NULL, NULL, hInstance, NULL);

   if (!hWnd)
   {
      return FALSE;
   }

   uintptr_t timerid = SetTimer(hWnd, 0, 65, NULL);

   ShowWindow(hWnd, nCmdShow);
   UpdateWindow(hWnd);

   return TRUE;
}

//
//  FUNCTION: WndProc(HWND, UINT, WPARAM, LPARAM)
//
//  PURPOSE:  Processes messages for the main window.
//
//  WM_COMMAND	- process the application menu
//  WM_PAINT	- Paint the main window
//  WM_DESTROY	- post a quit message and return
//
//
LRESULT CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	int wmId, wmEvent;
	PAINTSTRUCT ps;
	HDC hdc;

	switch (message)
	{
	case WM_CHAR: {
		int chr = wParam;

		if (chr == '\r')
			chr = '\n';

		terminal_putchar(chr);

		if (chr == '\n') {
			terminal_putchar('>');
			terminal_putchar(' ');
		}
		terminal_flush();

		break;
	}
	case WM_KEYDOWN:
		switch (wParam) { 
			case VK_LEFT: 
				terminal_putchar(27);
				terminal_putchar('[');
				terminal_putchar('D');
				terminal_flush();
				break; 
			case VK_RIGHT: 
				terminal_putchar(27);
				terminal_putchar('[');
				terminal_putchar('C');
				terminal_flush();
				break; 
			case VK_UP: 
				break; 
			case VK_DOWN: 
				break; 
			case VK_HOME: 
				terminal_putchar(27);
				terminal_putchar('[');
				terminal_putchar('3');
				terminal_putchar('5');
				terminal_putchar('m');
				terminal_putchar('l');
				terminal_flush();
				break; 
			case VK_END: 
				terminal_putchar(27);
				terminal_putchar('[');
				terminal_putchar('?');
				terminal_putchar('2');
				terminal_putchar('5');
				terminal_putchar('h');
				terminal_flush();
				break; 
			case VK_INSERT: 
				break; 
			case VK_DELETE: 
				break; 
			case VK_PRIOR: //page up
				terminal_putchar(27);
				terminal_putchar('[');
				terminal_putchar(15);
				terminal_putchar('S');
				terminal_flush();
				break;
			case VK_NEXT: //page down
				terminal_putchar(27);
				terminal_putchar('[');
				terminal_putchar(15);
				terminal_putchar('T');
				terminal_flush();
				break;

	        default: 
	            break; 
        } 

		break;
	case WM_COMMAND:
		wmId    = LOWORD(wParam);
		wmEvent = HIWORD(wParam);
		// Parse the menu selections:
		switch (wmId)
		{
		case IDM_ABOUT:
			DialogBox(hInst, MAKEINTRESOURCE(IDD_ABOUTBOX), hWnd, About);
			break;
		case IDM_EXIT:
			DestroyWindow(hWnd);
			break;
		default:
			return DefWindowProc(hWnd, message, wParam, lParam);
		}
		break;
	case WM_TIMER:
		RedrawWindow(hWnd, NULL, NULL, RDW_INTERNALPAINT|RDW_INVALIDATE);
		UpdateWindow(hWnd);
		//hdc = BeginPaint(hWnd, &ps);
        //g_qrPainter.PaintData(hWnd, hdc, ps.rcPaint);
		//EndPaint(hWnd, &ps);
		break;
	case WM_PAINT:
		hdc = BeginPaint(hWnd, &ps);
        g_qrPainter.PaintData(hWnd, hdc, ps.rcPaint);
		EndPaint(hWnd, &ps);
		break;
	case WM_DESTROY:
		PostQuitMessage(0);
		break;
	default:
		return DefWindowProc(hWnd, message, wParam, lParam);
	}
	return 0;
}

// Message handler for about box.
INT_PTR CALLBACK About(HWND hDlg, UINT message, WPARAM wParam, LPARAM lParam)
{
	UNREFERENCED_PARAMETER(lParam);
	switch (message)
	{
	case WM_INITDIALOG:
		return (INT_PTR)TRUE;

	case WM_COMMAND:
		if (LOWORD(wParam) == IDOK || LOWORD(wParam) == IDCANCEL)
		{
			EndDialog(hDlg, LOWORD(wParam));
			return (INT_PTR)TRUE;
		}
		break;
	}
	return (INT_PTR)FALSE;
}
