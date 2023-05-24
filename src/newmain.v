module bb1(
    input wire clock,
    input wire reset,
    input wire stay,
    input wire hit,
    output reg win,
    output reg lose,
    output reg draw,
    output reg [7:0] player7SegmentsDisplay,
    output reg [7:0] dealer7SegmentsDisplay
);

	reg cardRequestAdress;
    reg [3:0] cards;

    blackJackStateMachineModule blackJackStateMachineModule_inst(
        .clock(clock),
        .reset(reset),
        .stay(stay),
        .hit(hit),
        .cards(cards),
		.cardRequestAdress(cardRequestAdress),
        .win(win),
        .lose(lose),
        .draw(draw),
        .player7SegmentsDisplay(player7SegmentsDisplay),
        .dealer7SegmentsDisplay(dealer7SegmentsDisplay)
    );
	 
	 ramModule memoryCards(
        output reg [3:0] data_out
        .clock(clock),
        .addr(cardRequestAdress),
        .reset(reset),
        .cards(cards)
	 );

    
endmodule