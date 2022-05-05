VERILOG = iverilog
TARGET = BCD.vcd
TEMP = temp.vvp
$(TARGET) : $(TEMP)
	vvp $(TEMP)
$(TEMP): testbench.v BCD.v
	$(VERILOG) -o $(TEMP) testbench.v BCD.v
clean:
	-del $(TARGET)
	-del $(TEMP)
