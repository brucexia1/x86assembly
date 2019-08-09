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

section .data
FibVals dd 1, 2, 3, 5, 8, 13, 21, 34
NumFibVals_ dd ($ - FibVals)/4
FibValsSum_ dd 0
global NumFibVals_, FibValsSum_



section .text
;========================================================================================
; int MemoryAddressing_(int i, int* v1, int* v2, int* v3, int* v4);
; code is intel风格的汇编代码
; returns : 0 = error
;           1 = success
global MemoryAddressing_
MemoryAddressing_:
    ;make sure 'i' is valid
    cmp edi,0
    jl InvalidIndex      ;jmp if i < 0
    cmp edi,[NumFibVals_]
    jge InvalidIndex     ;jmp if i >=NumFibVals_
    mov r9,rcx           ;r9 = v3
    movsxd rcx,edi       ;sign extend i
	mov [rsp+8],rcx      ;save copy of i
    
    mov r11, FibVals
    shl rcx,2
    add r11,rcx
    mov eax, dword [r11]
    mov [rsi],eax
    
    mov r11, FibVals
    mov rcx,[rsp+8]
    shl rcx,2
    mov eax, dword [r11+rcx]
    mov [rdx],eax
    
    mov r11, FibVals
    mov rcx,[rsp+8]
    mov eax, dword [r11+rcx*4]
    mov [r9],eax

    mov r11, FibVals-42
    mov rcx,[rsp+8]
    mov eax, dword [r11+rcx*4 + 42]
    mov [r8],eax
    
	add [FibValsSum_],eax     ;update sum
    
    mov eax,1
    ret

InvalidIndex:
    xor eax,eax                         ;set error return code
    ret
;========================================================================================
