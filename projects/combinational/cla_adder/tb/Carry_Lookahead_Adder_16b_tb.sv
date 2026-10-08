/*  Carry Lookahead Adder 16-bit Testbench
    Luis Eduardo Zamora Moran
    Octuber 3, 2026.
*/

`timescale 1ns/1ps

module CLA_16b_tb ();
    // Señales
    parameter int N = 16;
    bit [N-1:0]Din_A, Din_B;
    bit OP_sel;
    bit SU_sel;
    logic [N:0]Dout, GoldenR;
    string trans_type;

    int i, j, errors;

    // Instancia
    CLA_16b #(N) DUT (.*);

    task set_transaction (input bit [N-1:0]a, input bit [N-1:0]b, input bit su_sel, input bit op_sel);
        logic [N:0] op_a;
        logic [N:0] op_b;

        Din_A = a;
        Din_B = b;
        SU_sel = su_sel;
        OP_sel = op_sel;
        
        case (SU_sel)
            1'b0: begin op_a = $unsigned(a); op_b = $unsigned(b); end
            1'b1: begin op_a = $signed(a); op_b = $signed(b); end
        endcase

        // Casos de suma o resta con signo y sin signo
        case ({OP_sel,SU_sel})
            2'b00: trans_type = "UU_ADD"; 
            2'b01: trans_type = "SS_ADD"; 
            2'b10: trans_type = "UU_SUB"; 
            2'b11: trans_type = "SS_SUB"; 
        endcase

        if (OP_sel)
            GoldenR = op_a - op_b;
        else 
            GoldenR = op_a + op_b;

        #5 
        if (GoldenR !== Dout) begin
            $display("ERROR AT time: %0t, transaction type:%s: Din_A:%0h, Din_B: %0h", $time, trans_type, Din_A, Din_B);
            $display("Expected Dout: %0h Obtained Dout %0h", GoldenR[N:0], Dout);
            errors++;
        end
        else 
            $display("I- time:%0t - transaction type:%s: Din_A:%0h, Din_B: %0h, Dout: %0h", $time, trans_type, Din_A, Din_B, Dout);
    endtask

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, CLA_16b_tb);
    end

    initial begin
        for (i = 0; i < 2; i++) begin
            for(j = 0; j < 2; j++) begin
            //================================esc 0000h +- 0000h MSB(0,0) =========================
            set_transaction('0,'0,j,i);
            //================================esc 0000h +- ffffh MSB(0,1) =========================
            set_transaction('0,'1,j,i);
            //================================esc ffffh +- 0001h MSB(1,0)) ========================
            set_transaction('1,1,j,i);
            //================================esc ffffh +- ffffh MSB(1,1) =========================
            set_transaction('1,'1,j,i); 
            end
        end   

        $display("Begins Random Test");
        for (i = 0; i < 50; i++ ) begin
            // $urandom genera un valor aleatorio de 32 bits, lo limitamos con máscara a 16 bits
            set_transaction($urandom() & 16'hFFFF, $urandom() & 16'hFFFF, $urandom()%2, $urandom()%2);
        end

        if (errors == 0)
            $display("TEST PASSED WITHOUT ERRORS");
        else
            $display("TEST FAILED WITH %d ERRORS", errors);
    end
endmodule