#include<ncurses.h>
int main(){
  initscr();
  start_color();
  init_pair(1, COLOR_BLUE, COLOR_BLUE);
  init_pair(2, COLOR_BLACK, COLOR_BLACK);
  int xmax=getmaxx(stdscr),
       ymax=getmaxy(stdscr);
  int x_current=xmax/2,y_current=ymax/2;
  raw();
  noecho();
  keypad(stdscr, TRUE);
  chtype space_color=' '|COLOR_PAIR(1),
    space_bground=' '|COLOR_PAIR(2),c;
  int p=1;
  move(0, 0);
  printw("q - quit\n");
  printw("c - clear screen\n");
  printw("z - change color");
  move(y_current,x_current);
  while(c!='q'){
    c=getch();
    if (c==KEY_DOWN)
      y_current=(y_current+1)%ymax;
    if (c==KEY_UP) {
      y_current=(y_current-1)%ymax;
      if (y_current<0) y_current=ymax;}
    if (c==KEY_LEFT) {
      x_current=(x_current-1)%xmax;
      if (x_current<0) x_current=xmax;}
    if (c==KEY_RIGHT)
      x_current=(x_current+1)%xmax;
    if (c=='c') {
      clear();
      move(0, 0);
      printw("q - quit\n");
      printw("c - clear screen\n");
      printw("z - change color");
      x_current=xmax/2;
      y_current=ymax/2;
    }
    if (c=='z') p=(p+1)%2;
    move(y_current, x_current);
    if (p) addch(space_color);
    else addch(space_bground);
    refresh();
  }
  echo();
  cbreak();
  keypad(stdscr, FALSE);
  endwin();
  return 0;
}
