/*  Full Adder - Celda Sumadora Completa
    Luis Eduardo Zamora Moran
    September, 14, 2026.
*/

module FA (
    input A, B, Cin,
    output logic S, 
    output logic Cout
);
    // Full Adder logic
    assign S = A ^ B ^ Cin; // Sum output
    assign Cout = (A & B) | (B & Cin) | (A & Cin); // Carry output
endmodule