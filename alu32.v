module alu32 (Result,
A,
B,
ALUOp,
Zero,
Overflow,
GreaterThanZero
   
);
output reg [31:0] Result; // ALU result
input [31:0] A;       // First operand
input [31:0] B;       // Second operand
input [2:0] ALUOp;    // ALU operation control signal

output Zero;          // Zero flag
output reg Overflow;   // Overflow flag
output reg GreaterThanZero; // Greater than zero flag
reg [31:0] less;

assign Zero = (Result == 0); // Zero flag logic
    

always @(*) begin 
Overflow = 0; // Default no overflow
GreaterThanZero = 0; // Default not greater than zero
case (ALUOp)
    3'b010: begin // ADD operation
        {Overflow, Result} = {A[31], A} + {B[31], B};
        Overflow = (A[31] == B[31]) && (Result[31] != A[31]);
        
    end
    3'b110: begin // SUB operation
        {Overflow, Result} = {A[31], A} - {B[31], B};
        Overflow = (A[31] != B[31]) && (Result[31] != A[31]);
        GreaterThanZero = (A > 0);
        
    end
    3'b111: begin less=A+1+(~B);	//ALU control line=111, set on less than
    if (less[31]) Result=1;	
    else Result=0;
    end

    3'b000: Result = A & B; // AND operation
    3'b001: Result = A | B; // OR operation
    3'b101: Result = ~(A | B); // NOR operation


    default: Result = 0;
    
endcase
end

endmodule
