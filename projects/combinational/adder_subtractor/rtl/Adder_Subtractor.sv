/*  Adder - Subtractor module
    Luis Eduardo Zamora Moran
    October 2, 2026.
*/

// Modulo Parametrizado
module Adder_Subtractor #(parameter N = 8) (
    input logic [N-1:0] Din_A, Din_B, // Operandos
    input logic OP_sel,             // 0 = Suma, 1 = Resta
    input logic [1:0] SU_sel,       // 00 = A y B sin signo, 01 = Ass y Bcs, 10 = Acs y Bss, 11 = A y B con signo
    output logic [N:0] Dout       // Output
);

    // Señal de acarreo
    logic [N+1:0] Cn;

    // Acarreo inicial y final
    assign Cn[0] = OP_sel; // Acarreo inicial
    // Acarreo final queda flotando, pues no se utiliza.

    // Extensión de signo para A y B
    logic [N:0] A_ext, B_ext;
    
    assign A_ext = (SU_sel[1] == 1'b1) ? {Din_A[N-1], Din_A} : {1'b0, Din_A}; // Extensión de signo para A
    assign B_ext = (SU_sel[0] == 1'b1) ? {Din_B[N-1], Din_B} : {1'b0, Din_B}; // Extensión de signo para B

    genvar i;

    // Generación de N + 1 Full Adders por extensión de signo
    generate
        for (i = 0; i <= N; i++) begin : FA
            FA Us (.A(A_ext[i]), .B(B_ext[i] ^ OP_sel), .Cin(Cn[i]), .S(Dout[i]), .Cout(Cn[i+1]));
        end
    endgenerate

endmodule