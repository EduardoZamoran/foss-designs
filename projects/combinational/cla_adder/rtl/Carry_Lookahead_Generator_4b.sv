/*  4 - bit Carry Lookahead Generator
    Luis Eduardo Zamora Moran
    Octuber 3, 2026.
*/

module CLG_4b (
    input [3:0] g, p,
    input C0,
    output logic [3:1] C,
    output logic G, P
);
    
    assign C[1] = g[0] | (p[0] & C0);
    assign C[2] = g[1] | (g[0] & p[1]) | (C0 & p[0] & p[1]);
    assign C[3] = g[2] | (g[1] & p[2]) | (g[0] & p[1] & p[2]) | (C0 & p[0] & p[1] & p[2]);
    
    assign G = g[3] | (g[2] & p[3]) | (g[1] & p[2] & p[3]) | (g[0] & p[1] & p[2] & p[3]);
    assign P = p[0] & p[1] & p[2] & p[3];

endmodule