.global _start

_start:
    // Load stack_top address
    ldr     x1, =stack_top
    // Move into stack pointer
    mov     sp, x1
    // Start main
    bl kmain

// Hang if kmain returns
hang:
    b hang

