##########################################################################################
# yum -y install gcc nasm gdb
# nasm -f elf64 -o IntegerArithmetic_.o  IntegerArithmetic_.asm
# gcc -c IntegerArithmetic.c -o IntegerArithmetic.o
# gcc -o app_demo IntegerArithmetic.o IntegerArithmetic_.o
##########################################################################################
# 默认disassemble看到的是AT&T风格的汇编代码，可以使用
# set disassembly-flavor intel   设置反汇编后显示的是intel风格的汇编代码
# x/8xg $rsp  打印当前堆栈中8个8字节内容
# gdb app_demo
## b IntegerAdd_
## r
## set disassembly-flavor intel
## disassemble IntegerAdd_
## info registers
## nexti
## info registers
##########################################################################################
SRCS = $(wildcard *.c)
OBJS = $(subst .c,.o, $(notdir $(SRCS)))
ASM_OBJS = IntegerArithmetic_.o
CC = gcc
INCLUDES = 
LIBS = 
CFLAGES = -g -Wall -D_GNU_SOURCE

all : app_demo

app_demo : $(OBJS) $(ASM_OBJS)
	@echo "OBJS: " $(OBJS) $(ASM_OBJS)
	$(CC) $(notdir $^) -g -o $@

%.o : %.c
	$(CC) -c $< $(CFLAGES) $(INCLUDES)

IntegerArithmetic_.o : IntegerArithmetic_.asm
	nasm -f elf64 -g -F stabs -o $@ $<

clean:
	rm -f *.o app_demo
.PYTHON:clean
