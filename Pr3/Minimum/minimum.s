#PURPOSE:	this program finds the minimum number of a set of data items
#
#VARIABLES: 	
#		%eax 	holds the current data item
#		%ebx 	holds the largest data item found
#		%edi	holds the index of the data item being examined
#
#	MEMORY LOCATIONS:
#		data_items 	contains the item data. A 0 is used to terminate the data
#
.section .data
data_items:
.long 67,34,222,45,75,3,54,34,44,33,22,11,66,0

.section .text
.globl _start
_start:
movl $0, %edi			#move 0 into the index register
movl data_items(,%edi,4),%eax	#load the first byte of data
movl %eax, %ebx			#since this is the first item, %eax is the biggest

start_loop:		
cmpl $0,%eax			#check to see if we've hit the end
je loop_exit
incl %edi			#load next value
movl data_items(,%edi,4),%eax	
cmpl $0,%eax			#check to see if we've hit the end
je loop_exit
cmpl %ebx, %eax			#compare values
jge start_loop			#jump to loop beginning if the new one isn't smaller
movl %eax, %ebx			#move the value as the largest
jmp start_loop			#jump to loop beginning

loop_exit:
movl $1, %eax
int $0x80
