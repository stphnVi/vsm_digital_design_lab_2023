module alu #(parameter n = 32) (
    input logic [n-1:0] SrcA,
    input logic [n-1:0] SrcB,
    input logic [1:0] ALUControl,
    output logic [n-1:0] ALUResult,
    output logic [3:0] ALUFlags
);

    logic [n-1:0] selected_result;
	 logic carryIn;
	 logic [n:0] sumres;
	 logic [n-1:0] SrcBSel;
	 assign carryIn = ALUControl[0];
	 assign SrcBSel = ALUControl[0]? SrcB: ~SrcB;
	 assign sumres = SrcA + SrcBSel + carryIn;
	 
	 logic flagCarry, flagOverflow;

    always_comb begin
		  flagCarry =0;
		  flagOverflow = 0;
        case (ALUControl)
            3'b000, 3'b001: begin 
					{flagCarry, selected_result} = sumres;
					flagOverflow = ~(ALUControl[0]^SrcA[n-1]^SrcB[n-1]) & (SrcA[n-1]^selected_result[n-1]);
				end
            3'b010: selected_result = SrcA & SrcB;
            3'b011: selected_result = SrcA | SrcB;
            // Puedes añadir más operaciones según sea necesario.

            default: selected_result = '0;
        endcase
    end

    // Generación de flags
	 assign ALUFlags[3] = (selected_result[n-1]); // negativo
    assign ALUFlags[2] = (selected_result == 0); //zero
    assign ALUFlags[1] = flagCarry;
    assign ALUFlags[0] = flagOverflow;

    assign ALUResult = selected_result;

endmodule