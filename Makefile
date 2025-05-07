SRCS = $(wildcard *.c)
OBJS = $(SRCS:.c=.o)
CC = gcc
CFLAGS = -g -Wall

GREEN=\033[0;32m
RED=\033[0;31m
RESET=\033[0m

all:
	@echo -e "$(RED)エラー：allターゲットは直接使用しないでください。FILE=xxxを指定してください(例：make run FILE=main)$(RESET)";

# (例make run FILE=test)
run:
	@if [ -z "$(FILE)" ]; then \
		echo -e "$(RED)エラー：FILE変数が未指定です（例：make run FILE=test） $(RESET)"; \
		false; \
	elif [ ! -f "$(FILE).c "]; then \
		echo -e "$(RED)エラー：$(FILE).cが存在しません$(RESET)"; \
		false; \
	else \
		echo -e "$(GREEN) [Compiling + Running]$(RESET) $(FILE).c" \
		$(CC) $(CFLAGS) -o $(FILE) $$(FILE).c && ./$(FILE); \
	fi

#（例：make lint FILE=test）
lint:
	@if [ -z "$(FILE)" ]; then \
		echo -e "$(RED)エラー：FILE変数が未指定です（例：make lint FILE=test） $(RESET)"; \
		false; \
	elif [ ! -f "$(FILE).c "]; then \
       		echo -e "$(RED)エラー：$(FILE).cが存在しません$(RESET)"; \
		false; \
	else \
		echo -e "$(GREEN)[Linting]$(RESET) $(FILE).c"; \
		cppcheck --enable=all --inconclusive --std=c99 --language=c
$(FILE).c
	fi

#（例１：make clean FILE=all）
#（例２：make clean FILE=test）
clean:
	@if [ -z "$(FILE)" ]; then \
		echo -e "$(RED)エラー：FILE変数が未指定です（例：make clean FILE=testまたはFILE=all） $(RESET)"; \
		false; \
	elif [ "$(FILE)" = "all" ];  then \
		echo -e "$(GREEN)[Cleaning ALL]$(RESET) 全てのバイナリとオブジェクトを削除しました"; \
		rm -f *.o $(SRCS:.c=); \
	elif [ -f "$(FILE).c" ]; then \
		echo -e "$(GREEN)[Cleaning]$(RESET) $(FILE).oを削除しました"; \
		rm -f $(FILE).o; \
	else \
		echo -e "$(RED)エラー：$(FILE).cが存在しないため削除を中止$(RESET)"; \
		false; \
	fi

#オブジェクトを生成
%.o: %.c
	echo -e "$(GREEN)[Compiling]$(RESET) $<"
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: all run lint clean
