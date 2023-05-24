module shuffle (
    input wire clk,
    input wire rst,
    input wire start,
    output reg [5:0] shuffled_cards [0:51]
);

reg [5:0] unshuffled_cards [0:51];
reg [7:0] lfsr = 8'b1; // Linear Feedback Shift Register (LFSR)
reg [5:0] idx;
integer i;

// Inicializando o array unshuffled_cards com valores de 0 a 51
initial begin
    for (i = 0; i < 52; i = i + 1) begin
        unshuffled_cards[i] = i;
    end
end

// LFSR para gerar números pseudo-aleatórios
always @(posedge clk) begin
    if (rst) begin
        lfsr <= 8'b1;
    end else begin
        lfsr <= {lfsr[6:0], lfsr[7] ^ lfsr[5]};
    end
end

// Algoritmo Fisher-Yates
always @(posedge clk or posedge rst) begin
    if (rst) begin
        for (i = 0; i < 52; i = i + 1) begin
            shuffled_cards[i] <= unshuffled_cards[i];
        end
    end else if (start) begin
        for (i = 51; i > 0; i = i - 1) begin
            idx = lfsr % (i + 1); // j ← número aleatório inteiro tal que 0 ≤ j ≤ i
            // Trocar shuffled_cards[i] e shuffled_cards[idx]
            begin
                reg [5:0] temp;
                temp = shuffled_cards[i];
                shuffled_cards[i] <= shuffled_cards[idx];
                shuffled_cards[idx] <= temp;
            end
        end
    end
end

endmodule
