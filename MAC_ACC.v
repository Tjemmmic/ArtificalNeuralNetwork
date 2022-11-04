//////////////////////////////////////////////////////////////////////////////////
// Company: SIU Education 
// Engineer: Michael Tjemmes
// 
// Create Date: 11/19/2021
// Design Name: Multiplier Accumulator Accumulator
// Module Name: MAC
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

module MAC_ACC(
input [0:127] inA,
input [0:127] inB,
input [0:7] bias,
input rdy,
input clk,
input rst,
output[0:21] res
);

wire [0:19]Y;
wire ready;
wire [0:21]sum;

//FSM registers and parameters
reg [0:1]n_state;
reg [0:1]c_state;
parameter s0 = 2'b00;
parameter s1 = 2'b01;
parameter s2 = 2'b10;
parameter s3 = 2'b11;

MAC MAC1(inA,inB,clk,rst,Y);

ACC ACC1(Y,ready,rst,clk,bias,sum);


//FSM Control Module
always@(*)begin
    case(c_state)
        s0:n_state=s1;
        s1:n_state=s2;
        s2:n_state=s3;
        s3:n_state=s3;
        default:n_state=s0;
    endcase
end

always @(posedge clk)
begin
    if (~rst & rdy)
        begin
            c_state = n_state;
        end
    else
        begin
            c_state = s0;
        end
end

assign ready = (c_state == s3) ? 1 : 0;
assign res = sum;


endmodule