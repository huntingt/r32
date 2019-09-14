verilator -Wall --cc R32.sv --exe main.cpp
make -j -C obj_dir -f VR32.mk VR32
./obj_dir/VR32
