#include <stdio.h>

int show_message(void) {
    setbuf(stdout, 0);
    printf("this is a test message\n");
    return 0;
}
