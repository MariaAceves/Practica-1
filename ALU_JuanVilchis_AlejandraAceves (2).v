module ALU_JuanVilchis_AlejandraAceves(

	
input [3:0] InputA,InputB,OP,
output reg[3:0] Result,
output reg[4:0] cResult,
output reg [4:0] Status
);


integer i,parity=0,sign=0;


always @(*)
    begin
			if(parity >=0) parity = 0; //Resets parity value
		case(OP)
		
		/* 0 */ 	4'b0000: cResult = -InputA; //•	2's complement (8)	
		/* 1 */ 	4'b0001: cResult = InputA <<< 1; //•	Arithmetic shift (left (11))
		/* 2 */ 	4'b0010: cResult = InputA >>> 1; //•	Arithmetic shift (right (12))
		/* 3 */ 	4'b0011: cResult = InputA << 1; //•	Logical shift (left (11))
		/* 4 */ 	4'b0100: cResult = InputA >> 1; //•	Logical shift (right (12))
		/* 5 */ 	4'b0101: cResult = {InputA[3:0],InputA[3]}; //•	Rotation (left (13))
		/* 6 */ 	4'b0110: cResult = {InputA[0],InputA[3:1]}; //•	Rotation (right (14))
      /* 7 */ 	4'b0111: cResult = InputA + InputB;  //•	Sum (1)
      /* 8 */ 	4'b1000: cResult= InputA - InputB; //•	Subtraction (2)
		/* 9 */ 	4'b1001: cResult = InputA & InputB;    //•	And (3)
		/* 10 */ 4'b1010: cResult = InputA | InputB; //•	Or (4)
		/* 11 */ 4'b1011: cResult = !InputA; //•	Not (5)
		/* 12 */ 4'b1100: cResult = InputA ^ InputB; //•	Xor (6)
		/* 13 */ 4'b1101: cResult = ~InputA; //•	1’s complement (7)
		
		endcase
		
		Result = cResult;
		
		for(i = 0; i < 4; i = i + 1) begin //Counts Ones ***Por ver***
			if(Result[i] == 1'b1) parity = parity + 1;
		end	
		
		if(Result == 4'b0000) Status[4] = 1; else Status[4] = 0; //[Z] Zero Flag
		if(Result[3] == 1) Status[3] = 1; else Status[3] = 0; //[S] Value Flag
		
		if(cResult[4] == 1) Status[2] = 1; else Status[2] = 0;  //[C] Carry Flag
		
		if((InputA< 4'b1000) && (InputB< 4'b1000)) sign = 1; else if ((InputA >= 4'b1000) && (InputB >= 4'b1000)) sign = 0; else sign = 2; //Positive or Negative
		if((Result >= 4'b1000) && (sign == 1)) Status[1] = 1; else if ((Result < 4'b1000) && (sign == 0)) Status[1] = 1; else Status[1] = 0; //[V] Overflow Flag
		
		if(parity % 2) Status[0] = 0; else if(parity == 0) Status[0] = 0; else Status[0] = 1; //[P] Parity Flag
		
		
	 end
	 
	 
endmodule
		
	