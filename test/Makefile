test: bin/simple.bin

clean:
	rm -rf bin/

bin:
	mkdir bin

bin/%.bin: bin/%.elf bin
	riscv32-unknown-elf-objcopy $< $@ -O binary
	chmod -x $@

bin/%.elf: %.s bin
	riscv32-unknown-elf-gcc -Wall -nostdlib -nostartfiles $< -T link.ld -o $@ -march=rv32i
