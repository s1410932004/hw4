module bcdview (numin,numout);
input [3:0] numin;
output [7:0] numout;
reg [7:0] numout;
always@ (numin)
    case(numin)
        4'b0000:numout=8'hc0;
        4'b0001:numout=8'hf9;
        4'b0010:numout=8'ha4;
        4'b0011:numout=8'hb0;
        4'b0100:numout=8'h99;
        4'b0101:numout=8'h92;
        4'b0110:numout=8'h82;
        4'b0111:numout=8'hf8;
        4'b1000:numout=8'h80;
        4'b1001:numout=8'h90;
        default:numout=8'hff;
    endcase
endmodule

module dff (clk, D, Din, Load, Q4);
input clk, D, Din, Load;
output Q4;
reg Q4;
always@ (posedge clk)
    if (Load) Q4 = Din;
    else Q4 = D;
endmodule

module BCD(clk, rst_syn, load, load_num, Q_out, num_out);
input clk,rst_syn,load;
input [3:0] load_num;
output [3:0] Q_out;
wire [3:0] Q_out;
output [7:0] num_out;
wire [7:0] num_out;
reg Q0,Q1,Q2,Q3;
bcdview y1(Q_out,num_out);

dff x1(clk,Q0,Q0,load,Q_out[0]);
dff x2(clk,Q1,Q1,load,Q_out[1]);
dff x3(clk,Q2,Q2,load,Q_out[2]);
dff x4(clk,Q3,Q3,load,Q_out[3]);
always@ (posedge clk)
begin
    if (!rst_syn) begin
        Q0<=0;
        Q1<=0;
        Q2<=0;
        Q3<=0;
    end
    else if (load)begin
        Q0<=load_num[0];
        Q1<=load_num[1];
        Q2<=load_num[2];
        Q3<=load_num[3];
    end
    else begin
        if(Q0==1&&Q3==1)begin
            Q3<=0;
            Q0<=0;
        end
        else begin
            Q3<=Q3|(Q0&Q1&Q2);
            Q2<=(Q2&~Q1)|(Q0&Q1&~Q2)|(~Q0&Q2);
            Q1<=(Q0&~Q1)|(~Q0&Q1);
            Q0<=~Q0;
        end
    end
end
endmodule
