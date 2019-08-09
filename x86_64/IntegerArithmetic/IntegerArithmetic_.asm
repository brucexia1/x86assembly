section .text

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
;========================================================================================
; int64_t IntegerAdd_(int64_t a, int64_t b, int64_t c, int64_t d, int64_t e, int64_t f); 
; code is intel风格的汇编代码
global IntegerAdd_
IntegerAdd_:
    add rdi,rsi                ;rdi = a + b
    add rcx,rdx                ;rcx = c + d
    add r8,r9                  ;r8 = e + f
    add rcx,rdi                ;rcx = a + b + c + d
    mov rax,rcx                ;rax = a + b + c + d
    add rax,r8                 ;rax = a + b + c + d + e + f
    ret
    
;========================================================================================
; int64_t IntegerMul_(int8_t a, int16_t b, int32_t c, int64_t d, int8_t e, int16_t f, int32_t g, int64_t h); 
; code is intel风格的汇编代码
global IntegerMul_
IntegerMul_:
    movsx r10,edi                 ;r10 = sign_extend(a)
    movsx r11,esi                 ;r11 = sign_extend(b)
    imul  r10,r11                 ;r10 = a * b
    movsx r11,edx                 ;r11 = sign_extend(c)
    imul  r10,r11                 ;r10 = a * b * c
    imul  r10,rcx                 ;r10 = a * b * c * d

    movsx rcx,r8w                 ;rcx = sign_extend(e)
    movsx rdx,r9w                 ;rdx = sign_extend(f)
    imul  rcx,rdx                 ;rcx = e * f

    movsx r8,byte [rsp+8]         ;r8 = sign_extend(g)
    movsx r9,word [rsp+16]        ;r9 = sign_extend(h)
    imul  r8,r9                   ;r8 = g * h

    mov   rax,r10                 ;rax = a * b * c * d
    imul  rax,rcx                 ;rax = a * b * c * d * e * f
    imul  rax,r8                  ;rax = a * b * c * d * e * f * g * h

    ret

;========================================================================================
; void IntegerDiv_(int64_t a, int64_t b, int64_t quo_rem_ab[2], int64_t c, int64_t d, int64_t quo_rem_cd[2]);
; code is intel风格的汇编代码
global IntegerDiv_
IntegerDiv_:
    mov rax,rdi                        ;rax = a 
    mov rdi,rdx                        ;rdi = &quo_rem_ab[0]
    cqo                                ;rdx:rax = sign_extend(a)
    idiv qword rsi                     ;rax = quo a/b, rdx = rem a/b
    mov [rdi],rax                      ;save quotient        
    mov [rdi+8],rdx                    ;save remainder

    mov rax,rcx                        ;rax = c
    cqo                                ;rdx:rax = sign_extend(c)        
    idiv qword r8                      ;rax = quo c/d, rdx = rem c/d        
    mov [r9],rax                       ;save quotient        
    mov [r9+8],rdx                     ;save remainder

    ret
    
;========================================================================================
