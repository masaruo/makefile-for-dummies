TARGET := libprint.a

all: $(TARGET)

$(TARGET): print.o
	ar rcs $@ print.o

print.o: print.c
	cc -c print.c -o $@

clean:
	$(RM) print.o

fclean: clean
	$(RM) $(TARGET)

re: fclean all

.PHONY: clean fclean re
