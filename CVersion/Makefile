LIBS = -lm

# Declare the cross compiler as gcc
CC   = gcc

# Declare the objects which I have
objects = main.o v1h.o

#CFLAGS 

# The commmond line, "main". Notice that, there must begin with "TAB" button.  
# gcc -o $@ $^ means specify the outfile as main main.o thankyou.o
# The $@ is means main 
main: ${objects}
	${CC} -o $@ ${objects} ${LIBS} 

# The commmond line, "clean". Notice that, there must begin with "TAB" button.  
# rm -f main $^ means remove forced for main main.o thankyou.o   
clean:
	rm -f main ${objects}

# The commmond line, "output". Notice that, there must begin with "TAB" button.
# ./main means execution the result of main  
output:
	./main
