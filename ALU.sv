module alu #(parameter n = 32) (
    input logic [n-1:0] SrcA,
    input logic [n-1:0] SrcB,
    input logic [2:0] ALUControl,
    output logic [n-1:0] ALUResult,
    output logic [3:0] ALUFlags
);

    logic [n-1:0] selected_result;

    always_comb begin
        case (ALUControl)
            3'b000: selected_result = SrcA + SrcB;
            3'b001: selected_result = SrcA - SrcB;
            3'b010: selected_result = SrcA & SrcB;
            3'b011: selected_result = SrcA | SrcB;
            // Puedes añadir más operaciones según sea necesario.

            default: selected_result = '0;
        endcase
    end

    // Generación de flags
    assign ALUFlags[0] = (selected_result == 0);
    assign ALUFlags[1] = (selected_result < 0);
    assign ALUFlags[2] = (selected_result[n-1] & ~SrcB[n-1] & ~selected_result[n-1]) | (~SrcA[n-1] & SrcB[n-1] & selected_result[n-1]);
    assign ALUFlags[3] = (selected_result[n-1] ^ ALUFlags[2]);

    assign ALUResult = selected_result;

endmodule