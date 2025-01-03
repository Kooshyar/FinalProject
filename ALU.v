module ALU (out_ac, out_ir, pass_add, out_alu);
   input [7:0] out_ac; 
   input [5:0] out_ir;
   input pass_add; 
   output reg [7:0] out_alu;

   wire [7:0] immediate;     
   wire [7:0] out_ac_wire; 

   assign immediate = { 2'b00, out_ir};
   assign out_ac_wire = out_ac;
	
    

    always @ (out_ac, out_ir, pass_add, immediate) begin 
        case (pass_add) 
            1'b0 : out_alu = immediate + out_ac;
            1'b1 : out_alu = out_ac; 
	    default : out_alu = immediate + out_ac;
        endcase
    end
    
endmodule