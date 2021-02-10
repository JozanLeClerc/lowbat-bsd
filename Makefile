# ========================
# =====    ===============
# ======  ================
# ======  ================
# ======  ====   ====   ==
# ======  ===     ==  =  =
# ======  ===  =  ==     =
# =  ===  ===  =  ==  ====
# =  ===  ===  =  ==  =  =
# ==     =====   ====   ==
# ========================
#
# lowbat: Makefile
# Wed Feb 10 19:20:35 CET 2021
# Joe
#
# BSD Makefile

default: all

C_SRCS_DIR	 = src
A_SRCS_DIR	 = asm
PREFIX		?= /usr/local
BINPREFIX	?= ${PREFIX}/bin
MANPREFIX	?= ${PREFIX}/share/man

C_SRCS		+= ${C_SRCS_DIR}/n_speak.c
C_SRCS		+= ${C_SRCS_DIR}/n_notify.c

C_OBJS		 = ${C_SRCS:.c=.c.o}

A_SRCS		 = ${A_SRCS_DIR}/r_lowbat.S
A_SRCS		+= ${A_SRCS_DIR}/r_loop.S
A_SRCS		+= ${A_SRCS_DIR}/r_cpyhead.S
A_SRCS		+= ${A_SRCS_DIR}/c_args.S
A_SRCS		+= ${A_SRCS_DIR}/f_status.S
A_SRCS		+= ${A_SRCS_DIR}/f_percent.S

A_OBJS		 = ${A_SRCS:.S=.S.o}

CC			 = cc
CFLAGS		+= -std=c89
CFLAGS		+= -Wall
CFLAGS		+= -Wextra
CFLAGS		+= -Wno-comment
CFLAGS		+= -Wno-long-long
CFLAGS		+= -Wno-c99-extensions
CFLAGS		+= -Wno-variadic-macros
CFLAGS		+= -Werror
CFLAGS		+= -pedantic
# CFLAGS		+= -O0 -glldb
# CFLAGS		+= -fsanitize=address

CINCS		+= -I/usr/local/include
CINCS		+= -I/usr/local/include/glib-2.0
CINCS		+= -I/usr/local/lib/glib-2.0/include
CINCS		+= -I/usr/local/include/gdk-pixbuf-2.0

LDFLAGS		?=
LDLIBS		 = ${LDFLAGS}
LDLIBS		+= -L/usr/local/lib
LDLIBS		+= -L/usr/lib
LDLIBS		+= -lnotify
LDLIBS		+= -lespeak
LDLIBS		+= -lc

TARGET		 = lowbat

AS			 = as
# ASFLAGS	 = -f elf64
# ASFLAGS	+= -p gas
# ASFLAGS	+= -g

LDFLAGS		?=
LDLIBS		 = ${LDFLAGS}
LDLIBS		+= -L/usr/local/lib
LDLIBS		+= -lnotify
LDLIBS		+= -lespeak

SHELL		:= /bin/sh
RM			 = rm -f
MKDIR		 = mkdir -p
CP			 = cp -pf
MV			 = mv
SED			 = sed

.SUFFIXES: .S .c .S.o .c.o

.S.S.o:
	${AS} ${ASFLAGS} -o ${.TARGET} ${.IMPSRC}

.c.c.o:
	${CC} -c ${CFLAGS} ${CINCS} -o ${.TARGET} ${.IMPSRC}

${TARGET}: ${A_OBJS} ${C_OBJS}
	${CC} ${CFLAGS} -o ${.TARGET} ${A_OBJS} ${C_OBJS} ${LDLIBS}

depend:
	${CC} ${CINCS} -E -MM ${C_SRCS} > .depend
	${SED} 's/^jo/${C_SRCS_DIR}\/jo/' .depend > .depend.tmp
	${MV} .depend.tmp .depend

all:
	${MAKE} depend
	${MAKE} ${TARGET}

install: all
	${MKDIR} "${DESTDIR}${BINPREFIX}"
	${CP} ${TARGET} "${DESTDIR}${BINPREFIX}"
	${MKDIR} "${DESTDIR}${MANPREFIX}"/man1
	${CP} man/${TARGET}.1 "${DESTDIR}${MANPREFIX}"/man1

uninstall:
	${RM} "${DESTDIR}${BINPREFIX}"/${TARGET}
	${RM} "${DESTDIR}${MANPREFIX}"/man1/${TARGET}.1

clean:
	${RM} ${C_OBJS} ${A_OBJS} ${TARGET}.core .depend .depend.tmp ${TARGET}

re: clean all

.PHONY: all clean fclean re depend install uninstall

# Files prefixes
# --------------
# f: fetch
# n: notify
# r: run
# c: check
