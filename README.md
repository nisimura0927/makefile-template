# Makefile Template for C Projects


■Overview:
This repository provides a flexible Makefile template for small to medium-sized C projects.
It simplifies building, running, static analysis, and cleanup operations.

■Requirements:
・OS:WSL
・Compiler:gcc
・Static analysis tool:cppcheck

■Usage:
1.Build and run a C file(e.g.,test.c)
````bash
make run FILE=test

2.Run static analysis
````bash
make lint FILE=test

3.Clean build results
Clean all→
make clean FILE=all

Clean specific file:
````bash
make clean FILE=test

Warning:Omitting = (e.g, FILEtest instead of FILE=test) may lead to unintended full deletion.

■Customization
You are free to modify this Makefie to fit your project's needs.

Examples:
・Support for multiple source files
・Separate build/output directories
・Adjusting compiler flags(GFLAGS)
・Adding custom build targets(e.g,test,debug)

■Disclaimer
The author assumes no responsibility for any issues caused by using this Makefile.You are free to use,modify,and redistribute it under the MIT License

