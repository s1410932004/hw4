`timescale 1ns/10ps
module bcd_tb;
reg clk,rst_syn,load;
reg [3:0] load_num;
wire [3:0] Q_out;
wire [7:0] num_out;
BCD ans (clk, rst_syn, load, load_num, Q_out, num_out);
initial begin
    clk=1;
    rst_syn=1;
    load=1;
    load_num=4'b0010;
end
always #50 clk=~clk;
initial #100 load=0;
initial #1300 load=1;
initial #1400 load=0;
initial #800 rst_syn=0;
initial #900 rst_syn=1;
initial #2000 $finish;
initial begin
$dumpfile("bcdans.vcd");
$dumpvars(0,ans);
end
endmodule
