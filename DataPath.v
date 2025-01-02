module DataPath (clk, reset, ir_on_adr, pc_on_adr, ld_ir, ld_ac, ld_pc, inc_pc, clr_pc, pass_add, adr_bus, op_code, data_bus_in, data_bus_out);
input clk;
input reset;
input ir_on_adr;
input pc_on_adr;
input ld_ir;
input ld_ac;
input ld_pc;
input inc_pc;
input clr_pc;
input pass_add;
input [7:0] data_bus_in;
output [5:0] adr_bus;
output [1:0] op_code;
output [7:0] data_bus_out;

wire [7:0] ir_out;
wire [5:0] pc_out;
wire [7:0] a_side;

IR ir(clk, reset, ld_ir, data_bus_in, ir_out);
PC pc(clk, reset, inc_pc, ld_pc, ir_out[5:0], pc_out);
AC ac(clk, reset, ld_ac, data_bus_out, a_side);
ALU alu(a_side, ir_out[5:0], pass_add, data_bus_out);

assign adr_bus = ir_on_adr ? ir_out[5:0] : pc_on_adr ? pc_out : 6'b0;
assign op_code = ir_out[7:6];
    
endmodule