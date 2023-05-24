module sevenSegment(input [3:0] binary, output [6:0] seg);
    assign seg = binary > 9 ? 7'b1111111 :
           binary == 9 ? 7'b0110111 :
           binary == 8 ? 7'b0000001 :
           binary == 7 ? 7'b1111001 :
           binary == 6 ? 7'b0010000 :
           binary == 5 ? 7'b0100100 :
           binary == 4 ? 7'b0000110 :
           binary == 3 ? 7'b1001000 :
           binary == 2 ? 7'b0000010 :
           binary == 1 ? 7'b1001111 :
                          7'b1000000;
endmodule