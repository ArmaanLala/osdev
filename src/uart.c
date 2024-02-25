#include "include/uart.h"

volatile unsigned int* uart = (unsigned int*)0x09000000;

// TODO
void uart_init() {}

void uart_puts(char s) { *uart = s; }

// TODO
void uart_send(unsigned int s) {}

char uart_recv() { return (char)(*uart); }

void print(const char* s)
{
    unsigned int count = 0;
    while (s[count] != '\0') {
        uart_puts(s[count]);
        count++;
    }
}
