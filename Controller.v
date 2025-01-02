module Controller (
    reset, clk, op_code, rd_mem, wr_mem, ir_on_adr, pc_on_adr, ld_ir, ld_ac, ld_pc, inc_pc, clr_pc, pass_add    
    );

    input reset;
    input clk ;
    input [1:0] op_code;
    output rd_mem;
    output wr_mem;
    output ir_on_adr;
    output pc_on_adr;
    output ld_ir; 
    output ld_ac;
    output ld_pc;
    output inc_pc;
    output clr_pc;
    output pass_add;

    reg rd_mem;
    reg wr_mem;
    reg ir_on_adr;
    reg pc_on_adr;
    reg ld_ir;
    reg ld_ac;
    reg ld_pc;
    reg inc_pc; 
    reg clr_pc; 
    reg pass_add;
    reg [1:0] present_state;
    reg [1:0] next_state;

    always @ ( posedge clk ) begin 

        if (reset) 
            present_state <= 2'b00;
        else 
            present_state <= next_state;
    end

    always @ (present_state, op_code) begin 
        rd_mem = 1'b0; wr_mem = 1'b0; ir_on_adr = 1'b0; pc_on_adr = 1'b0; ld_ir = 1'b0; ld_ac = 1'b0; ld_pc = 1'b0; inc_pc = 1'b0; clr_pc = 1'b0;
        pass_add = 1'b0;

        case( present_state ) 
            2'b00 : begin 
                next_state = 2'b01;
                clr_pc = 1'b1;
            end

            2'b01 : begin 
                next_state = 2'b10;
                pc_on_adr = 1'b1; 
                rd_mem    = 1'b1;
                ld_ir     = 1'b1;
                inc_pc    = 1'b1;
            end

            2'b10 : begin 
                next_state = 2'b11;
            end

            2'b11 : begin 
                next_state = 2'b01;
                case( op_code ) 
                    2'b01: begin 
                        ir_on_adr = 1'b1;
                        rd_mem    = 1'b1; 
                        ld_ac     = 1'b1;
                    end
                    2'b10: begin 
                        ir_on_adr = 1'b1;
                        pass_add  = 1'b1;
                        wr_mem    = 1'b1;
                        
                    end

                    2'b11: ld_pc = 1'b1;
                    2'b00: begin 
                        pass_add = 1'b0;
                        ld_ac    = 1'b1;
                    end
                endcase
            end

        endcase

    end
    
endmodule