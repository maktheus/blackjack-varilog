module main(
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

    // Declaração da memória
    reg [3:0] memory [0:51];

    // Sinal de controle de embaralhamento
    reg shuffle;

    // Módulo de embaralhamento
    wire [5:0] shuffled_cards [0:51];
    shuffle shuffle_inst(.clk(clock), .rst(reset), .start(shuffle), .shuffled_cards(shuffled_cards));
    
    blackJackStateMachineModule blackJackStateMachineModule_inst(
        .clock(clock),
        .reset(reset),
        .stay(stay),
        .hit(hit),
        .cards(shuffled_cards[0]),
        .win(win),
        .lose(lose),
        .draw(draw),
        .player7SegmentsDisplay(player7SegmentsDisplay),
        .dealer7SegmentsDisplay(dealer7SegmentsDisplay)
    );

    
endmodule