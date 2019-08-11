;========================================================================================
; --Register-----|--Callee Save--|----------------------------Description----------------
; |  %rax        |               | 函数返回值寄存器;也用于idiv and imul指令
; |  %rbx        |       yes     |  
; |  %rcx        |               | 函数第4个入参
; |  %rdx        |               | 函数第3个入参;也用于idiv and imul指令
; |  %rsp        |               | stack pointer,通常指向栈顶位置, pop和push操作会改变%rsp的值
; |  %rbp        |       yes     | frame pointer
; |  %rsi        |               | 函数第2个入参
; |  %rdi        |               | 函数第1个入参
; |  %r8         |               | 函数第5个入参
; |  %r9         |               | 函数第6个入参
; |  %r10        |               |
; |  %r11        |               |
; |  %r12-%r15   |       yes     |
; "Caller Save"即寄存器的值是由"调用者(父函数)保存",父函数必须push保存好Caller Save register
;    后再调用子函数
; "Callee Save"即寄存器的值是由"被调用者(子函数)保存",父函数无需保存这些寄存器值由子函数先push
;    返回时再pop这些寄存器、子函数push和pop之间可以使用这些寄存器
;========================================================================================


section .text
;========================================================================================
; extern double CalcSum_(float a, double b, float c, double d, float e, double f);
; code is intel风格的汇编代码
global CalcSum_
CalcSum_:
    cvtss2sd xmm0,xmm0                  ;promote a to DPFP
    addsd xmm0,xmm1                     ;xmm0 = a + b

    cvtss2sd xmm2,xmm2                  ;promote c to DPFP 
	addsd xmm0,xmm2                     ;xmm0 = a + b + c 
	addsd xmm0,xmm3                     ;xmm0 = a + b + c + d

    cvtss2sd xmm4,xmm4                  ;promote c to DPFP
    addsd xmm0,xmm4                     ;xmm0 = a + b + c + d + e
    addsd xmm0,xmm5                ;xmm0 =  a + b + c + d + e + f

    ret
;========================================================================================
;extern double CalcDist_(int x1, double x2, long long y1, double y2, float z1, short z2);
; code is intel风格的汇编代码
global CalcDist_
CalcDist_:
; Calculate xd = (x2 - x1) * (x2 - x1)
    cvtsi2sd xmm3,edi                   ;convert x1 to DPFP
    subsd xmm0,xmm3                     ;xmm1 = x2 - x1
    mulsd xmm0,xmm0                     ;xmm1 = xd
 
; Calculate yd = (y2 - y1) * (y2 - y1)
    cvtsi2sd xmm3,rsi                   ;convert y1 to DPFP
    subsd xmm1,xmm3                     ;xmm3 = y2 - y1
    mulsd xmm1,xmm1                     ;xmm3 = yd
    addsd xmm0,xmm1

; Calculate zd = (z2 - z1) * (z2 - z1)
    cvtsi2sd xmm3,edx                   ;xmm=0  = z1
    cvtss2sd xmm2,xmm2                  ;convert z1 to DPFP
    subsd xmm3,xmm2                     ;xmm4 = z2 - z1
    mulsd xmm3,xmm3                     ;xmm4 = zd
 
; Calculate final distance sqrt(xd + yd + zd)
    addsd xmm0,xmm3                     ;xmm4 = xd + yd + zd
    sqrtsd xmm0,xmm0                    ;xmm0 = sqrt(xd + yd + zd)
 
    ret
;========================================================================================