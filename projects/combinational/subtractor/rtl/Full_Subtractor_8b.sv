/*  8-bit Full Subtractor
    Luis Eduardo Zamora Moran
    Sep 23th, 2026.
*/

(* blackbox *)

module FS_8b (
    input logic [7:0] A, B,
    input logic Bi,
    output logic [7:0] S,
    output logic Bo
);

    // Cables internos
    logic B1, B2, B3, B4, B5, B6, B7;

    // Instanciación por nombres, no importa tanto el orden,
    // ya que cada señal se "conecta" directamente a la señal
    // del modulo instanciado

    FS U0 (.A(A[0]), .B(B[0]), .Bi(Bi), .S(S[0]), .Bo(B1));
    FS U1 (.A(A[1]), .B(B[1]), .Bi(B1), .S(S[1]), .Bo(B2));
    FS U2 (.A(A[2]), .B(B[2]), .Bi(B2), .S(S[2]), .Bo(B3));
    FS U3 (.A(A[3]), .B(B[3]), .Bi(B3), .S(S[3]), .Bo(B4));
    FS U4 (.A(A[4]), .B(B[4]), .Bi(B4), .S(S[4]), .Bo(B5));
    FS U5 (.A(A[5]), .B(B[5]), .Bi(B5), .S(S[5]), .Bo(B6));
    FS U6 (.A(A[6]), .B(B[6]), .Bi(B6), .S(S[6]), .Bo(B7));
    FS U7 (.A(A[7]), .B(B[7]), .Bi(B7), .S(S[7]), .Bo(Bo));
    
endmodule