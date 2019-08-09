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

struc ClVal
    .a8:  resb  1
    .pad1: resb  1
    .a16: resw  1
    .a32: resd  1
    .a64: resq  1
    .b8:  resb  1
    .pad2: resb  1
    .b16: resw  1
    .b32: resd  1
    .b64: resq  1
endstruc



section .text
;========================================================================================
; extern void CalcLogical_(ClVal* cl_val, uint8_t c8[3], uint16_t c16[3], uint32_t c32[3], uint64_t c64[3]);
; code is intel风格的汇编代码
; returns : 0 = error
;           1 = success
global CalcLogical_
CalcLogical_:
; 8-bit logical operations
        mov r10b,[rdi+ClVal.a8]             ;r10b = a8
        mov r11b,[rdi+ClVal.b8]             ;r11b = b8
        mov al,r10b
        and al,r11b                         ;calc a8 & b8
        mov [rsi],al
        mov al,r10b
        or al,r11b                          ;calc a8 | b8
        mov [rsi+1],al
        mov al,r10b 
        xor al,r11b                         ;calc a8 ^ b8
        mov [rsi+2],al

; 16-bit logical operations
        mov r10w,[rdi+ClVal.a16]            ;r10w = a16
        mov r11w,[rdi+ClVal.b16]            ;r11w = b16
        mov ax,r10w
        and ax,r11w                         ;calc a16 & b16
        mov [rdx],ax
        mov ax,r10w
        or ax,r11w                          ;calc a16 | b16
        mov [rdx+2],ax
        mov ax,r10w
        xor ax,r11w                         ;calc a16 ^ b16
        mov [rdx+4],ax

; 32-bit logical operations
        mov r10d,[rdi+ClVal.a32]            ;r10d = a32
        mov r11d,[rdi+ClVal.b32]            ;r11d = b32
        mov eax,r10d
        and eax,r11d                        ;calc a32 & b32
        mov [rcx],eax
        mov eax,r10d
        or eax,r11d                         ;calc a32 | b32
        mov [rcx+4],eax
        mov eax,r10d
        xor eax,r11d                        ;calc a32 ^ b32
        mov [rcx+8],eax

; 64-bit logical operations
        mov r10,[rdi+ClVal.a64]             ;r10 = a64
        mov r11,[rdi+ClVal.b64]             ;r11 = b64
        mov rax,r10
        and rax,r11                         ;calc a64 & b64
        mov [r8],rax
        mov rax,r10
        or rax,r11                          ;calc a64 | b64
        mov [r8+8],rax
        mov rax,r10 
		xor rax,r11                         ;calc a64 ^ b64
        mov [r8+16],rax
		
		ret
;========================================================================================
