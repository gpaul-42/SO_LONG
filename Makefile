# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gpaul <gpaul@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/07/06 20:00:48 by gpaul             #+#    #+#              #
#    Updated: 2021/08/19 22:16:20 by gpaul            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = so_long
SRCSDIR = srcs
OBJSDIR = .objs
SRCS =	main.c		\
		utils.c		\
		copy_map.c	\
		map_init.c	\
		check_map.c	\
		text_init.c	\
		initial_render.c	\
		key_press.c			\
		move_rend.c			\
		update_rend.c		\
		free_alloc.c

OBJS = $(addprefix $(OBJSDIR)/, $(SRCS:.c=.o))
DPDCS = $(OBJS:.o=.d)
INCLUDES = -I includes/ -I libft/ -I mlx/
LIB = -Llibft -lft
CFLAGS = -Wall -Wextra -Werror -flto -O2 -g -march=native -fsanitize=address 
MLX = -Lmlx -lmlx -framework OpenGL -framework AppKit

all : $(NAME)

-include $(DPDCS)

$(NAME) : $(LIB) $(OBJS) 
	@(gcc $(MLX) $(CFLAGS) $(OBJS) $(LIB) $(INCLUDES) -o $(NAME))

$(LIB) :
	@(make -C libft)
	$(MAKE) -C mlx

$(OBJSDIR)/%.o : $(SRCSDIR)/%.c | $(OBJSDIR)
	@(echo "Compiling -> $^")
	@(gcc $(CFLAGS) $(INCLUDES) -MMD -c $< -o $@)

$(OBJSDIR) :
	@(mkdir -p .objs)

clean :
	@(rm -f $(NAME))
	$(MAKE) clean -C libft
	$(MAKE) clean -C mlx

fclean : clean
	@(rm -rf $(OBJSDIR))
	$(MAKE) fclean -C libft
re : fclean all

fg : $(LIB) $(OBJS)
	@(gcc $(MLX) $(CFLAGS) -g3 -fsanitize=address $(OBJS) $(LIB) $(MLX_COMP) $(INCLUDES)  -o $(NAME) )
