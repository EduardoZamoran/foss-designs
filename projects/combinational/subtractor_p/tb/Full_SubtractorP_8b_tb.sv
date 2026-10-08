/*  Full Subtractor Parametrizado 8b - Test Bench Autoverificable
    Luis Eduardo Zamora Moran
    sep 23th, 2026.
*/

`timescale 1ns/1ps

module FS_8b_tb ();
    // Señales del test_bench
    parameter int N = 8;
    bit [N-1:0]A;
    bit [N-1:0]B;
    bit Bi;
    logic [N-1:0]S;
    logic Bo;
    // El Golden de 9 bits para incluir el acarreo tambien en la resta.
    logic [N:0]GoldenS; // Permiten hacer una comparacion de la salida del DUT con los valores calculados
    logic GoldenBo;
    int i;

    // Intsanciación de Módulo Parametrizado
    FS_8b #(.N(N)) DUT (.*); // El #(.N(N)) tiene que ir justo en ese lugar, sin posibilidad de cambio.

    // Task: Permite reutilizar código, pasando valores distintos para cada transacción, 
    // Permiten manejar retardos, a diferencia de las funciones.
    // Muy utilizadas en Test_Bench
    // Se declaran dentro del bloque module, para ser tarea local
    // Fuera del módulo es una tarea global, pero ya no tiene acceso a las señales dek módulo.
    // Requiere como argumentos señales de entrada y salida
    // Se puede tener señales de entrada, salida e inout.
    // Task no regresan parámetros, por lo que modificamos las variables dentro de la task
    task set_transaction (input bit [N-1:0]a, input bit [N-1:0]b, input bit bi);
        // Se pasan los parámetros para cada transacción
        A = a;
        B = b;
        Bi = bi;
        // Valores Golden son las variables de referencia
        // Valores esperados por el DUT, para comparar resultados
        GoldenS = A - B - Bi; // Cálculo de la resta
        // Para tomar en cuenta el acarreo en el bit 9, y calcular la resta completa
        // Por ello el GoldenBo es de 9 bit: Bo[N] + S[7:0]
        GoldenBo = GoldenS[N];
        #5 // Retardo para "esperar" a las señales de asignación

        // existen comparadores != e == para operadores de 2 estados (0, 1)
        // !== o === para variables de 4 estados (0, 1, X, Z)
        // como son logic, los valores son de 4 estados, por ello se requieren !== y ===
        if (GoldenS[N-1:0] !== S || GoldenBo !== Bo) begin
            $display("ERROR AT time:%3t, A:%3h, B:%3h", $time, A, B);
            $display("Expected S:%3h, Obtained S:%3h", GoldenS[N-1:0], S);
            $display("Expected Bo:%1b, Obtained Bo:%1b", GoldenBo, Bo);
        end
        else
            $display("I- time:%3h, A:%3h, B:%3h, Bi:%1b, S:%3h, Bo:%1b", $time, A, B, Bi, S, Bo);
    endtask

    // Volcar datos a un documento para observar las formas de onda.
    // Necesario para visualizar las formas de onda en gtkwave
    initial begin
        $dumpfile("Subtractor_waves.vcd");
        $dumpvars(0, FS_8b_tb);
    end

    // Secuencia de pruebas
    initial begin
        // Casos de prueba dirigidos
        // parametros: A, B, Bi
        set_transaction(0,0,0);
        set_transaction(0,1,0);
        set_transaction(0,1,1);
        set_transaction(255,1,0);
        set_transaction(255,255,0);

        // Prueba aleatoria
        for (i = 0; i < 50; i++) begin
            // Transacciones aleatorias limitando los valores random
            // a travez del operador módulo
            set_transaction($random() % 256, $random() %256, $random() % 2);
        end
        $finish;
    end
endmodule