default: all

SHELL		:= /bin/sh
# ============================================ DIRS ============================================== #
C_SRCS_DIR	= src
A_SRCS_DIR	= asm
# =========================================== FILES ============================================== #
C_SRCS		 = ${C_SRCS_DIR}/jo_main.c
# ------------------------------------------------------------------------------------------------ #
C_OBJS		= ${C_SRCS:.c=.o}
# ------------------------------------------------------------------------------------------------ #
A_SRCS		 = ${A_SRCS_DIR}/jo_f_status.asm
A_SRCS		+= ${A_SRCS_DIR}/jo_f_percent.asm
# ------------------------------------------------------------------------------------------------ #
A_OBJS		= ${A_SRCS:.asm=.o}
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
LINK		= -lc
# ------------------------------------------------------------------------------------------------ #
TARGET		= lowbat
# ========================================== ASSEMBLER =========================================== #
ASM			= nasm
ASMFLAGS	= -g -f
ASMARCH		= elf64
# ============================================ UNIX ============================================== #
RM			= rm -f
MKDIR		= mkdir -p
CP			= cp
MV			= mv
SED			= sed
# ============================================ RULES ============================================= #

.SUFFIXES: .asm .c .o

.asm.o:
	${ASM} ${ASMFLAGS} ${ASMARCH} -o ${.TARGET} ${.IMPSRC}

.c.o:
	${CC} -c ${CFLAGS} -I${C_SRCS_DIR} -o ${.TARGET} ${.IMPSRC}

${TARGET}: ${A_OBJS} ${C_OBJS}
	${CC} ${CFLAGS} -I${C_SRCS_DIR} -o ${.TARGET} ${.ALLSRC} ${LINK}

depend:
	${CC} -I${C_SRCS_DIR} -E -MM ${C_SRCS} > .depend
	${SED} 's/^/${C_SRCS_DIR}\//' .depend > .depend.tmp
	${MV} .depend.tmp .depend

all: depend ${TARGET}

clean:
	${RM} ${C_OBJS}
	${RM} ${A_OBJS}
	${RM} ${TARGET}.core
	${RM} .depend
	${RM} .depend.tmp

fclean: clean
	${RM} ${TARGET}

re: fclean all

.PHONY: all clean fclean re depend
