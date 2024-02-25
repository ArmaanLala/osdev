#include "include/uart.h"
void kmain(void)
{
    const char* s = "Hello !\n\0";
    print(s);

    // If you uncomment these lines then nothing prints :(
    // const char* x = "Hello !\n\0";
    // print(x);
}
