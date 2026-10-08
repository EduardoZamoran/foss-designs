/*  Full Subtractor Parametrizado - 8 bits
    Luis Eduardo Zamora Moran
    Sep 23, 2026.
*/

// Modulo parametrizado permite facilidad al ser instanciado 
// dentro de otro módulo.

module FS_8b #(parameter N = 8)( // El valor por defecto para la instanciación es 8.
        input [N-1:0]A, B,
        input Bi,
        output logic [N-1:0]S,
        output logic Bo
    );
    // Cables internos
    logic [N:0] Br;

    // asignacion Borrow extremos
    assign Br[0] = Bi; // Bi al primer elemento del vector Br
    assign Bo = Br[N];

    genvar i;

    // Generación de Hw a travez de instanciaciones cíclicas
    generate
        for (i = 0; i < N; i++) begin : instancia// Una instancia por iteración
            FS Us (.A(A[i]), .B(B[i]), .Bi(Br[i]), .S(S[i]), .Bo(Br[i+1])); 
        end
    endgenerate
endmodule