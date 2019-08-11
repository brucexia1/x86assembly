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
; extern int64_t Cc1_(int8_t a, int16_t b, int32_t c, int64_t d, int8_t e, int16_t f, int32_t g, int64_t h);
; code is intel风格的汇编代码
global Cc1_
Cc1_:
    push rbp
	mov  rsp,rbp
	
	pop rbp
    ret
;========================================================================================
