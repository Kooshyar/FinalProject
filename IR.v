module IR (clk, reset, ld_ir, data_bus_in, out_ir);

input clk;
input reset;
input ld_ir; 
input [7:0] data_bus_in;
output [7:0] out_ir;
reg [7:0] d_reg;

always @ (posedge clk) begin 
    if(reset)
        d_reg <= 8'b0;
    else if(ld_ir) 
        d_reg <= data_bus_in;
end

assign out_ir = d_reg;

endmodule