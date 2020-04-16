default: all


# ============================================ DIRS ============================================== #
SRCS_DIR	= src/
OBJS_DIR	= obj/
ASRCS_DIR	= asm/
AOBJS_DIR	= asmobj/
# =========================================== FILES ============================================== #

# ========================================== COMPILER ============================================ #
CC			= clang
CFLAGS		= -std=c89
CFLAGS		+= -Wall
CFLAGS		+= -Wextra
CFLAGS		+= -Werror
CFLAGS		+= -pedantic
# CFLAGS		+= -O2 -pipe
# ========================================== ASSEMBLER =========================================== #
ASM			= nasm
ASMFLAGS	= -f
ASMARCH		= elf64_fbsd

all:
	${CC}
