module AC (clk, reset, ld_ac, data_bus_in, out_ac);
input clk;
input reset;
input ld_ac;
input [7:0] data_bus_in;
output [7:0] out_ac;
reg [7:0] d_reg;

always @ (posedge clk) begin
    if(reset)
        d_reg <= 8'b0;
    else if(ld_ac)
        d_reg <= data_bus_in;
end

assign out_ac = d_reg;
endmodule