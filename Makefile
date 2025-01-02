TARGET := exe
CC := cc
CFLAGS := -Wall -Wextra -MMD -MP
LDFLAGS := 
PRINTLIB := ./lib/libprint.a
INCLUDE :=	-I./include \
			-I./lib
SRCS :=	main.c \
		start.c \
		func.c \
		util.c
OBJDIR := ./obj
OBJS := $(SRCS:%.c=$(OBJDIR)/%.o)
DEPS := $(OBJS:%.o=%.d)

vpath %.c src:src/func:src/util

ifdef DEBUG
	CFLAGS += -ggdb -O0 -fsanitize=address
	LDFLAGS += -fsanitize=address
else
	CFLAGS += -Werror
endif

# $(warning objs= $(OBJS))
# $(warning flg= $(CFLAGS))
# $(warning ldflags= $(LDFLAGS))
# $(warning deps= $(DEPS))

$(warning objs:[$(OBJS)] flgs:[$(CFLAGS)] ldflags:[$(LDFLAGS)] deps:[$(DEPS)])

$(OBJDIR)/%.o : %.c | $(OBJDIR)
	$(CC) $(INCLUDE) $(CFLAGS) -c $< -o $@

all: $(TARGET)

$(TARGET): $(OBJS) $(PRINTLIB)
	$(CC) $(LDFLAGS) $^ -o $@

$(OBJDIR):
	@mkdir -p $@

$(PRINTLIB):
	$(MAKE) all -C ./lib

debug: fclean
	$(MAKE) DEBUG=true

clean:
	$(RM) -r $(OBJDIR)
	$(MAKE) clean -C ./lib

fclean: clean
	$(MAKE) fclean -C ./lib
	$(RM) $(TARGET)

re: fclean all

.PHONY: clean fclean re

-include $(DEPS)
