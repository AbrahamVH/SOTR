#PURPOSE: 		ginven a number, this program computes the factorial
#

.section .data

.section .text

.globl _start
.globl factorial	#this is unneeded unless we want to share this function
			#among other programs
_start:
pushl $4		#the factorial takes one argument. The number we want a factorial of. 
			#So, it gets pushed
call factorial		#run the factorial function
addl $4, %esp 		#scrubs the parameter that was pushed on the stack
movl %eax, %ebx		#factorial retuns the answer in %eax, but we want it in %ebx to send it
			#as our exit status
movl $1, %eax		#call the kernel's exit function 
int $0x80		

#FACTORIAL FUNCTION
.type factorial, @function 
factorial:
pushl %ebp		#standerd function stuff. We have to restore %ebp to its prior state 
			#before returning, so we have to push it
movl %esp, %ebp		#this is because we don't want to modify the stack pointer,
			#so we use %ebp

movl 8(%ebp), %eax	#this moves the first argument to %eax 
			#4(%ebp) holds the return address
			#8(%ebp) holds the first parameter
cmpl $1, %eax		#if the number 1, that is our base case, we simply return 
			#(1 is already in %eax as the return value)
je end_factorial
decl %eax		#otherwise, decrease the value
pushl %eax		#push it for our call to factorial
call factorial		#call factorial
movl 8(%ebp), %ebx	#eax has te return value, so we reload our parameter into %ebx
imull %ebx, %eax	#multiply that by the result of the las call to factorial (in %eax)
			#the answer is stored in %eax, which is good since that's where 
			#return values go
end_factorial: 
movl %ebp, %esp		#standard function return stuff
popl %ebp
ret

