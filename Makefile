obj_dir/VR32.mk:
	verilator -Wall --cc R32.sv --exe main.cpp

obj_dir/VR32: obj_dir/VR32.mk
	make -j -C obj_dir -f VR32.mk VR32

test: obj_dir/VR32
	./obj_dir/VR32

clean:
	rm -r obj_dir/
