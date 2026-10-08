/*  Full Adder
    Luis Eduardo Zamora Moran
    September, 14, 2026.
*/

// Input se queda como wire por default en SystemVerilog.
// Entradas wire usualmente.
// Logic puede ser wire o reg.

module FA (
    input A, B, Cin,
    output logic C, 
    output logic Cout
);
    // Full Adder logic
    assign C = A ^ B ^ Cin; // Sum output
    assign Cout = (A & B) | (B & Cin) | (A & Cin); // Carry output
endmodule