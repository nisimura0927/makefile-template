                echo -e "$(RED)エラー: FILE変数が未指定です（例：make lint FILE=test）$(RESET)"; \
                false; \
        elif [ ! -f "$(FILE).c" ]; then \
                echo -e "$(RED)エラー: $(FILE).c が存在しません$(RESET)"; \
                false; \
        else \
                echo -e "$(GREEN)[Linting]$(RESET) $(FILE).c"; \
                cppcheck --enable=all --inconclusive --std=c99 --language=c $(FILE).c; \
        fi


# クリーン（全削除 or FILE指定削除）
clean:
        @if [ -z "$(FILE)" ]; then \
                echo -e "$(RED)エラー: FILE変数が未指定です（例：make clean FILE=test または FILE=all）$(RESET)"; \
                false; \
        elif [ "$(FILE)" = "all" ]; then \
                echo -e "$(GREEN)[Cleaning All]$(RESET) 全てのバイナリとオブジェクトを削除中..."; \
                rm -f *.o $(SRCS:.c=); \
        elif [ -f "$(FILE).c" ]; then \
                echo -e "$(GREEN)[Cleaning]$(RESET) $(FILE).o と $(FILE) を>削除中..."; \
                rm -f $(FILE).o $(FILE); \
        else \
                echo -e "$(RED)エラー: $(FILE).c が存在しないため削除を中止$(RESET)"; \
                false; \
        fi

# オブジェクト生成
%.o: %.c
        @echo -e "$(GREEN)[Compiling]$(RESET) $<"
        $(CC) $(CFLAGS) -c $< -o $@

.PHONY: all run lint clean