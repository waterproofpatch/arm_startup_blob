BIN_DIR=bin

all: configure
	arm-none-eabi-gcc -c -mcpu=arm926ej-s -g blob.c -o $(BIN_DIR)/blob.o
	arm-none-eabi-as -mcpu=arm926ej-s -g startup.s -o $(BIN_DIR)/startup.o
	arm-none-eabi-ld -T blob.ld $(BIN_DIR)/blob.o $(BIN_DIR)/startup.o -o $(BIN_DIR)/blob.elf

configure:
	@mkdir -p $(BIN_DIR)

clean:
	@rm -rf $(BIN_DIR)

disas:
	arm-none-eabi-objdump $(BIN_DIR)/blob.elf -d
