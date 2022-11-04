//////////////////////////////////////////////////////////////////////////////////
// Company: SIU Education 
// Engineer: Michael Tjemmes
// 
// Create Date: 11/19/2021
// Design Name: Piplined Version
// Module Name: MACTB
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

module MACTB;

    
    reg clk;
    reg [0:127] data_a [0:39];
    reg [0:127] data_b [0:39];
    reg [0:127] a, b;
    reg [0:7] count; 
    reg rst; 
    
    wire clk2;
    wire [0:19] p;

    integer outfile;

    parameter half_cycle = 10;

    initial 
    begin
        $readmemh("weights_hex.txt", data_a);
        $readmemh("digits_hex.txt", data_b);
        outfile = $fopen("simout.txt", "w");
        clk =0;
        count = 0;
        rst =0;        
    end
    
    //Clock Generations
    always 
    begin
      clk=1;
      #half_cycle;
      clk=0;
      #half_cycle;
    end

    assign #2 clk2 = clk; // delayed clk

    MAC uut(a,b,clk2,rst,p);
    //MAC2 uut(a,b,p);

    always @(posedge clk)
    begin
        $fdisplay(outfile, "%d: a=%h, b=%h, p=%h", count, a, b, p);
        
    end 

    always @(posedge clk2)
    begin
        a=data_a[count];
        b=data_b[count];
        count= count+1;
        if (count==43) 
            begin
                $fclose(outfile);
                $finish; 
            end

    end

endmodule