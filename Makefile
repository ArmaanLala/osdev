# Directories
SRCDIR = src
BINDIR = bin

INC_DIRS = $(shell find $(SRCDIR) -type d)
INC_FLAGS = $(addprefix -I, $(INC_DIRS))

# Source and Object Files
SRCS = $(wildcard $(SRCDIR)/*.c)   # Collect all C source files
ASMS = $(wildcard $(SRCDIR)/*.S)   # Collect all Assembly source files
OBJS = $(SRCS:$(SRCDIR)/%.c=$(BINDIR)/%.o) $(ASMS:$(SRCDIR)/%.S=$(BINDIR)/%.o)  # Object files for each source

# Compiler and Linker Flags
CC = clang
CFLAGS = -Wall -O2 -ffreestanding -nostdinc -nostdlib -mcpu=cortex-a57 --target=aarch64-elf -I $(INC_FLAGS)
LDFLAGS = -m aarch64elf -nostdlib -T link.ld

# Default target
all: kernel.img

# Ensure the bin directory exists
$(BINDIR):
	@mkdir -p $(BINDIR)

# Rule for compiling C files
$(BINDIR)/%.o: $(SRCDIR)/%.c | $(BINDIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Rule for compiling Assembly files
$(BINDIR)/%.o: $(SRCDIR)/%.S | $(BINDIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Linking objects to create the kernel.elf
kernel.img: $(OBJS) link.ld | $(BINDIR)
	ld.lld $(LDFLAGS) -o $(BINDIR)/kernel.elf $(OBJS)

# Clean up
clean:
	rm -rf $(BINDIR)/*.o $(BINDIR)/kernel.elf kernel.img

dump:
	qemu-system-aarch64 -M virt,dumpdtb=virt.dtb -kernel kernel.img
	dtc -I dtb -O dts -o device_tree.dts virt.dtb
	
# Run the kernel in QEMU
run:
	qemu-system-aarch64 -M virt -cpu cortex-a57 -kernel bin/kernel.elf -nographic
