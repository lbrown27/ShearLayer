/*!
 * File: HelloWorld.cpp
 * This file is to test the configuration of PadeLibs
 */
#include <cstdio>
#include "padelibs.h"

int main(int argc, char* argv[]) {
    plib::initialize(argc, argv);
{
    plib::PARTITION.reportInfo();
    plib::print("Hello World!\n");
}
    return plib::finalize();
}
