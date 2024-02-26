#include "include/uart.h"
#include "include/address.h"

// TODO
void uart_init() {}

void uart_puts(char s) { *UART_BASE = s; }

// TODO
void uart_send(unsigned int s) {}

char uart_recv() { return (char)(*UART_BASE); }

void print(const char* s)
{
    unsigned int count = 0;
    while (s[count] != '\0') {
        uart_puts(s[count]);
        count++;
    }
}
