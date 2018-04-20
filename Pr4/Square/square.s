.section .data

.section .text

.globl _start
_start: 

pushl 	$11		#THE NUMBER YOU WANT TO RISE
call 	square
addl 	$8, %esp
movl 	%eax, %ebx

movl 	$1, %eax
int 	$0x80

.type 	square, @function 
square:
pushl 	%ebp		#save old base pointer
movl 	%esp, %ebp	#make stack pointer the base pointer
subl 	$4, %esp	#get room for our local storage

movl 	8(%ebp), %ebx	#put first argument in %eax
movl	$2, %ecx	#HERE YOU CAN PUT THE POWER YOU WANT TO RISE THE BASE	

movl 	%ebx, -4(%ebp) 	#stare current result

square_loop_start:
cmpl 	$1, %ecx	#if the power is 1, we are done
je 	end_square
movl 	-4(%ebp), %eax	#move the current result inteo %eax
imull 	%ebx, %eax	#multiply the current result by the base number
movl 	%eax, -4(%ebp)	#store the current result

decl 	%ecx		#decrease the power
jmp 	square_loop_start	#run for the next power

end_square: 
movl 	-4(%ebp), %eax	#return value goes in %eax
movl 	%ebp, %esp	#restore the stack pointer
popl 	%ebp		#restore the base pointer
ret


