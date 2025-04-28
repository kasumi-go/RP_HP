MODULE Module1
	CONST robtarget Base_A:=[[369.385,-200,154.14],[0,0,1,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget Base_B:=[[369.385,0,154.14],[0,0,1,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget Base_C:=[[369.385,200,154.14],[0,0,1,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget Home:=[[513.483403604,0,507.9],[0.5,0,0.866025404,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
	CONST robtarget Setout:=[[302,0,385.8],[0,0,1,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    VAR num number{3} := [0,0,0];
    CONST num layer := 9;!???
    VAR num layer1 := 4;!???????
    

    PROC main()
        MoveJ Home,v1000,z50,sucker\WObj:=wobj0;
        MoveJ Setout,v1000,z50,sucker\WObj:=wobj0;
        WaitAI aiLayer\GT,0;
        layer1 := aiLayer;
        number{1} := layer;
        number{2} := 0;
        number{3} := 0;
        HanoiMove layer,Base_A,Base_C,Base_B,1,2,3;  
        MoveJ Setout,v1000,z50,sucker\WObj:=wobj0;
        MoveJ Home,v1000,z50,sucker\WObj:=wobj0;
    ENDPROC
    
	PROC HanoiMove(num n,robtarget A,robtarget B,robtarget C,num h_a,num h_b,num h_c)
        IF n = layer - layer1 + 1 THEN
            Move A,C,h_a,h_c;
        ELSE
            HanoiMove n - 1,A,C,B,h_a,h_c,h_b;
            Move A,C,h_a,h_c;
            HanoiMove n - 1,B,A,C,h_b,h_a,h_c;
        ENDIF
    ENDPROC
    
    PROC Move(robtarget A,robtarget C,num h_a,num h_c)
        MoveJ Offs(A,0,0,100),v7000,fine,sucker\WObj:=wobj0;
        MoveL Offs(A,0,0,-layer * 15 + number{h_a} * 15),v7000,fine,sucker\WObj:=wobj0;
        WaitTime 0.1;
        SetDO doSucker,1;
        MoveJ Offs(A,0,0,100),v7000,fine,sucker\WObj:=wobj0;
        MoveJ Offs(C,0,0,100),v7000,fine,sucker\WObj:=wobj0;
        MoveL Offs(C,0,0,-(layer - 1) * 15 + number{h_c} * 15),v7000,fine,sucker\WObj:=wobj0;
        SetDO doSucker,0;
        WaitTime 0.1;
        MoveJ Offs(C,0,0,100),v7000,fine,sucker\WObj:=wobj0;
        number{h_a} := number{h_a} - 1;
        number{h_c} := number{h_c} + 1;
    ENDPROC

ENDMODULE