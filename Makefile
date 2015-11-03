CFLAGS=-Werror -Wextra -Wall -DF_DOUBLE_PRECISION
DEBUG_CFLAGS=-O0 -g3 -DF_MEMORY_DEBUG -DF_EXIT_CRASH
RELEASE_CFLAGS=-O3
INCLUDES=-pthread -I./deps/forge -I./include/ `pkg-config --cflags sdl2 gl`
LIBS=-lm -lrt -lSDL2 `pkg-config --libs sdl2 gl`
LIB_DIRS=-L./deps/forge
NAME=aaaaaa
COMMON_OBJ=asset_importer.o vector.o void.o logging.o

debug: forge_debug $(NAME)
release: forge_release $(NAME)

forge_debug: CFLAGS += $(DEBUG_CFLAGS)
forge_debug:
	@echo "Building Forge in in debug mode."
	@cd ./deps/forge/; make debug

forge_release: CFLAGS += $(RELEASE_CFLAGS)
forge_release:
	@echo "Building Forge in in release mode."
	@cd ./deps/forge/; make release

clean:
	rm -f *.o
	rm -f $(NAME)

%.o: ./src/%.c
	$(CC) $(CFLAGS) $(LIB_INCLUDES) $(INCLUDES) -c $<

$(NAME): $(COMMON_OBJ) ./deps/forge/libforge.a main.o
	$(CC) $(CLAGS) $(LIB_INCLUDES) $(INCLUDES) -o $(NAME) $^ $(LIBS)
