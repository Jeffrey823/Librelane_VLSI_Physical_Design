`timescale 1ns / 1ps

module Micro8088(CLK,RST,HOLD,TEST,INTR,NMI,Dir,DataBus,RD,WR,IOM,INTA,HLDA
//					 ,RIPE,FL,DATA,INSTOUT,PREI,PREE,PREW,CUENTA
					 );

	input CLK,RST,HOLD,TEST,INTR,NMI;
	output wire [19:0] Dir;
	output wire RD,WR,IOM,INTA,HLDA;
	inout [7:0] DataBus;

//Señales Temporales para pruebas
//	output wire [15:0] RIPE;output [6:0] FL;output [15:0] INSTOUT;output wire [15:0] DATA;output [3:0] PREI;output [2:0] PREE;output [1:0] PREW;output [2:0] CUENTA;
	
//Buffers de salida
	wire [19:0] Dirm;
	wire RDm,WRm,IOMm;
	Buffer20bits BufDir(Dirm,~HLDA,Dir);
	Buffer1bit BufRD(RDm,~HLDA,RD);
	Buffer1bit BufWR(WRm,~HLDA,WR);
	Buffer1bit BufIOM(IOMm,~HLDA,IOM);
	
//Redes
	wire [15:0] INSTOUT; 
	wire [5:0] opALU;
	wire [3:0] opER,opEW;
	wire [3:0] DirST;
	wire [4:0] opMux;
	wire WA,WB,WD,ENADi,WBDE,WINST,FINDi,LDI,RNMI;
	wire [2:0] opFL;
	wire [1:0] WRA;
	wire [1:0] ValFi;
	wire [1:0] opIE;
	wire WBDI,WIPDE,W;
	wire [1:0] WRDO;
	wire [1:0] opI;
	wire ENAIP,WIPDI,RSTREG,ENACD,opA,opB,ENARD,BOUT,ENASI;
	wire [2:0] CUENTA;
	wire [6:0] FL;
	
//Control del Micro
	ControlMicro CDM(CLK,RST,HOLD,TEST,
			   INSTOUT,FL,FINDi,opALU,opER,opEW,DirST,opMux,WA,WB,WD,WRA,ENADi,opFL,WBDE,LDI,RNMI,WINST,ValFi,opIE,WBDI,WIPDE,WRDO,W,
				opI,ENAIP,WIPDI,RSTREG,ENACD,opA,opB,ENARD,BOUT,ENASI,CUENTA,RDm,WRm,IOMm,INTA,HLDA
//				,PREI,PREE,PREW
				);
				
//Modulo del Micro
	CuerpoMicro MDM(CLK,RST,INTR,NMI,
						 opALU,opER,opEW,DirST,opMux,WA,WB,WD,WRA,ENADi,opFL,WBDE,LDI,RNMI,WINST,ValFi,opIE,WBDI,WIPDE,W,WRDO,
						 opI,ENAIP,WIPDI,RSTREG,ENACD,opA,opB,ENARD,BOUT,ENASI,CUENTA,
						 FL,INSTOUT,Dirm,DataBus,FINDi
//						,RIPE,DATA
						 );

endmodule
