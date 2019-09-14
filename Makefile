test: obj_dir/VR32
	make -C test
	./obj_dir/VR32


obj_dir/VR32.mk:
	verilator -Wall --cc R32.sv --exe main.cpp

obj_dir/VR32: obj_dir/VR32.mk
	make -j -C obj_dir -f VR32.mk VR32

clean:
	make -C test clean
	rm -rf obj_dir/
	rm -rf test/bin/
