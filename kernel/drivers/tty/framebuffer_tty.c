#include "tty.h"
#include "framebuffer_tty.h"
#include "../framebuffer/framebuffer.h"
#include "../../libc/libk.h"
#include "../../libc/kmalloc.h"

//this is a framebuffer tty, in kernel space
//apparently this is how linux does it?

#define FWIDTH 180
#define FHEIGHT 180
#define CHAR_OFFSET 31
#define CELLWID 10
#define CELLHGT 15

static void gen_font_bitmap();

static FbTTY the_tty;
unsigned char font_locs[8454];
static unsigned short textarray[512*512];
static unsigned char decoded_font[FWIDTH*FHEIGHT];
static char cursor[512] = {255};

static unsigned char vgacolors[][3] = {
	{0, 0, 0},
	{255, 0, 0},
	{0, 255, 0},
	{255, 255, 0},
	{0, 0, 255},
	{255, 0, 255},
	{55, 180, 220},
	{200, 200, 200},
	{80, 80, 80},
	{255, 100, 80},
	{0, 0, 0},
	{0, 0, 0},
	{0, 0, 0},
	{0, 0, 0},
	{0, 0, 0},
	{255, 255, 255},
	{0, 0, 0},
	{0, 0, 0}
};

void tty_fb_init(int width, int height) {
  memset(textarray, 0, sizeof(textarray));
  memset(&the_tty, 0, sizeof(the_tty));
  memset(&cursor, 255, sizeof(cursor));
  
  framebuffer_get_info(&the_tty.scrsizex, &the_tty.scrsizey, &the_tty.scrdepth);
  
  the_tty.backbuffer = kmalloc(the_tty.scrsizex*the_tty.scrsizey*4);
  
  gen_font_bitmap();
  
  the_tty.textarray = textarray;
  the_tty.font = decoded_font;
  
  the_tty.cols = width;
  the_tty.rows = height;
  
  the_tty.cellx = CELLWID;
  the_tty.celly = CELLHGT;
}

unsigned short *tty_fb_get_textarray() {
  return the_tty.textarray;
}

static void gen_font_bitmap() {
	int w = FWIDTH, h = FHEIGHT;
	unsigned char *image = (unsigned char*)decoded_font;

	memset(image, 0, w*h);

	int tot = sizeof(font_locs);
	for (int i=0; i<tot; i += 2) {
		int x = font_locs[i], y = font_locs[i+1];

		image[y*w + x] = 255;
	}

	return;
}

void tty_fb_setcursor(int x, int y) {
  the_tty.cursorx = x;
  the_tty.cursory = y;
}

void tty_fb_render() {
  unsigned char *buf = the_tty.backbuffer;
  int scrwidth = the_tty.scrsizex;
  int chrwid = FWIDTH/CELLWID;
  
  for (int i=0; i<the_tty.rows; i++) {
    for (int j=0; j<the_tty.cols; j++) {
      int x = the_tty.cellx*j, y = the_tty.celly*i;
      int fx, fy;
      
      unsigned short code = the_tty.textarray[i*the_tty.cols + j];
      unsigned short e =  code & 127;
      unsigned char *fg = vgacolors[(code>>8) & 15];
      unsigned char *bg = vgacolors[(code>>12) & 15];
     
      //e = (c++) & 127;
      
      int chr = e - CHAR_OFFSET;
      if (chr < 0 || chr > 127) {
        continue;
      }
      
      fx = (chr % chrwid) * the_tty.cellx;
      fy = (chr / chrwid) * the_tty.celly;
      
      for (int x2=0; x2<CELLWID; x2++) {
        for (int y2=0; y2<CELLHGT; y2++) {
          int src = ((y2 + fy)*FWIDTH + x2 + fx);
          int dst = ((y+y2)*scrwidth + x + x2)<<2;
          
          int mask = decoded_font[src];
          
          buf[dst  ] = mask ? fg[0] : bg[0];
          buf[dst+1] = mask ? fg[1] : bg[1];
          buf[dst+2] = mask ? fg[2] : bg[2];
          buf[dst+3] = mask ? fg[3] : bg[3];
        }
      }
    }
  }
  
  int x = the_tty.cursorx*CELLWID, y = the_tty.cursory*CELLHGT + CELLHGT-3;
  
  //cursor
  //framebuffer_blit(cursor, 0, 0, CELLWID, 2, BW, x, y, CELLWID, 2);
  for (int j=0; j<2; j++) {
    for (int i=0; i<CELLWID; i++) {
      int x2 = x+i, y2 = y+j;
      int idx = (y2*the_tty.scrsizex + x2)*4;
      
      the_tty.backbuffer[idx] = 200; //color[0];
      the_tty.backbuffer[idx+1] = 200; //color[1];
      the_tty.backbuffer[idx+2] = 200; //color[2];
      the_tty.backbuffer[idx+3] = 200; //color[3];
    }
  }
}

void tty_fb_flip() {
  e9printf("tty framebuffer flip!\n");
  
  framebuffer_lock();
  tty_fb_render();
  framebuffer_blit(the_tty.backbuffer, 0, 0, the_tty.scrsizex, the_tty.scrsizey, RGBA, 0, 0, the_tty.scrsizex, the_tty.scrsizey);
  framebuffer_unlock();
  
  return;
  
  unsigned int state = safe_entry();
  
  //framebuffer_blit(decoded_font, 0, 0, FWIDTH, FHEIGHT, BW, 0, 0, FWIDTH, FHEIGHT);
  
  int chrwid = FWIDTH/CELLWID;
  
  for (int i=0; i<the_tty.rows; i++) {
    for (int j=0; j<the_tty.cols; j++) {
      int x = the_tty.cellx*j, y = the_tty.celly*i;
      int fx, fy;
      
      short e = the_tty.textarray[i*the_tty.cols + j] & 127;
      //e = (c++) & 127;
      
      int chr = e - CHAR_OFFSET;
      if (chr < 0 || chr > 127) {
        continue;
      }
      
      fx = (chr % chrwid) * the_tty.cellx;
      fy = (chr / chrwid) * the_tty.celly;
      
      framebuffer_blit(decoded_font, fx, fy, FWIDTH, FHEIGHT, BW, x, y, CELLWID, CELLHGT); //the_tty.cellx, the_tty.celly);
    }
  }
  
  int x = the_tty.cursorx*CELLWID, y = the_tty.cursory*CELLHGT + CELLHGT-3;
  
  //cursor
  framebuffer_blit(cursor, 0, 0, CELLWID, 2, BW, x, y, CELLWID, 2);
  
  framebuffer_flip();
  
  safe_exit(state);
  framebuffer_unlock();
}

//x/y locations for each white pixel in image.  everything else is black.
unsigned char font_locs[8454] = {
25,2,26,2,33,2,34,2,35,2,36,2,37,2,44,2,45,2,46,2,55,2,63,2,64,2,65,2,84,2,85,2,86,2,96,2,97,2,103,2,
104,2,115,2,166,2,167,2,174,2,175,2,176,2,25,3,33,3,34,3,36,3,37,3,44,3,45,3,46,3,54,3,55,3,56,3,57,3,63,3,
65,3,66,3,84,3,85,3,86,3,96,3,104,3,113,3,115,3,117,3,125,3,166,3,167,3,173,3,174,3,176,3,177,3,25,4,34,4,36,4,
37,4,44,4,45,4,46,4,53,4,54,4,63,4,64,4,65,4,74,4,75,4,76,4,77,4,85,4,86,4,95,4,96,4,104,4,105,4,113,4,
114,4,115,4,116,4,117,4,125,4,165,4,166,4,173,4,177,4,25,5,43,5,44,5,45,5,46,5,47,5,48,5,53,5,54,5,65,5,66,5,
67,5,74,5,85,5,95,5,96,5,104,5,105,5,114,5,115,5,116,5,125,5,165,5,166,5,173,5,177,5,25,6,44,6,45,6,46,6,54,6,
55,6,56,6,57,6,63,6,64,6,65,6,74,6,75,6,95,6,96,6,104,6,105,6,114,6,116,6,117,6,122,6,123,6,124,6,125,6,126,6,
127,6,128,6,143,6,144,6,145,6,146,6,147,6,148,6,165,6,173,6,177,6,43,7,44,7,45,7,46,7,47,7,53,7,57,7,65,7,66,7,
67,7,73,7,74,7,75,7,76,7,77,7,95,7,96,7,104,7,105,7,125,7,164,7,165,7,173,7,177,7,44,8,45,8,46,8,53,8,54,8,
55,8,56,8,57,8,64,8,65,8,67,8,73,8,74,8,75,8,76,8,77,8,95,8,96,8,104,8,105,8,125,8,134,8,135,8,154,8,155,8,
156,8,164,8,173,8,174,8,177,8,24,9,25,9,26,9,44,9,45,9,46,9,55,9,65,9,66,9,67,9,74,9,75,9,76,9,77,9,95,9,
96,9,104,9,105,9,125,9,134,9,135,9,154,9,155,9,156,9,163,9,164,9,174,9,175,9,176,9,177,9,44,10,45,10,46,10,55,10,96,10,
104,10,134,10,135,10,163,10,96,11,97,11,103,11,104,11,133,11,134,11,154,16,155,16,156,16,4,17,5,17,14,17,15,17,16,17,17,17,24,17,
25,17,26,17,27,17,35,17,36,17,43,17,44,17,45,17,46,17,47,17,55,17,56,17,57,17,58,17,63,17,64,17,65,17,66,17,67,17,74,17,
75,17,76,17,84,17,85,17,86,17,153,17,154,17,156,17,157,17,163,17,164,17,165,17,166,17,172,17,173,17,174,17,175,17,176,17,177,17,3,18,
4,18,5,18,13,18,14,18,16,18,17,18,23,18,24,18,26,18,27,18,35,18,36,18,43,18,44,18,54,18,55,18,63,18,67,18,73,18,74,18,
76,18,77,18,83,18,84,18,86,18,87,18,117,18,118,18,133,18,134,18,144,18,145,18,146,18,147,18,153,18,154,18,157,18,164,18,165,18,166,18,
173,18,174,18,177,18,5,19,17,19,26,19,27,19,34,19,35,19,36,19,43,19,44,19,53,19,54,19,66,19,67,19,73,19,74,19,77,19,83,19,
84,19,87,19,94,19,95,19,96,19,104,19,105,19,106,19,115,19,116,19,117,19,134,19,135,19,143,19,144,19,146,19,147,19,153,19,155,19,156,19,
157,19,164,19,166,19,173,19,174,19,177,19,5,20,16,20,17,20,25,20,26,20,34,20,36,20,43,20,44,20,45,20,46,20,47,20,53,20,54,20,
55,20,56,20,57,20,66,20,74,20,75,20,76,20,77,20,83,20,84,20,86,20,87,20,88,20,94,20,95,20,96,20,104,20,105,20,106,20,114,20,
115,20,122,20,123,20,124,20,125,20,126,20,127,20,128,20,135,20,136,20,137,20,147,20,153,20,154,20,155,20,157,20,164,20,166,20,167,20,173,20,
174,20,175,20,176,20,177,20,5,21,15,21,16,21,26,21,27,21,33,21,34,21,36,21,47,21,53,21,54,21,57,21,66,21,73,21,74,21,77,21,
84,21,85,21,86,21,87,21,88,21,112,21,113,21,114,21,137,21,138,21,146,21,147,21,153,21,154,21,155,21,157,21,163,21,164,21,166,21,167,21,
173,21,174,21,177,21,178,21,5,22,14,22,15,22,27,22,33,22,34,22,35,22,36,22,37,22,47,22,53,22,54,22,57,22,58,22,65,22,66,22,
73,22,77,22,87,22,114,22,122,22,123,22,124,22,125,22,126,22,127,22,128,22,136,22,137,22,145,22,146,22,153,22,155,22,156,22,157,22,163,22,
164,22,165,22,166,22,167,22,173,22,174,22,177,22,178,22,5,23,13,23,14,23,23,23,24,23,26,23,27,23,36,23,43,23,44,23,47,23,54,23,
57,23,65,23,66,23,73,23,77,23,86,23,87,23,94,23,95,23,96,23,104,23,105,23,106,23,114,23,115,23,116,23,134,23,135,23,136,23,153,23,
154,23,163,23,167,23,168,23,173,23,174,23,177,23,178,23,3,24,4,24,5,24,6,24,7,24,13,24,14,24,15,24,16,24,17,24,24,24,25,24,
26,24,27,24,35,24,36,24,37,24,44,24,45,24,46,24,47,24,54,24,55,24,56,24,57,24,65,24,73,24,74,24,75,24,76,24,77,24,83,24,
84,24,85,24,86,24,94,24,95,24,96,24,104,24,105,24,116,24,117,24,118,24,133,24,134,24,144,24,145,24,146,24,153,24,154,24,156,24,157,24,
162,24,163,24,164,24,166,24,167,24,168,24,169,24,172,24,173,24,174,24,175,24,176,24,177,24,103,25,104,25,154,25,155,25,156,25,4,32,5,32,
6,32,7,32,8,32,12,32,13,32,14,32,15,32,16,32,17,32,22,32,23,32,24,32,25,32,26,32,27,32,33,32,34,32,35,32,36,32,37,32,
38,32,44,32,45,32,46,32,47,32,48,32,52,32,53,32,54,32,56,32,57,32,58,32,63,32,64,32,65,32,66,32,67,32,74,32,75,32,76,32,
77,32,78,32,82,32,83,32,84,32,85,32,87,32,88,32,89,32,92,32,93,32,94,32,95,32,96,32,102,32,103,32,107,32,108,32,112,32,113,32,
114,32,116,32,117,32,118,32,124,32,125,32,126,32,127,32,133,32,134,32,135,32,136,32,137,32,144,32,145,32,146,32,147,32,152,32,153,32,154,32,
155,32,156,32,164,32,165,32,166,32,167,32,168,32,172,32,173,32,174,32,175,32,176,32,177,32,178,32,3,33,4,33,7,33,8,33,13,33,14,33,
17,33,18,33,23,33,24,33,27,33,34,33,38,33,43,33,44,33,46,33,47,33,48,33,53,33,54,33,57,33,65,33,76,33,77,33,83,33,84,33,
87,33,88,33,94,33,102,33,103,33,104,33,106,33,107,33,108,33,113,33,114,33,117,33,123,33,124,33,126,33,127,33,134,33,137,33,138,33,143,33,
144,33,147,33,148,33,153,33,154,33,156,33,157,33,163,33,164,33,167,33,168,33,172,33,173,33,175,33,177,33,178,33,2,34,3,34,13,34,14,34,
17,34,18,34,23,34,24,34,25,34,26,34,34,34,36,34,42,34,43,34,53,34,54,34,57,34,65,34,76,34,77,34,83,34,84,34,86,34,87,34,
94,34,102,34,103,34,104,34,106,34,107,34,108,34,113,34,114,34,115,34,117,34,122,34,123,34,127,34,128,34,134,34,137,34,138,34,142,34,143,34,
147,34,148,34,153,34,154,34,157,34,163,34,164,34,175,34,2,35,3,35,13,35,14,35,18,35,23,35,24,35,25,35,26,35,34,35,35,35,36,35,
42,35,43,35,53,35,54,35,55,35,56,35,57,35,65,35,76,35,77,35,83,35,84,35,85,35,86,35,94,35,102,35,103,35,104,35,105,35,106,35,
107,35,108,35,113,35,115,35,117,35,122,35,123,35,127,35,128,35,134,35,137,35,138,35,142,35,143,35,148,35,153,35,154,35,156,35,157,35,164,35,
165,35,166,35,167,35,175,35,2,36,3,36,13,36,14,36,18,36,23,36,24,36,25,36,26,36,34,36,36,36,42,36,43,36,45,36,46,36,47,36,
48,36,53,36,54,36,57,36,65,36,73,36,76,36,77,36,83,36,84,36,85,36,86,36,94,36,102,36,103,36,104,36,105,36,106,36,107,36,108,36,
113,36,115,36,116,36,117,36,122,36,123,36,127,36,128,36,134,36,135,36,136,36,137,36,142,36,143,36,148,36,153,36,154,36,155,36,156,36,167,36,
175,36,2,37,3,37,13,37,14,37,17,37,18,37,23,37,24,37,34,37,42,37,43,37,47,37,48,37,53,37,54,37,57,37,65,37,73,37,76,37,
77,37,83,37,84,37,86,37,87,37,94,37,97,37,98,37,102,37,103,37,105,37,107,37,108,37,113,37,116,37,117,37,122,37,123,37,127,37,128,37,
134,37,142,37,143,37,147,37,148,37,153,37,154,37,156,37,157,37,167,37,168,37,175,37,3,38,4,38,7,38,8,38,13,38,14,38,17,38,18,38,
23,38,24,38,27,38,28,38,34,38,43,38,47,38,48,38,53,38,54,38,57,38,65,38,73,38,74,38,76,38,77,38,83,38,84,38,87,38,94,38,
97,38,98,38,102,38,103,38,107,38,108,38,113,38,116,38,117,38,123,38,124,38,126,38,127,38,134,38,143,38,144,38,147,38,153,38,154,38,157,38,
163,38,167,38,175,38,4,39,5,39,6,39,7,39,12,39,13,39,14,39,15,39,16,39,17,39,22,39,23,39,24,39,25,39,26,39,27,39,28,39,
33,39,34,39,35,39,36,39,43,39,44,39,45,39,46,39,47,39,52,39,53,39,54,39,56,39,57,39,58,39,63,39,64,39,65,39,66,39,67,39,
74,39,75,39,76,39,82,39,83,39,84,39,85,39,87,39,88,39,92,39,93,39,94,39,95,39,96,39,97,39,98,39,102,39,103,39,104,39,106,39,
107,39,108,39,109,39,112,39,113,39,114,39,115,39,117,39,124,39,125,39,126,39,127,39,133,39,134,39,135,39,136,39,144,39,145,39,146,39,147,39,
152,39,153,39,154,39,155,39,157,39,158,39,163,39,164,39,165,39,166,39,167,39,173,39,174,39,175,39,176,39,177,39,144,40,145,40,146,40,147,40,
148,40,143,41,144,41,146,41,147,41,148,41,2,47,3,47,4,47,5,47,6,47,7,47,8,47,11,47,12,47,13,47,14,47,16,47,17,47,18,47,
19,47,22,47,23,47,24,47,26,47,27,47,28,47,29,47,32,47,33,47,34,47,36,47,37,47,38,47,42,47,43,47,44,47,46,47,47,47,48,47,
53,47,54,47,55,47,56,47,57,47,65,47,66,47,67,47,73,47,83,47,84,47,85,47,114,47,115,47,132,47,133,47,156,47,157,47,175,47,176,47,
177,47,178,47,3,48,7,48,12,48,13,48,17,48,18,48,22,48,23,48,28,48,33,48,36,48,37,48,43,48,44,48,47,48,53,48,54,48,56,48,
57,48,65,48,73,48,74,48,85,48,94,48,95,48,96,48,115,48,116,48,133,48,157,48,174,48,175,48,3,49,7,49,13,49,17,49,22,49,23,49,
25,49,26,49,27,49,28,49,33,49,34,49,36,49,44,49,46,49,47,49,56,49,65,49,74,49,85,49,94,49,96,49,123,49,124,49,125,49,126,49,
133,49,134,49,135,49,136,49,137,49,144,49,145,49,146,49,147,49,148,49,153,49,154,49,155,49,156,49,157,49,163,49,164,49,165,49,166,49,167,49,
173,49,174,49,175,49,176,49,177,49,3,50,7,50,13,50,14,50,16,50,17,50,23,50,24,50,25,50,26,50,27,50,28,50,34,50,35,50,36,50,
44,50,45,50,46,50,55,50,56,50,65,50,74,50,75,50,85,50,93,50,94,50,96,50,97,50,123,50,126,50,127,50,133,50,134,50,137,50,138,50,
143,50,144,50,147,50,148,50,153,50,156,50,157,50,163,50,167,50,174,50,175,50,3,51,7,51,14,51,16,51,17,51,23,51,24,51,25,51,26,51,
27,51,28,51,34,51,35,51,36,51,45,51,54,51,55,51,65,51,75,51,85,51,123,51,124,51,125,51,126,51,127,51,133,51,137,51,138,51,143,51,
152,51,153,51,157,51,162,51,163,51,164,51,165,51,166,51,167,51,168,51,174,51,175,51,3,52,7,52,14,52,15,52,16,52,23,52,24,52,26,52,
27,52,28,52,33,52,34,52,36,52,45,52,54,52,65,52,75,52,76,52,85,52,123,52,126,52,127,52,133,52,137,52,138,52,143,52,152,52,153,52,
157,52,162,52,163,52,174,52,175,52,3,53,4,53,7,53,14,53,15,53,16,53,23,53,24,53,26,53,27,53,33,53,36,53,37,53,45,53,53,53,
54,53,57,53,65,53,75,53,76,53,85,53,123,53,126,53,127,53,133,53,134,53,137,53,138,53,143,53,144,53,147,53,148,53,153,53,156,53,157,53,
163,53,174,53,175,53,4,54,5,54,6,54,7,54,15,54,23,54,24,54,26,54,27,54,32,54,33,54,34,54,36,54,37,54,38,54,43,54,44,54,
45,54,46,54,47,54,53,54,54,54,55,54,56,54,57,54,65,54,76,54,77,54,85,54,123,54,124,54,125,54,126,54,127,54,128,54,132,54,133,54,
134,54,135,54,136,54,137,54,144,54,145,54,146,54,147,54,153,54,154,54,155,54,156,54,157,54,158,54,163,54,164,54,165,54,166,54,167,54,173,54,
174,54,175,54,176,54,177,54,65,55,76,55,77,55,85,55,65,56,66,56,67,56,83,56,84,56,85,56,102,57,103,57,104,57,105,57,106,57,107,57,
108,57,109,57,12,62,13,62,25,62,35,62,36,62,43,62,44,62,53,62,54,62,55,62,13,63,44,63,55,63,134,63,3,64,4,64,5,64,6,64,
7,64,8,64,13,64,14,64,15,64,16,64,17,64,23,64,24,64,25,64,33,64,34,64,35,64,36,64,44,64,46,64,47,64,48,64,55,64,62,64,
63,64,64,64,65,64,66,64,67,64,68,64,72,64,73,64,74,64,75,64,76,64,77,64,84,64,85,64,86,64,87,64,92,64,93,64,94,64,95,64,
96,64,97,64,103,64,104,64,105,64,106,64,107,64,108,64,113,64,114,64,115,64,116,64,117,64,124,64,125,64,126,64,127,64,132,64,133,64,134,64,
135,64,136,64,137,64,142,64,143,64,145,64,146,64,147,64,152,64,153,64,154,64,156,64,157,64,158,64,162,64,163,64,164,64,167,64,168,64,172,64,
173,64,174,64,176,64,177,64,178,64,3,65,6,65,7,65,13,65,14,65,16,65,17,65,25,65,36,65,44,65,46,65,47,65,55,65,63,65,65,65,
66,65,67,65,68,65,73,65,74,65,76,65,77,65,83,65,84,65,87,65,93,65,94,65,97,65,98,65,103,65,106,65,107,65,114,65,115,65,116,65,
117,65,118,65,123,65,124,65,126,65,127,65,134,65,143,65,147,65,153,65,157,65,162,65,163,65,167,65,168,65,173,65,174,65,176,65,177,65,2,66,
3,66,7,66,13,66,17,66,25,66,36,66,44,66,45,66,46,66,55,66,63,66,65,66,67,66,68,66,73,66,74,66,77,66,82,66,83,66,87,66,
88,66,93,66,97,66,98,66,102,66,103,66,107,66,114,66,115,66,123,66,124,66,125,66,126,66,127,66,134,66,143,66,147,66,153,66,154,66,156,66,
157,66,163,66,164,66,165,66,166,66,167,66,168,66,174,66,175,66,176,66,2,67,3,67,7,67,13,67,17,67,25,67,36,67,44,67,45,67,55,67,
63,67,65,67,67,67,68,67,73,67,74,67,77,67,82,67,83,67,87,67,88,67,93,67,97,67,98,67,102,67,103,67,107,67,114,67,115,67,127,67,
134,67,143,67,147,67,154,67,156,67,163,67,164,67,165,67,166,67,167,67,174,67,175,67,176,67,3,68,6,68,7,68,13,68,17,68,25,68,36,68,
44,68,45,68,46,68,55,68,63,68,65,68,67,68,68,68,73,68,74,68,77,68,83,68,87,68,93,68,94,68,97,68,98,68,103,68,106,68,107,68,
114,68,115,68,123,68,127,68,134,68,137,68,138,68,143,68,144,68,146,68,147,68,154,68,155,68,156,68,163,68,164,68,165,68,166,68,167,68,173,68,
174,68,176,68,177,68,3,69,4,69,5,69,6,69,7,69,12,69,13,69,14,69,16,69,17,69,18,69,23,69,24,69,25,69,26,69,27,69,28,69,
36,69,43,69,44,69,45,69,46,69,47,69,48,69,53,69,54,69,55,69,56,69,57,69,58,69,62,69,63,69,64,69,65,69,66,69,67,69,68,69,
69,69,72,69,73,69,74,69,76,69,77,69,78,69,83,69,84,69,85,69,86,69,87,69,93,69,94,69,95,69,96,69,97,69,103,69,104,69,105,69,
106,69,107,69,113,69,114,69,115,69,116,69,117,69,123,69,124,69,125,69,126,69,127,69,134,69,135,69,136,69,137,69,143,69,144,69,145,69,146,69,
147,69,148,69,155,69,163,69,164,69,166,69,167,69,172,69,173,69,174,69,176,69,177,69,178,69,7,70,36,70,93,70,107,70,3,71,4,71,5,71,
6,71,7,71,33,71,34,71,35,71,36,71,92,71,93,71,94,71,95,71,105,71,106,71,107,71,108,71,25,77,26,77,35,77,44,77,45,77,25,78,
35,78,45,78,2,79,3,79,4,79,6,79,7,79,8,79,13,79,14,79,15,79,16,79,17,79,25,79,35,79,45,79,3,80,4,80,7,80,8,80,
13,80,14,80,16,80,17,80,25,80,35,80,45,80,4,81,7,81,15,81,16,81,25,81,35,81,45,81,53,81,54,81,55,81,57,81,4,82,5,82,
6,82,7,82,14,82,15,82,24,82,25,82,35,82,45,82,46,82,53,82,55,82,56,82,57,82,4,83,5,83,6,83,13,83,14,83,17,83,25,83,
35,83,45,83,5,84,6,84,13,84,14,84,15,84,16,84,17,84,25,84,35,84,45,84,5,85,25,85,35,85,45,85,3,86,4,86,5,86,6,86,
25,86,26,86,44,86,45,86,64,107,65,107,66,107,81,107,82,107,83,107,87,107,88,107,89,107,95,107,104,107,105,107,106,107,107,107,108,107,113,107,
114,107,116,107,117,107,134,107,135,107,136,107,63,108,64,108,66,108,73,108,74,108,77,108,78,108,83,108,87,108,88,108,95,108,104,108,107,108,108,108,
123,108,124,108,125,108,126,108,127,108,136,108,173,108,174,108,175,108,176,108,177,108,44,109,45,109,46,109,55,109,56,109,63,109,64,109,66,109,67,109,
74,109,75,109,76,109,77,109,83,109,84,109,85,109,86,109,87,109,95,109,103,109,104,109,105,109,122,109,123,109,127,109,128,109,133,109,134,109,135,109,
136,109,172,109,173,109,174,109,175,109,176,109,177,109,178,109,54,110,55,110,56,110,57,110,64,110,73,110,74,110,76,110,77,110,83,110,84,110,85,110,
86,110,87,110,95,110,102,110,103,110,105,110,106,110,122,110,124,110,125,110,126,110,128,110,133,110,134,110,135,110,136,110,137,110,144,110,145,110,147,110,
148,110,172,110,174,110,175,110,176,110,178,110,179,110,53,111,54,111,56,111,57,111,62,111,63,111,64,111,65,111,66,111,73,111,74,111,76,111,77,111,
85,111,103,111,104,111,106,111,107,111,122,111,123,111,124,111,128,111,129,111,143,111,144,111,145,111,146,111,147,111,172,111,174,111,175,111,176,111,178,111,
179,111,45,112,53,112,54,112,57,112,64,112,74,112,75,112,76,112,77,112,83,112,84,112,85,112,86,112,87,112,104,112,105,112,107,112,108,112,122,112,
124,112,125,112,126,112,128,112,142,112,143,112,145,112,146,112,152,112,153,112,154,112,155,112,156,112,157,112,158,112,172,112,173,112,174,112,175,112,176,112,
177,112,178,112,179,112,45,113,54,113,55,113,56,113,57,113,64,113,67,113,68,113,73,113,74,113,77,113,78,113,85,113,95,113,105,113,106,113,107,113,
108,113,122,113,123,113,124,113,127,113,128,113,143,113,144,113,145,113,146,113,147,113,157,113,158,113,172,113,173,113,177,113,178,113,45,114,55,114,56,114,
62,114,63,114,64,114,65,114,66,114,67,114,84,114,85,114,86,114,87,114,95,114,103,114,106,114,107,114,123,114,124,114,125,114,126,114,127,114,144,114,
145,114,147,114,148,114,157,114,158,114,173,114,174,114,175,114,176,114,177,114,45,115,95,115,103,115,104,115,105,115,106,115,107,115,45,116,46,116,95,116,
174,119,174,120,175,120,1,121,2,121,3,121,4,121,5,121,6,121,7,121,8,121,9,121,14,121,15,121,16,121,14,122,16,122,17,122,34,122,35,122,
36,122,44,122,45,122,46,122,55,122,56,122,73,122,74,122,75,122,76,122,77,122,78,122,104,122,105,122,114,122,115,122,116,122,132,122,133,122,142,122,
143,122,152,122,153,122,154,122,155,122,173,122,174,122,175,122,176,122,14,123,15,123,16,123,25,123,34,123,36,123,45,123,46,123,54,123,55,123,73,123,
74,123,75,123,76,123,77,123,105,123,113,123,114,123,116,123,117,123,133,123,143,123,148,123,153,123,154,123,158,123,159,123,174,123,175,123,176,123,25,124,
34,124,35,124,36,124,46,124,62,124,63,124,64,124,65,124,66,124,67,124,72,124,73,124,75,124,76,124,77,124,105,124,113,124,114,124,116,124,117,124,
133,124,137,124,138,124,143,124,147,124,148,124,154,124,155,124,157,124,158,124,164,124,165,124,166,124,174,124,176,124,25,125,34,125,35,125,36,125,44,125,
45,125,46,125,63,125,64,125,67,125,73,125,74,125,75,125,76,125,77,125,104,125,105,125,106,125,114,125,115,125,116,125,122,125,123,125,125,125,126,125,
132,125,133,125,134,125,136,125,137,125,142,125,143,125,144,125,145,125,146,125,147,125,152,125,153,125,154,125,155,125,156,125,157,125,174,125,176,125,177,125,
22,126,23,126,24,126,25,126,26,126,27,126,28,126,63,126,64,126,67,126,73,126,74,126,75,126,76,126,77,126,86,126,87,126,123,126,124,126,126,126,
127,126,135,126,136,126,137,126,138,126,144,126,145,126,146,126,147,126,148,126,155,126,156,126,157,126,158,126,173,126,174,126,176,126,177,126,25,127,63,127,
64,127,67,127,75,127,76,127,77,127,124,127,125,127,127,127,128,127,134,127,135,127,137,127,138,127,143,127,144,127,146,127,148,127,149,127,153,127,154,127,
155,127,157,127,158,127,165,127,173,127,174,127,175,127,176,127,177,127,25,128,63,128,64,128,66,128,67,128,75,128,76,128,77,128,123,128,124,128,126,128,
127,128,133,128,134,128,136,128,137,128,138,128,139,128,147,128,148,128,153,128,156,128,157,128,158,128,159,128,164,128,165,128,173,128,177,128,178,128,22,129,
23,129,24,129,25,129,26,129,27,129,28,129,63,129,64,129,65,129,66,129,67,129,68,129,75,129,76,129,77,129,95,129,122,129,123,129,125,129,126,129,
137,129,138,129,139,129,146,129,147,129,148,129,149,129,156,129,157,129,158,129,159,129,163,129,164,129,172,129,173,129,174,129,176,129,177,129,178,129,179,129,
63,130,64,130,74,130,75,130,76,130,77,130,78,130,95,130,96,130,163,130,164,130,166,130,167,130,63,131,64,131,94,131,95,131,96,131,164,131,165,131,
166,131,44,133,45,133,46,133,6,134,15,134,16,134,23,134,24,134,25,134,26,134,44,134,45,134,46,134,75,134,86,134,95,134,96,134,115,134,126,134,
135,134,136,134,164,134,165,134,166,134,167,134,174,134,5,135,6,135,14,135,15,135,16,135,17,135,23,135,24,135,25,135,26,135,33,135,34,135,36,135,
37,135,44,135,45,135,46,135,75,135,76,135,85,135,86,135,94,135,95,135,96,135,97,135,103,135,104,135,106,135,107,135,115,135,116,135,125,135,126,135,
134,135,135,135,136,135,137,135,143,135,144,135,146,135,147,135,164,135,165,135,166,135,167,135,174,135,175,135,3,137,4,137,5,137,6,137,13,137,14,137,
15,137,16,137,23,137,24,137,25,137,26,137,33,137,34,137,35,137,36,137,43,137,44,137,45,137,46,137,53,137,54,137,55,137,56,137,57,137,58,137,
64,137,65,137,66,137,67,137,68,137,72,137,73,137,74,137,75,137,76,137,77,137,82,137,83,137,84,137,85,137,86,137,87,137,92,137,93,137,94,137,
95,137,96,137,97,137,102,137,103,137,104,137,105,137,106,137,107,137,113,137,114,137,115,137,116,137,117,137,123,137,124,137,125,137,126,137,127,137,133,137,
134,137,135,137,136,137,137,137,143,137,144,137,145,137,146,137,147,137,152,137,153,137,154,137,155,137,156,137,162,137,163,137,164,137,166,137,167,137,168,137,
174,137,175,137,176,137,177,137,4,138,5,138,6,138,14,138,15,138,16,138,24,138,25,138,26,138,34,138,35,138,36,138,44,138,45,138,46,138,54,138,
55,138,56,138,58,138,63,138,64,138,67,138,68,138,73,138,74,138,77,138,83,138,84,138,87,138,93,138,94,138,97,138,103,138,104,138,107,138,115,138,
125,138,135,138,145,138,153,138,156,138,157,138,163,138,164,138,167,138,173,138,174,138,176,138,177,138,4,139,6,139,14,139,16,139,24,139,26,139,34,139,
36,139,44,139,46,139,54,139,55,139,56,139,62,139,63,139,73,139,74,139,75,139,76,139,83,139,84,139,85,139,86,139,93,139,94,139,95,139,96,139,
103,139,104,139,105,139,106,139,115,139,125,139,135,139,145,139,153,139,157,139,158,139,163,139,164,139,165,139,167,139,172,139,173,139,177,139,178,139,4,140,
6,140,7,140,14,140,16,140,17,140,24,140,26,140,27,140,34,140,36,140,37,140,44,140,46,140,47,140,53,140,55,140,56,140,57,140,62,140,63,140,
73,140,74,140,75,140,76,140,83,140,84,140,85,140,86,140,93,140,94,140,95,140,96,140,103,140,104,140,105,140,106,140,115,140,125,140,135,140,145,140,
152,140,153,140,154,140,155,140,157,140,158,140,163,140,165,140,167,140,172,140,173,140,177,140,178,140,3,141,4,141,6,141,7,141,13,141,14,141,16,141,
17,141,23,141,24,141,26,141,27,141,33,141,34,141,36,141,37,141,43,141,44,141,46,141,47,141,53,141,54,141,55,141,56,141,62,141,63,141,73,141,
74,141,75,141,76,141,83,141,84,141,85,141,86,141,93,141,94,141,95,141,96,141,103,141,104,141,105,141,106,141,115,141,125,141,135,141,145,141,153,141,
157,141,158,141,163,141,165,141,166,141,167,141,172,141,173,141,177,141,178,141,3,142,4,142,5,142,6,142,7,142,13,142,14,142,15,142,16,142,17,142,
23,142,24,142,25,142,26,142,27,142,33,142,34,142,35,142,36,142,37,142,43,142,44,142,45,142,46,142,47,142,53,142,55,142,56,142,62,142,63,142,
73,142,74,142,83,142,84,142,93,142,94,142,103,142,104,142,115,142,125,142,135,142,145,142,153,142,157,142,158,142,163,142,166,142,167,142,172,142,173,142,
177,142,178,142,3,143,7,143,8,143,13,143,17,143,18,143,23,143,27,143,28,143,33,143,37,143,38,143,43,143,47,143,48,143,53,143,55,143,56,143,
58,143,63,143,64,143,67,143,68,143,73,143,74,143,77,143,78,143,83,143,84,143,87,143,88,143,93,143,94,143,97,143,98,143,103,143,104,143,107,143,
108,143,115,143,125,143,135,143,145,143,153,143,156,143,157,143,163,143,166,143,167,143,173,143,174,143,176,143,177,143,2,144,3,144,4,144,6,144,7,144,
8,144,9,144,12,144,13,144,14,144,16,144,17,144,18,144,19,144,22,144,23,144,24,144,26,144,27,144,28,144,29,144,32,144,33,144,34,144,36,144,
37,144,38,144,39,144,42,144,43,144,44,144,46,144,47,144,48,144,49,144,52,144,53,144,54,144,55,144,56,144,57,144,58,144,64,144,65,144,66,144,
67,144,72,144,73,144,74,144,75,144,76,144,77,144,78,144,82,144,83,144,84,144,85,144,86,144,87,144,88,144,92,144,93,144,94,144,95,144,96,144,
97,144,98,144,102,144,103,144,104,144,105,144,106,144,107,144,108,144,113,144,114,144,115,144,116,144,117,144,123,144,124,144,125,144,126,144,127,144,133,144,
134,144,135,144,136,144,137,144,143,144,144,144,145,144,146,144,147,144,152,144,153,144,154,144,155,144,156,144,162,144,163,144,164,144,165,144,167,144,174,144,
175,144,176,144,177,144,65,145,65,146,66,146,64,147,65,147,66,147,5,149,6,149,15,149,16,149,24,149,25,149,26,149,27,149,64,149,76,149,85,149,
86,149,106,149,4,150,5,150,14,150,15,150,16,150,17,150,23,150,24,150,25,150,26,150,27,150,34,150,35,150,36,150,37,150,64,150,65,150,75,150,
76,150,84,150,85,150,86,150,87,150,93,150,94,150,96,150,97,150,105,150,106,150,135,151,146,151,155,151,156,151,164,151,165,151,166,151,167,151,4,152,
5,152,6,152,7,152,14,152,15,152,16,152,17,152,24,152,25,152,26,152,27,152,34,152,35,152,36,152,37,152,54,152,55,152,56,152,57,152,62,152,
63,152,64,152,65,152,66,152,67,152,68,152,72,152,73,152,74,152,75,152,76,152,77,152,78,152,82,152,83,152,84,152,85,152,86,152,87,152,88,152,
92,152,93,152,94,152,95,152,96,152,97,152,98,152,102,152,103,152,104,152,106,152,107,152,108,152,113,152,114,152,115,152,116,152,123,152,124,152,125,152,
126,152,135,152,136,152,145,152,146,152,154,152,155,152,156,152,157,152,164,152,165,152,166,152,167,152,173,152,174,152,176,152,177,152,3,153,4,153,6,153,
7,153,13,153,14,153,16,153,17,153,23,153,24,153,26,153,27,153,33,153,34,153,36,153,37,153,53,153,54,153,57,153,58,153,63,153,67,153,73,153,
77,153,83,153,87,153,93,153,97,153,103,153,104,153,107,153,114,153,123,153,124,153,126,153,2,154,3,154,7,154,8,154,12,154,13,154,17,154,18,154,
22,154,23,154,27,154,28,154,32,154,33,154,37,154,38,154,43,154,44,154,46,154,47,154,52,154,53,154,56,154,57,154,58,154,63,154,67,154,73,154,
77,154,83,154,87,154,93,154,97,154,104,154,106,154,107,154,114,154,115,154,116,154,117,154,123,154,124,154,126,154,133,154,134,154,135,154,136,154,143,154,
144,154,145,154,146,154,153,154,154,154,155,154,156,154,163,154,164,154,165,154,166,154,173,154,174,154,175,154,176,154,2,155,3,155,7,155,8,155,12,155,
13,155,17,155,18,155,22,155,23,155,27,155,28,155,32,155,33,155,37,155,38,155,44,155,45,155,46,155,52,155,53,155,56,155,57,155,58,155,63,155,
67,155,73,155,77,155,83,155,87,155,93,155,97,155,104,155,105,155,106,155,114,155,117,155,118,155,123,155,124,155,125,155,126,155,133,155,136,155,137,155,
143,155,146,155,147,155,153,155,156,155,157,155,163,155,166,155,167,155,173,155,176,155,177,155,2,156,3,156,7,156,8,156,12,156,13,156,17,156,18,156,
22,156,23,156,27,156,28,156,32,156,33,156,37,156,38,156,44,156,45,156,46,156,52,156,53,156,55,156,56,156,58,156,63,156,67,156,73,156,77,156,
83,156,87,156,93,156,97,156,105,156,114,156,117,156,118,156,123,156,124,156,126,156,127,156,133,156,134,156,135,156,136,156,137,156,143,156,144,156,145,156,
146,156,147,156,153,156,154,156,155,156,156,156,157,156,163,156,164,156,165,156,166,156,167,156,173,156,174,156,175,156,176,156,177,156,2,157,3,157,7,157,
8,157,12,157,13,157,17,157,18,157,22,157,23,157,27,157,28,157,32,157,33,157,37,157,38,157,43,157,44,157,46,157,47,157,52,157,53,157,54,157,
55,157,57,157,58,157,63,157,67,157,73,157,77,157,83,157,87,157,93,157,97,157,105,157,114,157,115,157,116,157,117,157,123,157,124,157,127,157,133,157,
136,157,137,157,143,157,146,157,147,157,153,157,156,157,157,157,163,157,166,157,167,157,173,157,176,157,177,157,3,158,4,158,6,158,7,158,13,158,14,158,
16,158,17,158,23,158,24,158,26,158,27,158,33,158,34,158,36,158,37,158,53,158,54,158,57,158,63,158,64,158,67,158,73,158,74,158,77,158,83,158,
84,158,87,158,93,158,94,158,97,158,105,158,114,158,123,158,124,158,125,158,127,158,133,158,136,158,137,158,143,158,146,158,147,158,153,158,156,158,157,158,
163,158,166,158,167,158,173,158,176,158,177,158,4,159,5,159,6,159,7,159,14,159,15,159,16,159,17,159,24,159,25,159,26,159,27,159,34,159,35,159,
36,159,37,159,52,159,53,159,54,159,55,159,56,159,57,159,64,159,65,159,66,159,67,159,74,159,75,159,76,159,77,159,84,159,85,159,86,159,87,159,
94,159,95,159,96,159,97,159,103,159,104,159,105,159,106,159,107,159,113,159,114,159,115,159,116,159,122,159,123,159,124,159,125,159,126,159,127,159,133,159,
134,159,135,159,136,159,137,159,138,159,143,159,144,159,145,159,146,159,147,159,148,159,153,159,154,159,155,159,156,159,157,159,158,159,163,159,164,159,165,159,
166,159,167,159,168,159,173,159,174,159,175,159,176,159,177,159,178,159,4,165,5,165,6,165,4,166,5,166,6,166,34,166,45,166,55,166,56,166,74,166,
85,166,95,166,96,166,124,166,125,166,126,166,127,166,135,166,145,166,155,166,156,166,164,166,165,166,166,166,167,166,4,167,5,167,6,167,34,167,35,167,
44,167,45,167,54,167,55,167,56,167,57,167,63,167,64,167,66,167,67,167,74,167,75,167,84,167,85,167,94,167,95,167,96,167,97,167,103,167,104,167,
106,167,107,167,114,167,115,167,116,167,117,167,124,167,125,167,126,167,127,167,135,167,136,167,144,167,145,167,154,167,155,167,156,167,157,167,164,167,165,167,
166,167,167,167,173,167,174,167,176,167,177,167,114,168,115,168,116,168,3,169,4,169,5,169,6,169,13,169,14,169,15,169,16,169,17,169,18,169,24,169,
25,169,26,169,27,169,28,169,33,169,34,169,35,169,36,169,37,169,43,169,44,169,45,169,46,169,47,169,53,169,54,169,55,169,56,169,57,169,63,169,
64,169,65,169,66,169,67,169,73,169,74,169,75,169,83,169,84,169,85,169,93,169,94,169,95,169,103,169,104,169,105,169,113,169,114,169,116,169,117,169,
122,169,123,169,124,169,125,169,126,169,127,169,134,169,135,169,136,169,137,169,144,169,145,169,146,169,147,169,154,169,155,169,156,169,157,169,164,169,165,169,
166,169,167,169,174,169,175,169,176,169,177,169,3,170,6,170,7,170,13,170,15,170,16,170,18,170,23,170,24,170,27,170,28,170,33,170,37,170,43,170,
47,170,53,170,57,170,63,170,67,170,75,170,85,170,95,170,105,170,113,170,114,170,115,170,116,170,117,170,123,170,124,170,126,170,127,170,133,170,134,170,
137,170,143,170,144,170,147,170,153,170,154,170,157,170,163,170,164,170,167,170,173,170,174,170,177,170,3,171,4,171,5,171,6,171,7,171,12,171,13,171,
14,171,15,171,16,171,17,171,18,171,23,171,32,171,33,171,34,171,35,171,36,171,37,171,38,171,42,171,43,171,44,171,45,171,46,171,47,171,48,171,
52,171,53,171,54,171,55,171,56,171,57,171,58,171,62,171,63,171,64,171,65,171,66,171,67,171,68,171,75,171,85,171,95,171,105,171,112,171,113,171,
116,171,117,171,118,171,123,171,124,171,127,171,132,171,133,171,137,171,138,171,142,171,143,171,147,171,148,171,152,171,153,171,157,171,158,171,162,171,163,171,
167,171,168,171,172,171,173,171,177,171,178,171,3,172,6,172,7,172,12,172,15,172,23,172,32,172,33,172,42,172,43,172,52,172,53,172,62,172,63,172,
75,172,85,172,95,172,105,172,112,172,113,172,117,172,118,172,123,172,124,172,127,172,132,172,133,172,137,172,138,172,142,172,143,172,147,172,148,172,152,172,
153,172,157,172,158,172,162,172,163,172,167,172,168,172,172,172,173,172,177,172,178,172,3,173,6,173,7,173,12,173,15,173,16,173,23,173,24,173,27,173,
28,173,33,173,43,173,53,173,63,173,75,173,85,173,95,173,105,173,113,173,117,173,123,173,124,173,127,173,133,173,137,173,143,173,147,173,153,173,157,173,
163,173,167,173,173,173,177,173,3,174,4,174,5,174,6,174,7,174,8,174,12,174,13,174,14,174,15,174,16,174,17,174,18,174,24,174,25,174,26,174,
27,174,33,174,34,174,35,174,36,174,37,174,43,174,44,174,45,174,46,174,47,174,53,174,54,174,55,174,56,174,57,174,63,174,64,174,65,174,66,174,
67,174,73,174,74,174,75,174,76,174,77,174,78,174,83,174,84,174,85,174,86,174,87,174,88,174,93,174,94,174,95,174,96,174,97,174,98,174,103,174,
104,174,105,174,106,174,107,174,108,174,113,174,114,174,115,174,116,174,117,174,122,174,123,174,124,174,126,174,127,174,128,174,133,174,134,174,135,174,136,174,
137,174,143,174,144,174,145,174,146,174,147,174,153,174,154,174,155,174,156,174,157,174,163,174,164,174,165,174,166,174,167,174,173,174,174,174,175,174,176,174,
177,174,25,175,25,176,26,176,24,177,25,177,26,177,
};
