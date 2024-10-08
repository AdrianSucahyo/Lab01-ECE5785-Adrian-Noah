CPP=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-cpp
CC=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-gcc
AS=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-as
LD=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-ld

SRC=main.c foo.c
OBJS=$(patsubst %.c, %.o, $(SRC))

.PHONY: all clean

all: firmware.elf

hello.txt:
	echo "hello world!" > hello.txt

%.i: %.c
	$(CPP) $< > $@

%.s: %.i
	$(CC) -S $@

%.o: %.s
	$(AS) $< -o $@

firmware.elf: $(OBJS)
	$(LD) -o $@ $^

clean:
	rm -f *.i *.o *.s hello.txt firmware.elf

