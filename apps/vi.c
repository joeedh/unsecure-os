#include <stdint.h>
#include <stddef.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

enum {
  KEY_LEFT,
  KEY_RIGHT,
  KEY_UP,
  KEY_DOWN,
  KEY_SCROLLUP,
  KEY_SCROLLDOWN,
  KEY_BACKSPACE,
  KEY_DELETE,
  KEY_CHAR
};

typedef struct ViTTY {
  int width, height;
  uint16_t *screen;
  int scrollx, scrolly;
} ViTTY;

typedef struct ViLine {
  char _line[256], *line; //line will usually point to _line
  int len;
} ViLine;

typedef struct ViState {
  ViTTY *tty;
  ViLine *lines;
  int totline, totline_alloc;
  char *filepath;
  
  int cursorx, cursory;
  int rcursorx, rcursory; //'real' cursor
} ViState;

ViLine *Vi_AddLine(ViState *vi) {
  if (vi->totline >= vi->totline_alloc) {
    vi->lines = realloc(vi->lines, vi->totline_alloc*2);
  }
  
  vi->totline++;
  ViLine *ret = &vi->lines[vi->totline-1];
  ret->line = ret->_line;
  ret->line[0] = 0;
  
  return ret;
}

int Vi_Load(ViState *vi, const char *buf) {
  int i, len = strlen(buf);
  int linestart = 0;
  
  ViLine *line = Vi_AddLine(vi);
  
  for (i=0; i<len; i++) {
    char c = buf[i];
    
    if (c == '\n') {
      int len2 = i - linestart;
      
      if (len2 > sizeof(line->_line)) {
        line->line = malloc(len2+1);
      }
      
      memcpy(line->line, buf+linestart, len2);
      line->line[len2] = 0;
      line->len = len2;
      
      linestart = i+1;
      line = Vi_AddLine(vi);
    } else if (c == '\r') {
      continue;
    }
  }
}

int Vi_CalcCursor(ViState *vi, int *cx, int *cy) {
  *cx = vi->cursorx - vi->tty->scrollx;
  *cy = vi->cursory - vi->tty->scrolly + 1;
}

int Vi_CalcLineNumPad(ViState *vi) {
  if (vi->totline < 100)
    return 2;
  else if (vi->totline < 1000)
    return 3;
  else if (vi->totline < 10000)
    return 4;
  else
    return 7;
}

int Vi_Render(ViState *vi) {
  int i, j, padcol, cx, cy;
  
  padcol = Vi_CalcLineNumPad(vi);
  
  if (vi->totline < 100)
    padcol = 2;
  else if (vi->totline < 1000)
    padcol = 3;
  else if (vi->totline < 10000)
    padcol = 4;
  else
    padcol = 7;
  
  //hide cursor
  printf("\33[?25l");
  
  for (i=0; i<vi->tty->height; i++) {
    ViLine *line;
    int k, c;
    
    printf("\33[%d;0H", i+1);
    
    j = printf("%d", i+vi->tty->scrolly);
    for (; j<padcol; j++) {
      printf(" ");
    }
    printf(" |");
    
    k = i+vi->tty->scrolly;
    if (k < 0 || k >= vi->totline) {
      printf("~");
      continue;
    }
    
    line = vi->lines + k;
    c = printf("%s", line->line);
    
    if (c < vi->tty->width) {
      printf("\33[%d;%dH", i+1, c+padcol+2);
      printf("\33[K");
    }
  }
  
  //show cursor
  printf("\33[?25h");
  
  Vi_CalcCursor(vi, &cx, &cy);
  printf("\33[%d;%dH", cy, cx+padcol+3);
}

int Vi_FlushCursor(ViState *vi) {
  int padcol = Vi_CalcLineNumPad(vi);
  int cx, cy;
  
  Vi_CalcCursor(vi, &cx, &cy);
  
  //adjust scroll, if necasary
  if (cy >= vi->tty->height) {
    vi->tty->scrolly += cy - vi->tty->height + 1;
    Vi_CalcCursor(vi, &cx, &cy);
  } else if (cy < 0) {
    vi->tty->scrolly += cy + 1;
    Vi_CalcCursor(vi, &cx, &cy);
  }
  
  //test cursorx bounds
  if (vi->cursorx > vi->lines[vi->cursory].len) {
    vi->cursorx = vi->lines[vi->cursory].len;
    Vi_CalcCursor(vi, &cx, &cy);
  }
  
  printf("\33[%d;%dH", cy, cx+padcol+3);
}

int Vi_HandleEvent(ViState *vi, int event, int val) {
  //printf("event!\n");
  
  switch (event) {
    case KEY_UP:
      if (vi->cursory > 0) {
        vi->cursory--;
        Vi_FlushCursor(vi);
      }
      break;
    case KEY_DOWN:
      if (vi->cursory < vi->totline-1) {
        vi->cursory++;
        Vi_FlushCursor(vi);
      }
      break;
    case KEY_LEFT:
      if (vi->cursorx > 0) {
        vi->cursorx--;
      } else if (vi->cursory > 0) {
        vi->cursory--;
        vi->cursorx = vi->lines[vi->cursory].len;
      }
      
      Vi_FlushCursor(vi);
      break;
    case KEY_RIGHT:
      if (vi->cursorx < vi->lines[vi->cursory].len) {
        vi->cursorx++;
      } else if (vi->cursory < vi->totline-1) {
        vi->cursory++;
        vi->cursorx = 0;
      }
      
      Vi_FlushCursor(vi);
      break;
  }
}

ViState *Vi_Init() {
  ViState *vi = malloc(sizeof(*vi));
  
  memset(vi, 0, sizeof(*vi));
  
  //set up a tty
  vi->tty = malloc(sizeof(*vi->tty));
  memset(vi->tty, 0, sizeof(*vi->tty));
  
  vi->tty->width = 80;
  vi->tty->height = 25;
  vi->tty->screen = malloc(sizeof(short)*vi->tty->width*vi->tty->height);
  memset(vi->tty->screen, 0, sizeof(short)*vi->tty->width*vi->tty->height);
  
  //preallocate some lines
  vi->totline_alloc = 32;
  vi->lines = malloc(sizeof(*vi->lines)*vi->totline_alloc);
  memset(vi->lines, 0, sizeof(*vi->lines));
  
  return vi;
}

int Vi_Loop(ViState *vi) {
  int ch, i, j;
  
  printf("%d\n", system("stty raw -echo"));
  
  //printf("::%d\n", setvbuf(stdin, NULL, _IONBF, 0));
  //setvbuf(stdout, NULL, _IONBF, 0);
  //setvbuf(stderr, NULL, _IONBF, 0);
  
  //setbuf(stdin, NULL);
  
  printf("\33_");
  printf("\33[6n");
  
  fflush(stdout);
  fflush(stdin);
  
  //while (feof(stdin));
  
  printf("\33[A");
  printf("\33[A");
  
  int state = 0;
  
  while (1) {
    fflush(stdin);
    
    ch = fgetc(stdin);
    
    if (ch < 0)
      continue;
    
    if (state == 1) {
      state = 2*(ch == '[');
    } else if (state == 2) {
      
      switch (ch) {
        case 'A':
          Vi_HandleEvent(vi, KEY_UP, 1);
          break;
        case 'B':
          Vi_HandleEvent(vi, KEY_DOWN, 1);
          break;
        case 'C':
          Vi_HandleEvent(vi, KEY_RIGHT, 1);
          break;
        case 'D':
          Vi_HandleEvent(vi, KEY_LEFT, 1);
          break;
        default:
          break;
      }
      state = 0;
    } else if (state == 0) {
    //  Vi_Render(vi);
    }
    
    Vi_Render(vi);
    
    if (ch == 27) {
      state = 1;
      ch = '^';
    }
    
    /*
    printf("%c", ch);
    //printf("\33[5;5H");
    
    if (ch == '\n') {
      printf("\33[B");
      
      for (j=0; j<50; j++) {
        printf("\33[D");
      }
    }//*/
    
    if (ch == 'q' || ch == 'Q') {
      break;
    }
    
    //usleep(1);
  }
  
  system("stty -raw echo");
}

int main(int argc, char **argv) {
  FILE *file;
  
  if (argc < 2) {
    fprintf(stderr, "expected a file!\n");
    return -1;
  }
  
  file = fopen(argv[1], "rb");
  if (!file) {
    fprintf(stderr, "could not open %s\n", argv[1]);
    return -1;
  }
  
  fseek(file, 0, SEEK_END);
  size_t length = ftell(file);
  
  char *buf = malloc(length);
  fseek(file, 0, SEEK_SET);
  
  fread(buf, length, 1, file);
  printf("vi!");
  
  ViState *vi = Vi_Init();
  Vi_Load(vi, buf);
  Vi_Loop(vi);
}

