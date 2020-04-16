default: all

SHELL		:= /bin/sh
# ============================================ DIRS ============================================== #
C_SRCS_DIR	= src
A_SRCS_DIR	= asm
# =========================================== FILES ============================================== #
C_SRCS		 = ${C_SRCS_DIR}/jo_main.c
C_SRCS		+= ${C_SRCS_DIR}/jo_printf.c
# ------------------------------------------------------------------------------------------------ #
C_OBJS		= ${C_SRCS:.c=.o}
# ========================================== COMPILER ============================================ #
CC			= clang
# ------------------------------------------------------------------------------------------------ #
CFLAGS		= -std=c89
CFLAGS		+= -Wall
CFLAGS		+= -Wextra
CFLAGS		+= -Werror
CFLAGS		+= -pedantic
CFLAGS		+= ${DEBUG}
# CFLAGS		+= ${OPTI}
# ------------------------------------------------------------------------------------------------ #
OPTI		= -O2 -pipe
DEBUG		= -glldb
# ------------------------------------------------------------------------------------------------ #
TARGET		= lowbat
# ========================================== ASSEMBLER =========================================== #
ASM			= nasm
ASMFLAGS	= -f
ASMARCH		= elf64_fbsd
# ============================================ UNIX ============================================== #
RM			= rm -f
MKDIR		= mkdir -p
CP			= cp
MV			= mv
SED			= sed
# ============================================ RULES ============================================= #

.SUFFIXES: .c .o

.c.o:
	${CC} -c ${CFLAGS} -I${C_SRCS_DIR} ${.IMPSRC} -o ${.TARGET}

${TARGET}: ${C_OBJS}
	${CC} ${CFLAGS} -I${C_SRCS_DIR} -o ${.TARGET} ${.ALLSRC}

depend:
	${CC} -I${C_SRCS_DIR} -E -MM ${C_SRCS} > .depend
	${SED} 's/^/${C_SRCS_DIR}\//' .depend > .depend.tmp
	${MV} .depend.tmp .depend

all: depend ${TARGET}

clean:
	${RM} ${C_OBJS}
	${RM} ${TARGET}.core
	${RM} .depend
	${RM} .depend.tmp

fclean: clean
	${RM} ${TARGET}

re: fclean all

.PHONY: all clean fclean re depend

-include "./.depend"
