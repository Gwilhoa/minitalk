# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gchatain <gchatain@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/12/15 12:12:30 by gchatain          #+#    #+#              #
#    Updated: 2022/02/28 12:29:27 by gchatain         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

ERASE		=	\033[2K\r
GREY		=	\033[30m
RED			=	\033[31m
GREEN		=	\033[32m
YELLOW		=	\033[33m
BLUE		=	\033[34m
PINK		=	\033[35m
CYAN		=	\033[36m
WHITE		=	\033[37m
BOLD		=	\033[1m
UNDER		=	\033[4m
SUR			=	\033[7m
END			=	\033[0m

LST_SRCS =   server.c
LST_OBJS = ${LST_SRCS:.c=.o}
SRCS = $(addprefix sources/,$(LST_SRCS))
OBJS = $(addprefix .objects/,$(LST_OBJS))

LST_SRCS_CLT =   client.c
LST_OBJS_CLT = ${LST_SRCS_CLT:.c=.o}
SRCS_CLT = $(addprefix sources/,$(LST_SRCS_CLT))
OBJS_CLT = $(addprefix .objects/,$(LST_OBJS_CLT))

INC = 0
AR_LIBFT := libft/libft.a
DIR_LIBFT	:= libft
INCLUDES    = includes/minitalk.h libft/includes/libft.h
DIR_INCLUDES = $(sort $(addprefix -I, $(dir $(INCLUDES))))
CC          = gcc
CFLAGS      = -Wall -Wextra -Werror
NAME        = minitalk
RM          = rm -f
NORM        = $(shell norminette sources | grep -c 'Error!')

ifeq ($(NORM), 0)
	NORM_RET = "${ERASE}${GREEN}[DONE]${END} ${NAME}"
else
	NORM_RET = "${ERASE}${RED}[NORM]${END} ${NAME}"
endif
all:       $(NAME)

$(NAME):    client server

.objects/%.o:	sources/%.c ${INCLUDES} | .objects
			${CC} ${CFLAGS} -c $< -o $@ ${DIR_INCLUDES}
			printf "${ERASE}${BLUE}[BUILD]${END} $<"

server:	${OBJS} ${INCLUDES} Makefile ${LIBRARY} $(AR_LIBFT)
			${CC} ${CFLAGS} -o server ${OBJS} ${AR_LIBFT} ${DIR_INCLUDES}
			printf $(NORM_RET)

client:	${OBJS_CLT} ${INCLUDES} Makefile ${LIBRARY} $(AR_LIBFT)
			${CC} ${CFLAGS} -o client ${OBJS_CLT} ${AR_LIBFT} ${DIR_INCLUDES}
			printf $(NORM_RET)

clean:
			${RM} ${OBJS}
			@make fclean -s -C libft
			printf "${RED}[DELETE]${END} directory .objects"

fclean:	clean
			${RM} -r ${NAME} .objects server client
			printf "${ERASE}${RED}[DELETE]${END} ${NAME}\n"

re:			fclean all

.objects:
			mkdir -p .objects

$(AR_LIBFT):
	$(MAKE) -C libft

.PHONY:	all clean fclean re compilation $(NAME)


.SILENT:
