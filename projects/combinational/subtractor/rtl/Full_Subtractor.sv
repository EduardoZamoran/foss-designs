/*  Full Subtractor
    Luis Eduardo Zamora Moran
    Sep, 23th. 2026
*/

(* blackbox *)

module FS (
    input A, B, Bi,
    output logic S, 
    output logic Bo 
);
    
    assign S = A ^ B ^ Bi; // Substraction
    assign Bo = (~A & B) | (~A & Bi) | (B & Bi); // Borrow out

endmodule