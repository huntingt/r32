#include <iostream>
#include <string>
#include <vector>

#include "verilated.h"
#include "code_test.h"

using namespace std;

int main(int argc, char** argv, char ** env) { 
    //setup verilator
    Verilated::commandArgs(argc, argv);

    vector<string> tests{
        "simple",
    };
    
    int failed = 0;
    for (string test : tests) {
        cout << test << "...";
        
        auto file = "test/bin/" + test + ".bin";
        CodeTest tb = CodeTest(file, 0x200, 0x2000);
        
        auto [passed, message] = tb.run(1);
        
        cout << message << endl;
        if (!passed) {
            failed += 1;
        }
    }

    cout << "failed " << to_string(failed) << " tests" << endl;

    return failed != 0;
}
