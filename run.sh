#!/bin/bash

# Compile Java source files
echo "Compiling Nachos OS..."
javac -d . `find . -name "*.java"`

# Run Nachos OS
echo "Running Nachos OS..."
java nachos.machine.Machine




