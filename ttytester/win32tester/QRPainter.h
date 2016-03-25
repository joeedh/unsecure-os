#pragma once

#include "tty.h"

//Class for storing bitmap bits
class CBMBits
{
public:
    CBMBits(BITMAP bm, int cx, int cy);
    virtual ~CBMBits();

    operator const VOID *() const       { return m_bits;    }
    //For low-level access to bit data
    BYTE &operator [](const size_t ix);


private:
    CBMBits();
    BYTE *m_bits;
};

class CQRPainter
{
public:
    CQRPainter();
    CQRPainter(LPCSTR data);
    CQRPainter(const std::string &data);
    virtual ~CQRPainter();

    bool InitializeData(LPCSTR data);
    void PaintData(HWND hwnd, HDC hdc, const RECT &rc);

protected:
    bool InitializeQR();
    bool InitializeBitmap(HDC hdc);
    void SetBitmapBits(HDC hdc);
    void Cleanup();
	void initFont();

private:
    std::string m_data;
	unsigned char *font;
	unsigned short vgadata[VGA_WIDTH*VGA_HEIGHT];

	int cw, ch, fw, fh;
	int _d;
    HBITMAP m_hbm;
};

