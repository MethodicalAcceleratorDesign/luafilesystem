# $Id: Makefile,v 1.36 2009/09/21 17:02:44 mascarenhas Exp $

T= lfs

CONFIG= ./config

include $(CONFIG)

SRCS= src/$T.c
OBJS= src/$T.o

lib: lfs.a src/lfs.so

lfs.a: $(OBJS)
	env $(AR) -r lib$@ $(OBJS)

src/lfs.so: $(OBJS)
	MACOSX_DEPLOYMENT_TARGET="10.13"; export MACOSX_DEPLOYMENT_TARGET; $(CC) $(LIB_OPTION) -o src/lfs.so $(OBJS)

test: lib
	LUA_CPATH=./src/?.so lua tests/test.lua

install:
	mkdir -p $(DESTDIR)$(LUA_LIBDIR)
	cp src/lfs.so $(DESTDIR)$(LUA_LIBDIR)

clean:
	rm -f liblfs.a src/lfs.so $(OBJS)
