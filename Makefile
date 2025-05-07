SRCS = $(wildcard *.c)
OBJS = $(SRCS:.c=.o)
CC = gcc
CFLAGS = -g -Wall

GREEN=\033[0;32m
RED=\033[0;31m
RESET=\033[0m

.PHONY: all run lint clean

all:
	@echo -e "$(RED)エラー：allターゲットは直接使用しないでください。FILE=xxxを指定してください (例：make run FILE=main)$(RESET)"

run:
	@if [ -z "$(FILE)" ]; then \
		echo -e "$(RED)エラー：FILE変数が未指定です（例：make run FILE=main）$(RESET)"; \
		false; \
	elif [ ! -f "$(FILE).c" ]; then \
		echo -e "$(RED)エラー：$(FILE).c が存在しません$(RESET)"; \
		false; \
	else \
		echo -e "$(GREEN)[Compiling + Running]$(RESET) $(FILE).c"; \
		$(CC) $(CFLAGS) -o $(FILE) $(FILE).c && ./$(FILE); \
	fi

lint:
	@if [ -z "$(FILE)" ]; then \
		echo -e "$(RED)エラー：FILE変数が未指定です（例：make lint FILE=main）$(RESET)"; \
		false; \
	elif [ ! -f "$(FILE).c" ]; then \
		echo -e "$(RED)エラー：$(FILE).c が存在しません$(RESET)"; \
		false; \
	else \
		echo -e "$(GREEN)[Linting]$(RESET) $(FILE).c"; \
		cppcheck --enable=all --inconclusive --std=c99 --language=c $(FILE).c; \
	fi

clean:
	@if [ -z "$(FILE)" ]; then \
		echo -e "$(RED)エラー：FILE変数が未指定です（例：make clean FILE=main または FILE=all）$(RESET)"; \
		false; \
	elif [ "$(FILE)" = "all" ]; then \
		echo -e "$(GREEN)[Cleaning ALL]$(RESET) 全てのバイナリとオブジェクトを削除しました"; \
		rm -f *.o $(SRCS:.c=); \
	elif [ -f "$(FILE).c" ]; then \
		echo -e "$(GREEN)[Cleaning]$(RESET) $(FILE).o を削除しました"; \
		rm -f $(FILE).o $(FILE); \
	else \
		echo -e "$(RED)エラー：$(FILE).c が存在しないため削除を中止します$(RESET)"; \
		false; \
	fi

%.o: %.c
	@echo -e "$(GREEN)[Compiling]$(RESET) $<"
	@$(CC) $(CFLAGS) -c $< -o $@
