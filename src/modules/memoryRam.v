module ramModule(
    input wire clk,
    input wire wr_en,
    input wire [5:0] addr,
    input wire [3:0] data_in,
    output reg [3:0] data_out
);

    // Declaração da memória
    reg [3:0] memory [0:51];

    // Sinal de controle de embaralhamento
    reg shuffle;

    // Módulo de embaralhamento
    wire [5:0] shuffled_cards [0:51];
    shuffle shuffle_inst(.clk(clk), .rst(wr_en), .start(shuffle), .shuffled_cards(shuffled_cards));


    // Inicialização da memória com o baralho de cartas
    initial begin
        memory[0] = 4'd1;  // As
        memory[1] = 4'd2;  // 2
        memory[2] = 4'd3;  // 3
        memory[3] = 4'd4;  // 4
        memory[4] = 4'd5;  // 5
        memory[5] = 4'd6;  // 6
        memory[6] = 4'd7;  // 7
        memory[7] = 4'd8;  // 8
        memory[8] = 4'd9;  // 9
        memory[9] = 4'd10; // 10
        memory[10] = 4'd10; // J
        memory[11] = 4'd10; // Q
        memory[12] = 4'd10; // K
        memory[13] = 4'd1;  // As
        memory[14] = 4'd2;  // 2
        memory[15] = 4'd3;  // 3
        memory[16] = 4'd4;  // 4
        memory[17] = 4'd5;  // 5
        memory[18] = 4'd6;  // 6
        memory[19] = 4'd7;  // 7
        memory[20] = 4'd8;  // 8
        memory[21] = 4'd9;  // 9
        memory[22] = 4'd10; // 10
        memory[23] = 4'd10; // J
        memory[24] = 4'd10; // Q
        memory[25] = 4'd10; // K
        memory[26] = 4'd1;  // As
        memory[27] = 4'd2;  // 2
        memory[28] = 4'd3;  // 3
        memory[29] = 4'd4;  // 4
        memory[30] = 4'd5;  // 5
        memory[31] = 4'd6;  // 6
        memory[32] = 4'd7;  // 7
        memory[33] = 4'd8;  // 8
        memory[34] = 4'd9;  // 9
        memory[35] = 4'd10; // 10
        memory[36] = 4'd10; // J
        memory[37] = 4'd10; // Q
        memory[38] = 4'd10; // K
        memory[39] = 4'd1;  // As
        memory[40] = 4'd2;  // 2
        memory[41] = 4'd3;  // 3
        memory[42] = 4'd4;  // 4
        memory[43] = 4'd5;  // 5
        memory[44] = 4'd6;  // 6
        memory[45] = 4'd7;  // 7
        memory[46] = 4'd8;  // 8
        memory[47] = 4'd9;  // 9
        memory[48] = 4'd10; // 10
        memory[49] = 4'd10; // J
        memory[50] = 4'd10; // Q
        memory[51] = 4'd10; // K
        $display("Inicialização concluída. Iniciando embaralhamento...");
        shuffle = 1;
    end

    always @(posedge clk) begin
        if(wr_en) begin
            // Escrever na memória
            memory[addr] <= data_in;
            $display("Escrevendo %d na posição %d", data_in, addr);
        end
        else if(shuffle) begin
            // Embaralhar a memória
            integer i;
            for (i = 0; i < 52; i = i + 1) begin
                memory[i] <= memory[shuffled_cards[i]];
            end
            shuffle = 0;  // Desabilitar o embaralhamento
            $display("Embaralhamento concluído");
        end
        else begin
            // Ler da memória
            data_out <= memory[addr];
            $display("Lendo %d da posição %d", data_out, addr);
        end
    end

endmodule