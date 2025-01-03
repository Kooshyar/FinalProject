module PC (clk, reset, clr_pc, inc_pc, ld_pc, ir_reg, out_pc);

input clk;
input reset;
input clr_pc;
input inc_pc;
input ld_pc;
input [5:0] ir_reg;
output [5:0] out_pc; 

reg [5:0] n_state;
reg [5:0] p_state;


always @ (posedge clk) begin
    if(reset) 
        p_state <= 6'b0;
    else
        p_state <= n_state;
end

always @ (p_state, ir_reg, inc_pc, ld_pc, reset, clr_pc)
begin
    if(inc_pc)
        n_state = n_state + 1;
    else if(ld_pc)
        n_state = ir_reg;
    else if(clr_pc)
        n_state = 6'b0;
    else
        n_state = 6'b0;
end

assign out_pc = p_state;
endmodule