/*  Full Adder 8 bits
    Luis Eduardo Zamora Moran
    September, 14, 2026.
*/

module FA_8bits (
input  logic [7:0] A, B,
input  logic       Cin,
output logic [7:0] C,      // Resultado de la suma
output logic       Cout   // Acarreo de salida final
);

    // Cables internos 
    logic c1, c2, c3, c4, c5, c6, c7;

    // Instanciación
    FA U1 ( .A(A[0]), .B(B[0]), .Cin(Cin), .C(C[0]), .Cout(c1)   );
    FA U2 ( .A(A[1]), .B(B[1]), .Cin(c1),  .C(C[1]), .Cout(c2)   );
    FA U3 ( .A(A[2]), .B(B[2]), .Cin(c2),  .C(C[2]), .Cout(c3)   );
    FA U4 ( .A(A[3]), .B(B[3]), .Cin(c3),  .C(C[3]), .Cout(c4)   );
    FA U5 ( .A(A[4]), .B(B[4]), .Cin(c4),  .C(C[4]), .Cout(c5)   );
    FA U6 ( .A(A[5]), .B(B[5]), .Cin(c5),  .C(C[5]), .Cout(c6)   );
    FA U7 ( .A(A[6]), .B(B[6]), .Cin(c6),  .C(C[6]), .Cout(c7)   );
    FA U8 ( .A(A[7]), .B(B[7]), .Cin(c7),  .C(C[7]), .Cout(Cout) );

endmodule