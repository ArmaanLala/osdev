.section ".text.boot"

.global _start

_start:
    // load Multiprocessor Affinity Register into x1
    mrs     x1, mpidr_el1 
    // Get the last two bits -> Processor Id
    and     x1, x1, #3
    // Jump if id ==0 
    cbz     x1, main_proc_init

// Non main proc stay in interupt loop
other: 
    wfe
    b       other

main_proc_init:
    // Move start addr into stack pointer
    ldr     x1, _start
    mov     sp, x1

call_main:
    bl      kmain
    b       other

