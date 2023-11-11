module ALU #(parameter n = 4) (
  input logic [n-1:0] SrcA,
  input logic [n-1:0] SrcB,
  input logic [1:0] operation, // Selector de operación
  output logic [n-1:0] result,
  output logic Z, // Flag de cero
  output logic C, // Flag de acarreo
  output logic V, // Flag de desborde
  output logic N // Flag de negativo
);

  logic [n-1:0] selected_result;

  always_comb begin
    case (operation)
      2'b00: selected_result = SrcA + SrcB; 
      2'b01: selected_result = SrcA - SrcB; 
      2'b10: selected_result = SrcA & SrcB; // Cambiado de '&&' a '&'
      2'b11: selected_result = SrcA | SrcB;

      default: selected_result = '0; // Valor por defecto
    endcase
  end

  // Generación de flags
  assign Z = (selected_result == 0);
  assign C = selected_result[n-1];
  assign V = (selected_result[n-1] ^ C);
  assign N = selected_result[n-1];

  assign result = selected_result;
endmodule

