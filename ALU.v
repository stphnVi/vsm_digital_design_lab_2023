/**Decodificador ALU
 00 -> Add
 01 -> Sub
 10 -> And
 11 -> Or
**/

module ALU #(parameter n = 4) (
  input [n-1:0] SrcA,
  input [n-1:0] SrcB,
  input [1:0] operation, // Selector de operación
  output [n-1:0] result,
  output Z, // Flag de cero
  output C, // Flag de acarreo
  output V, // Flag de desborde
  output N // Flag de negativo
);

  reg [n-1:0] selected_result;
  always @* begin
    case (operation)
      2'b00: selected_result = SrcA + SrcB; 
      2'b01: selected_result = SrcA - SrcB; 
      2'b10: selected_result = SrcA && SrcB;
      2'b11: selected_result = SrcA || SrcB;

      default: selected_result = 4'b0000; // Valor por defecto
    endcase
  end

// Generación de flags
  assign Z = (selected_result == 0);
  assign C = selected_result[n-1];
  assign V = (selected_result[n-1] ^ C);
  assign N = selected_result[n-1];

  assign result = selected_result;
endmodule

//Testbench para la ALU
module tb_alu;

  reg [3:0] SrcA;
  reg [3:0] SrcB;
  reg [1:0] operation;
  wire [3:0] result;
  wire Z, C, V, N; // Flags

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


