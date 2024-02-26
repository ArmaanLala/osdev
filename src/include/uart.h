#ifndef UART
#define UART

void uart_init();
void uart_send(unsigned int s);
char uart_recv();
void uart_puts(char s);
void print(const char* s);

#endif

