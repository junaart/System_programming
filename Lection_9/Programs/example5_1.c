/* example5_1.c */
#include <ncurses.h>
#include <stdio.h>

int main()
{      
    initscr();                      /* Start curses mode  */
    int x, y;
    y = getmaxy(stdscr)/2;
    x = getmaxx(stdscr)/2;
    move(y,x);
    printw("Hello World!");  /* Print Hello World */
    refresh();                  /* Print it on to the real screen */
    getch();                   /* Wait for user input */
    endwin();                   /* End curses mode */

    return 0;
}
