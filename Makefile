CC = gcc
CXX = g++
CFLAGS= -C -Wall -I lib/include
CXXFLAGS = -g -Wall -Wextra -std=c++2a -Ilib/include
LDLIBS = -lGL -lGLU -lglfw -lm -lXrandr -lXi -lX11  -lpthread -ldl -lXinerama -lXcursor

SRC = $(wildcard src/*.cpp)
OBJ = $(patsubst src/%.cpp, obj/%.o, $(SRC))
EXTRAS= $(wildcard src/%.glsl)

APP = app
all: $(APP)

app: obj/glad.o $(OBJ) $(EXTRAS)
	$(CXX) $(CXXFLAGS)  $(LDLIBS) obj/glad.o $(OBJ) -o $(APP)

obj/glad.o: src/glad.c
	$(CC) $(CFLAGS) $< -c -o $@

obj/%.o: src/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

.PHONY: clean run
clean:
	find . -type f | xargs touch
	rm -rf obj/*
	rm ./$(APP)
