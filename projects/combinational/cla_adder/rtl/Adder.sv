/*  Partial Full Adder Module
    Luis Eduardo Zamora Moran
    Octuber 3, 2026.
*/

module Adder (
    input A, B, Ci,
    output logic G, P, S
);
    assign G = A & B;
    assign P = A ^ B;
    assign S = P ^ Ci; // Reutilizando P

endmodule