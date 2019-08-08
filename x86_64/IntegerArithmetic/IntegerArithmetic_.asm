section .text

;========================================================================================
; int64_t IntegerAdd_(int64_t a, int64_t b, int64_t c, int64_t d, int64_t e, int64_t f); 
; rdi,rsi,rdx,rcx,r8,r9:用作函数的第一到第六个入参，函数从第7个入参开始需要通过压栈方式传入
; rax：用作函数返回值
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
; rdi,rsi,rdx,rcx,r8,r9:用作函数的第一到第六个入参，函数从第7个入参开始需要通过压栈方式传入
; rax：用作函数返回值
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
; rdi,rsi,rdx,rcx,r8,r9:用作函数的第一到第六个入参，函数从第7个入参开始需要通过压栈方式传入
; rax：用作函数返回值
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