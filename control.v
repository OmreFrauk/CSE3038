module control(in,regdest,alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop1,aluop2);
input [5:0] in;
output regdest,alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop1,aluop2,brnv,bgtzal,balv,jmnor,jrsal;
wire rformat,lw,sw,beq;
assign rformat=~|in;
assign lw=in[5]& (~in[4])&(~in[3])&(~in[2])&in[1]&in[0];
assign sw=in[5]& (~in[4])&in[3]&(~in[2])&in[1]&in[0];
assign beq=~in[5]& (~in[4])&(~in[3])&in[2]&(~in[1])&(~in[0]);
assign regdest=rformat;
assign alusrc=lw|sw;
assign memtoreg=lw;
assign regwrite=rformat|lw;
assign memread=lw;
assign memwrite=sw;
assign branch=beq;
assign aluop1=rformat;
assign aluop2=beq;
assign brnv = (~in[5])&in[4]&(~in[3])&in[2]&(~in[1])&(~in[0]);
assign bgtzal=(~in[5])&in[4]&(~in[3])&(~in[2])&(~in[1])&in[0];
assign balv=(~in[5])&in[4]&(~in[3])&(~in[2])&(~in[1])(~&in[0]);
assign jmnor = in[5]&(~in[4])&(~in[3])&in[2]&in[1]&(~in[0]);
assign jrsal = (~in[5])&in[4]&(~in[3])&(~in[2])&(~in[1])&in[0];

endmodule
