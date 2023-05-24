module blackJackStateMachineModule(
    input wire clock,
    input wire reset,
    input wire stay,
    input wire hit,
    input wire [3:0] cards,
    output reg win,
    output reg lose,
    output reg draw,
    output reg [7:0] player7SegmentsDisplay,
    output reg [7:0] dealer7SegmentsDisplay
);

    // Declaração dos estados
    parameter S0 = 2'b00; // Game Start
    parameter S1 = 2'b01; // Player Turn
    parameter S2 = 2'b10; // Dealer Turn
    parameter S3 = 2'b11; // End Game

    // Declaração dos sinais de estado
    reg [1:0] state, next_state;
    reg dealerStay, playerStay;

    // Score registers
    reg [5:0] playerScore, dealerScore;

    // Ace logic
    wire isAce = cards == 4'b1010;
    wire cardValue = isAce ? (playerScore + 11 <= 6'd21 ? 6'd11 : 6'd1) : cards;

    // Inicialização dos estados
    initial begin
        state = S0;
        next_state = S0;
        playerScore = 6'd0;
        dealerScore = 6'd0;
        playerStay = 1'b0;
        dealerStay = 1'b0;
    end

    // Lógica de transição de estados
    always @(posedge clock or posedge reset) begin
        if (reset) state = S0;
        else state = next_state;
    end


    // Lógica de saída e próximos estados
    always @(state or hit or stay or dealerStay or playerStay or cards or reset ) begin
        // Reset
        win = 0; lose = 0; draw = 0; 
        player7SegmentsDisplay = 8'b00000000; 
        dealer7SegmentsDisplay = 8'b00000000; 
        next_state = state;

        case(state)
            S0: begin // Game Start
                if(cards != 4'b0000) begin
                    playerScore = playerScore + cardValue;
                    player7SegmentsDisplay = playerScore;
                    next_state = S1;
                end
            end

            S1: begin // Player Turn
                if(reset) begin
                    next_state = S0;
                end
                else if(stay) begin
                    next_state = S2;
                    playerStay = 1;
                end
                else if(hit && cards != 4'b0000) begin
                    playerScore = playerScore + cardValue;
                    player7SegmentsDisplay = playerScore;
                    if(playerScore > 6'd21) begin
                        win = 0; lose = 1; draw = 0;
                        next_state = S3; // End Game
                    end
                end
                else if(dealerStay && playerStay ) begin
                    next_state = S3; // End Game
                end

            end

            S2: begin // Dealer Turn
                if (reset) begin
                    next_state = S0;
                end
                // Dealer gets cards if score is 16 or less
                if(dealerScore <= 6'd16 && cards != 4'b0000) begin
                    dealerScore = dealerScore + cardValue;
                    dealer7SegmentsDisplay = dealerScore;
                    if(dealerScore > 6'd21) begin
                        win = 1; lose = 0; draw = 0;
                        next_state = S3; // End Game
                    end
                end
                else if(dealerStay && playerStay ) begin
                    next_state = S3; // End Game
                end
                else if(dealerScore >= 6'd17 || dealerStay) begin
                    next_state = S2; // Dealer stays
                    dealerStay = 1;
                end
            end

            S3: begin // End Game
                // Result display logic.
                player7SegmentsDisplay = playerScore;
                dealer7SegmentsDisplay = dealerScore;

                if(dealerScore > 6'd21) begin
                    win = 1; lose = 0; draw = 0;
                end
                else if (playerScore > 6'd21) begin
                    win = 0; lose = 1; draw = 0;
                end
                else if(playerScore > dealerScore) begin
                        win = 1; lose = 0; draw = 0;
                end
                else if(playerScore < dealerScore) begin
                    win = 0; lose = 1; draw = 0;
                end
                else begin
                    win = 0; lose = 0; draw = 1;
                end

                // State S0 is the next state after the end of the game
                if(reset) begin
                    next_state = S0;
                end
            end
        endcase
    end
endmodule

