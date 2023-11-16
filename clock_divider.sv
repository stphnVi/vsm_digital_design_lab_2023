// clock divider 
module clock_divider #(parameter div_value = 0) (
    input logic clk, // 50 MHz
    output logic divided_clk // 25 MHz
);

    // Valor de división = 100 MHz / (2 * frecuencia deseada) - 1
    // Contador
    integer counter_value = 0;

    always @(posedge clk)
    begin
        if (counter_value == div_value)
        begin
            counter_value = 0;
            divided_clk = ~divided_clk;
        end
        else
        begin
            counter_value = counter_value + 1;
        end
    end

endmodule