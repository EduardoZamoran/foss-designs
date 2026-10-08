/*  Full_Adder_8b Test Bench Dirigido
    Luis Eduardo Zamora Moran
    Sep, 21th. 2026
*/

`timescale 1ns/1ps

module Full_Adder_8b_tb;
    int i, j;
    bit [7:0]a;
    bit [7:0]b;
    bit ci;
    bit [7:0]s;
    bit co;

    FA_8bits DUT(a, b, ci, s, co);

    // Volcar datos a un documento para observar las formas de onda.
    initial begin
        $dumpfile("adder_waves.vcd");
        $dumpvars(0, Full_Adder_8b_tb);
    end

    // Si solo me interezan las formas de onda, se pueden omitir los display

    initial begin
        ci = 1'b0;

        for (i = 0; i < 16; i++) begin
            a = i;
            for (j = 0; j < 16; j++) begin
                b = j;
                #5 $display("%t, a:%8h, b:%8h, s:%8h, co:%b", $time, a, b, s, co);
            end
        end

        // Pruebas de borde para asegurar que los 8 bits operan
        a = 8'hFF; b = 8'h01; ci = 1'b0;
        #5 $display("\%t, a:\%8h, b:\%8h, s:\%8h, co:\%b", $time, a, b, s, co);
        
        a = 8'hFF; b = 8'hFF; ci = 1'b1;
        #5 $display("\%t, a:%8h, b:%8h, s:%8h, co:%b", $time, a, b, s, co);

        $finish;
    end
endmodule