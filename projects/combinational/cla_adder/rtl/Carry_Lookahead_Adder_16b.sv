/*  Carry Lookahead Adder - 16 bits
    Luis Eduardo Zamora Moran
    Octuber 3, 2026.
*/

module CLA_16b #(parameter N = 16) (
    input [N-1:0] Din_A, Din_B,
    input OP_sel, 
    input SU_sel,
    output [N:0] Dout
);
    // Wire para los acarreos
    logic [N:0] Cn;
    assign Cn[0] = OP_sel;

    // Wire para los g y p entre Adder y CLG
    logic [N-1:0] gi, pi;

    // Wire para los g y p entre CLG y CLG
    logic [N/4 - 1:0] g, p;

    // Wire para los G y P del Top
    logic G, P;

    // Wire para extensión de signo
    logic A_ext, B_ext;

    // Variables No sintetizables
    genvar i;
    genvar j;

    // Generación de los 16 Adders
    generate
        for (i = 0; i < N; i++) begin : Adder
            Adder Us (  .A(Din_A[i]), 
                        .B(Din_B[i] ^ OP_sel), 
                        .Ci(Cn[i]), 
                        .G(gi[i]), 
                        .P(pi[i]), 
                        .S(Dout[i])
            );
        end
    endgenerate

    // Generación de los Carry Lookahead Generators de nivel intermedio
    generate
        for (j = 0; j < N/4; j++) begin : CLG_4b
            CLG_4b Gs ( .g(gi[(j*4) +: 4]), // uso de j como slicer
                        .p(pi[(j*4) +: 4]), 
                        .C0(Cn[j*4]), 
                        .C(Cn[((j*4) + 1) +: 3]),
                        .G(g[j]),
                        .P(p[j])
            );
        end
    endgenerate

    // Carry Lookahead Generator TOP
    CLG_4b TOP (.g(g[N/4 - 1: 0]),
                .p(p[N/4 - 1: 0]),
                .C0(OP_sel),
                .C( {Cn[(N/4)*3], Cn[(N/4)*2], Cn[N/4]} ), //Concatenados
                .G(G),
                .P(P)
    );
    
    // Ultimo acarreo, con datos del CLG TOP
    assign Cn[N] = (OP_sel & P) | G;

    // Calculo de Dout[N], teniendo en cuenta extensión de signo de los operandos
    assign A_ext = (SU_sel == 1'b1) ? Din_A[N-1] : 1'b0;
    assign B_ext = (SU_sel == 1'b1) ? (Din_B[N-1] ^ OP_sel) : (1'b0 ^ OP_sel);

    assign Dout[N] = A_ext ^ B_ext ^ Cn[N];

endmodule