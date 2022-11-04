//////////////////////////////////////////////////////////////////////////////////
// Company: SIU Education 
// Engineer: Michael Tjemmes
// 
// Create Date: 11/19/2021
// Design Name: Accumulator
// Module Name: ACC
// Project Name: Final Project
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ACC(
input [0:19]operand,
input ready,
input rst,
input clk,
input [0:7]B,
output [0:21]sum
);

reg[0:21] accREG;
reg[0:21] outREG;


wire sel;
wire en;

wire [0:21]addToACC;
wire [0:21]accToMUX;
wire [0:21]muxToADD;

//Accumulator Block
assign addToACC = muxToADD + operand;
assign accToMUX = accREG;
assign muxToADD = (sel==1) ? B : accToMUX;
assign sum = outREG;

always @(posedge clk)
begin
    if(rst)
    begin
        accREG=0;
        outREG=0;  
    end

    else
    begin
        if(ready)
        begin
            if(en)
                outREG=addToACC;
            else
                outREG=outREG;
            
            accREG=addToACC;
        end
        else
        begin
            accREG=0;
            outREG=outREG;
        end
    end
end


//FSM Control Module
reg [0:1]n_state;
reg [0:1]c_state;

parameter s0 = 2'b00;
parameter s1 = 2'b01;
parameter s2 = 2'b10;
parameter s3 = 2'b11;

always@(*)begin
    case(c_state)
        s0:n_state=s1;
        s1:n_state=s2;
        s2:n_state=s3;
        s3:n_state=s0;
        default:n_state=s0;
    endcase
end

always @(posedge clk)
begin
    if (~rst & ready)
        begin
            c_state = n_state;
        end
    else
        begin
            c_state = s0;
        end
end

assign sel = (((c_state == s0) & ~clk& ready) | ((c_state == s1) & clk)) ? 1 : 0;
assign en  = (c_state == s3) ? 1 : 0;

endmodule