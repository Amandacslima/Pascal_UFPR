Program N07AMANDALIMA;
//TRABALHO FEITO POR AMANDA CRISTINA DA SILVA DE LIMA

{PRIMEIRO, PARA ACESSAR O ARQUIVO EM UMA DETERMINADA ORDEM, QUE N�O SEJA A SEQUENCIAL, NECESSARIAMENTE PRECISO PRIMEIRO
LER O ARQUIVO SEQUENCIALMENTE DO PRIMEIRO AO ULTIMO REGISTRO, CRIANDO UM VETOR COM DUAS INFORMA��ES POR �NDICE:
A POSICAO FISICA DO REGISTRO DENTRO DO ARQUIVO + O CAMPOS PELO QUAL QUERO ACESSAR OS REGISTROS DO ARWUIVO. }
   

USES TARDENOITE;

VAR ARQ:FILE OF REGIS;
    REG:REGIS;
    VET:VETOR;
    A,B,IND,PFI,TOTAL, ORDN, ER: INTEGER;
    ORDS, NUMS, CARS, CARSALFA: STRING;
    TOTCAR: ARRAY[1..12] OF INTEGER;
    
Begin
  ASSIGN(ARQ,'CAND.IND');
  RESET(ARQ);
  
  REPEAT
	WRITELN('DIGITE PARA ESCOLHER A ORDENA��O DA LISTA');
	WRITELN('[1]NUM. DE INSCRI��O  [2]ALFAB�TICA  [3]POR CPF  [4]CARGO E ALFAB�TICA');
	 READLN(ORDS);       
	VAL(ORDS, ORDN, ER);
	IF (ER <> 0) THEN
		WRITELN('CARACTER N�O N�MERICO')
	ELSE
		IF (ORDN >  4) OR (ORDN < 1) THEN
			WRITELN('OP��O INV�LIDA');
	WRITELN;
	UNTIL (ER = 0) AND (ORDN < 5) AND (ORDN > 0);
  WHILE (NOT EOF(ARQ)) DO
   BEGIN
    READ(ARQ,REG);
    IND:=IND+1;
    VET[IND].PF:=PFI; //COLOCA A POSICAO FISICA NO VETOR
    IF (ORDS = '1') THEN  
    	BEGIN
    		STR(REG.NUM:4, NUMS);
    		VET[IND].CC:=NUMS ;  //ACESSAR CAMPO NUM DE INSCRI��O
    	END
    ELSE
   	 IF (ORDS = '2') THEN
    		VET[IND].CC:=REG.NOME //ACESSAR CAMPO NOME
     ELSE
     	IF (ORDS = '3') THEN
     		 VET[IND].CC:=REG.CPF  //ACESSAR CAMPO CPF
    	ELSE
    		BEGIN
    			STR(REG.CAR:4, CARS);    
    			CARSALFA := CARS + REG.NOME;
    			VET[IND].CC:=CARSALFA;     //ACESSAR CAMPO CARGO ALFABETICO
    			IF(REG.CAR>0)THEN                   
	  				TOTCAR[REG.CAR]:=TOTCAR[REG.CAR]+1;
    		END;
    PFI:=PFI+1;
   END;
//MONTADO O VETOR ORDENAMOS...
  WRITELN('LIDOS=',IND:5,' REGISTROS');
  FOR A:=1 TO 20 DO
   WRITELN(A:5,VET[A].PF:5,' ',VET[A].CC);
  TOTAL:=IND;
	ORDEM(VET,TOTAL);
  FOR A:=1 TO 20 DO
   WRITELN(A:5,VET[A].PF:5,' ',VET[A].CC);
  WRITELN('ENTER PARA CONTINUAR');
  READLN;
   
//MOSTRA O CONTEUDO DO ARQUIVO USANDO COMO REFERENCIA O CAMPO PF, DO VETOR ORDENADO
  FOR B:=1 TO TOTAL DO
	 BEGIN
	  SEEK(ARQ,VET[B].PF);//POSICIONA NO ARQ NA POSICAO INDICADA PELO CAMPO pf DO VETOR ORDENADO
		READ(ARQ,REG);
//LINHA DETALHE
    IF((B-1) MOD 25 = 0)THEN
    BEGIN
      READLN;
      CLRSCR;
			WRITELN;
      WRITE('  ORD  NUM N O M E                             ===C P F=== NASCIMENTO CS  N1');
      WRITELN('  N2  N3  N4  N5  N6   SO   CG  CC CV FA');
     END;
    IF (ORDN = 4) AND (TOTCAR[REG.CAR] = B-1) THEN  {CONCERTAR DEPOIS}
    	WRITELN;	
		WRITE(B:5,REG.NUM:5,' ',REG.NOME,' ',REG.CPF,' ',REG.DATA.DIA,'/',REG.DATA.MES,'/',REG.DATA.ANO, REG.CAR:3);
		FOR A:=1 TO 6 DO
		 WRITE(REG.NOTAS[A]:4);
		WRITELN(REG.SOM:5,REG.CLG:5,REG.CLC:4,REG.CCL:3,REG.FALTA:3);
	 END;     
	TERMINE;  
End.