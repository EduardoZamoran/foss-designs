/*  Adder - Subtrator Testbench
    Luis Eduardo Zamora Moran
    Octuber 2, 2026.
*/

`timescale 1ns/1ps

module addsub_SU_Nb_tb ();
    parameter int N = 8;
    bit [N-1:0]Din_A;
    bit [N-1:0]Din_B;
    bit OP_sel;
    bit [1:0]SU_sel;
    logic [N:0]Dout;
    logic [N:0]GoldenR;
    string trans_type;
    
    int i, j, errors;
    Adder_Subtractor #(N) DUT (.*);

    task set_transaction (input bit [N-1:0]a, input bit [N-1:0]b, input bit [1:0]su_sel, input bit op_sel);
        logic [N:0] op_a;
        logic [N:0] op_b;

        Din_A = a;
        Din_B = b;
        SU_sel = su_sel;
        OP_sel = op_sel;
        
        case (SU_sel)
            2'b00: begin op_a = unsigned'(a); op_b = unsigned'(b); end
            2'b01: begin op_a = unsigned'(a); op_b = signed'(b); end
            2'b10: begin op_a = signed'(a); op_b = unsigned'(b); end
            2'b11: begin op_a = signed'(a); op_b = signed'(b); end
        endcase

            case ({OP_sel,SU_sel})
                3'b000: trans_type = "UU_ADD"; 
                3'b001: trans_type = "US_ADD"; 
                3'b010: trans_type = "SU_ADD"; 
                3'b011: trans_type = "SS_ADD"; 
                3'b100: trans_type = "UU_SUB";
                3'b101: trans_type = "US_SUB"; 
                3'b110: trans_type = "SU_SUB"; 
                3'b111: trans_type = "SS_SUB"; 
            endcase

        if (OP_sel)
            GoldenR = op_a - op_b;
        else 
            GoldenR = op_a + op_b;

        #5 
        if (GoldenR !== Dout) begin
            $display("ERROR AT time: %3t, transaction type:%s: Din_A:%3h, Din_B: %3h", $time, trans_type, Din_A, Din_B);
            $display( "Espected Dout: %3h Obtained Dout %3h", GoldenR[N:0], Dout);
            errors++;
        end
        else 
            $display("I- time:%3t - transaction type:%s: Din_A:%3h, Din_B: %3h, Dout: %3h", $time, trans_type, Din_A, Din_B, Dout);
    endtask

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, addsub_SU_Nb_tb);
    end

    initial begin
    
    for (i = 0; i < 2; i++ ) begin
        for(j = 0; j < 4; j++)begin
        //================================esc 00h +- 00h MSB(0,0) =============================
        set_transaction('0,'0,j,i);
        //================================esc 00h +- ffh MSB(0,1) ==========================
        set_transaction('0,'1,j,i);
        //================================esc ffh +- 01h MSB(1,0)) ========================
        set_transaction('1,1,j,i);
        //================================esc ffh +- ffh MSB(1,1) ========================
        set_transaction('1,'1,j,i); 
        end
    end   
    
        $display("Begins Random Test");
        for (i = 0; i < 50; i++ ) begin
        set_transaction($random()%256, $random()%256 , $random()%4, $random()%2);
        end

    if (errors == 0)
        $display("TEST PASSED WITHOUT ERRORS");
    else
        $display("TEST FAILED WITH %d ERRORS", errors);
    end
endmodule