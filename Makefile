default: all

SHELL		:= /bin/sh
# ============================================ DIRS ============================================== #
SRCS_DIR	= src
ASRCS_DIR	= asm
# ------------------------------------------------------------------------------------------------ #
OBJS_DIR	= obj
AOBJS_DIR	= asmobj
# =========================================== FILES ============================================== #
SRCS		 = ${SRCS_DIR}/jo_main.c
SRCS		+= ${SRCS_DIR}/jo_printf.c
# ========================================== COMPILER ============================================ #
CC			= clang
# ------------------------------------------------------------------------------------------------ #
CFLAGS		= -std=c89
CFLAGS		+= -Wall
CFLAGS		+= -Wextra
CFLAGS		+= -Werror
CFLAGS		+= -pedantic
# CFLAGS		+= -O2 -pipe
# ------------------------------------------------------------------------------------------------ #
NAME		= lowbat
# ========================================== ASSEMBLER =========================================== #
ASM			= nasm
ASMFLAGS	= -f
ASMARCH		= elf64_fbsd
# ============================================ UNIX ============================================== #
RM			= rm -rf
MKDIR		= mkdir
CP			= cp
MV			= mv
AWK			= awk -F
SED			= sed
# ============================================ RULES ============================================= #
# .include "./.depend"

depend:
	pwd
	${CC} -I${SRCS_DIR}/ -E -MM ${SRCS} > .depend

config:
	${MKDIR} ${OBJS_DIR}
	${SED} 's/^/${OBJS_DIR}\//' .depend > .depend.tmp
	${MV} .depend.tmp .depend

all: depend config

clean:
	${RM} ${OBJS_DIR}
	${RM} ${AOBJS_DIR}
	${RM} ${NAME}.core
	${RM} .depend
	${RM} .depend.tmp

fclean: clean
	${RM} ${NAME}

re: fclean all

.PHONY: all clean fclean re depend config
