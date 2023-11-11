// ALUTest.sv

module ALUTest;

  logic [3:0] SrcA;
  logic [3:0] SrcB;
  logic [1:0] operation;
  logic [3:0] result;
  logic Z, C, V, N; // Flags

  // Instanciamos la ALU
  ALU #(4) myALU (
    .SrcA(SrcA),
    .SrcB(SrcB),
    .operation(operation),
    .result(result),
    .Z(Z),
    .C(C),
    .V(V),
    .N(N)
  );

  initial begin
    // Prueba de suma
    SrcA = 4'b0010;
    SrcB = 4'b0011;
    operation = 2'b00;
    #10; // Esperar 10 unidades de tiempo
    $display("Resultado de la suma: %b", result);
    $display("Flag Z (Cero): %b", Z);
    $display("Flag C (Acarreo): %b", C);
    $display("Flag V (Desborde): %b", V);
    $display("Flag N (Negativo): %b", N);

    // Prueba de resta
    SrcA = 4'b1100;
    SrcB = 4'b1010;
    operation = 2'b01;
    #10; // Esperar 10 unidades de tiempo
    $display("Resultado de la resta: %b", result);
    $display("Flag Z (Cero): %b", Z);
    $display("Flag C (Acarreo): %b", C);
    $display("Flag V (Desborde): %b", V);
    $display("Flag N (Negativo): %b", N);

    // Prueba de AND
    SrcA = 4'b0000;
    SrcB = 4'b1111;
    operation = 2'b10;
    #10; // Esperar 10 unidades de tiempo
    $display("Resultado del AND: %b", result);
    $display("Flag Z (Cero): %b", Z);
    $display("Flag C (Acarreo): %b", C);
    $display("Flag V (Desborde): %b", V);
    $display("Flag N (Negativo): %b", N);

    $finish; // Terminar la simulación
  end
endmodule
