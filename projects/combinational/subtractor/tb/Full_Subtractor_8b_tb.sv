/*  Restador Binario 8b - Test Bench
    Luis Eduardo Zamora Moran
    sep 23th, 2026.
*/

`timescale 1ns/1ps

module FS_8b_tb;
    int i, j;
    bit [7:0]A;
    bit [7:0]B;
    bit Bi;
    bit [7:0]S;
    bit Bo;

    FS_8b DUT(A, B, Bi, S, Bo);
    
    // Volcar datos a un documento para observar las formas de onda.
    initial begin
        $dumpfile("restador_waves.vcd");
        $dumpvars(0, FS_8b_tb);
    end

    // Casos especificos y random
    initial begin
        // Casos específicos
        A = 8'h00; B = 8'h00; Bi = 1'b0;
        #5 $display("\%t, A:\%8h, B:\%8h, Bi:\%8h,S:\%8h, Bo:\%b", $time, A, B, Bi, S, Bo);
        
        A = 8'h00; B = 8'h01; Bi = 1'b0;
        #5 $display("\%t, A:\%8h, B:\%8h, Bi:\%8h,S:\%8h, Bo:\%b", $time, A, B, Bi, S, Bo);

        A = 8'h00; B = 8'h01; Bi = 1'b1;
        #5 $display("\%t, A:\%8h, B:\%8h, Bi:\%8h,S:\%8h, Bo:\%b", $time, A, B, Bi, S, Bo);

        A = 8'hFF; B = 8'h01; Bi = 1'b0;
        #5 $display("\%t, A:\%8h, B:\%8h, Bi:\%8h,S:\%8h, Bo:\%b", $time, A, B, Bi, S, Bo);

        A = 8'hFF; B = 8'hFF; Bi = 1'b0;
        #5 $display("\%t, A:\%8h, B:\%8h, Bi:\%8h,S:\%8h, Bo:\%b", $time, A, B, Bi, S, Bo);

        A = 8'hAA; B = 8'h55; Bi = 1'b0;
        #5 $display("\%t, A:\%8h, B:\%8h, Bi:\%8h,S:\%8h, Bo:\%b", $time, A, B, Bi, S, Bo);


        // Valores random
        for (i = 0; i < 10; i++ ) begin
            A = $random()%256;
            B = $random()%256;
            Bi = $random()%2;
            #5 $display("\%t, A:\%8h, B:\%8h, Bi:\%8h,S:\%8h, Bo:\%b", $time, A, B, Bi, S, Bo);
        end
        
        $finish;
    end
endmodule