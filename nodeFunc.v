//////////////////////////////////////////////////////////////////////////////////
// Company: SIU Education 
// Engineer: Michael Tjemmes
// 
// Create Date: 11/19/2021
// Design Name: Piplined Version
// Module Name: nodeFunc
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

module nodeFunc(
input [0:127] inA,
input [0:127] inB,
input [0:7] bias,
input rdy,
input clk,
input rst,
output[0:7] res
);


wire [0:21]sum;
wire [0:7] resPar;

MAC_ACC MAC_ACC1(inA,inB,bias,rdy,clk,rst,sum);

ipWrap ipFunct(sum, resPar);

assign res=resPar;

endmodule