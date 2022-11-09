#---------------------------------------------------------------------------------------------------------------------
#	BUBBLE SORTING PROGRAM
#		
#	-Create a integer array 
#	-Sort the array with bubble sort algo
#	-Print original array and result array
#	
#
#	Settings: to change the amount of values sorted the calue array in .data and $s1 in main have to be changed 
#
#---------------------------------------------------------------------------------------------------------------------
.data 
	array: .space 400                  	# Space=number of value x 4
	newline: .asciiz "\n"
	coma: .asciiz ","
.text
	main:               		### Main program
		addi $s1,$zero,100		# number of value 
		jal generateArray        
	
	generateArray:      		### main body if genereation program
		addi $t0, $zero, 0   		# t0 array pointer
		addi $t1, $zero, 0   		# t1 Loop counter
		jal while            		# Start loop
		jr $ra               		# Go back to main 
	
	while:              		### Generation loop
		beq  $t1,$s1,sorting  		# if array full, go to sorting
		addi $t1,$t1,1       		# increase loop counter
		b random
	
	random:             		### Generate random number
		addi $a1,$zero,100   		# max bound 
		li $v0, 42           		# random int
		syscall
		bgt $a0,0,addArray   		# if negative restart random,else add in array
		b random
	
	addArray:           		### Add int the array
		sw $a0, array($t0)   		# Save value in array
		addi $t0, $t0, 4     		# Move pointer 
		b while
	
	
	print_array:        		### Print array initialization for pointers t6 and t7
		addi $t6, $zero, 0   		# for print_array
		addi $t7, $zero, 0   		# for print_array
		j print_array_loop
	print_array_loop:		### Loop to print a array
		beq $t6, $s1, print_array_exit	# after 10 print, go out
    		lw $a0, array($t7) 		# load word from addrs and goes to the next addrs
    		addi $t7, $t7, 4		# move pointer to next 4 bytes
    		li $v0, 1      			# print value
    		syscall
    		li $v0, 4
		la $a0,coma			# print coma
		syscall
   		addi    $t6, $t6, 1 		#increment counter 
   		j      print_array_loop		
   	print_array_exit:		###  Go back to program
   		li $v0, 4
		la $a0,newline
		syscall
		jr $ra
	
	sorting:            		### Sorting program initializing
		jal print_array      		# print original array
		jal sorting_loop     		# start sorting
	
	sorting_loop:			### Main loop who scan the array
		addi $t3, $zero, 1   		# switch counter=1 to pass entry test
		b test_loop_array
	
	test_loop_array:		### 
		beq $t3,0, exit
		addi $t3, $zero, 0   # reset switch counter
		addi $t0, $zero, -1   # array counter
		b test_loop_element
	 
	test_loop_element:
		addi $t0,$t0, 1       # array counter
		beq $t0,$s1,test_loop_array
		mul $t1,$t0,4         # stack pointer is 4 times array counter 
		lw $t4, array($t1)
		addi $t1, $t1, 4   # array pointer
		lw $t5, array($t1)
		bge $t5,$t4,test_loop_element
		sw $t4, array($t1)   # Save value in element i+1
		addi $t1, $t1, -4     # Move pointer to previous value
		sw $t5, array($t1)   # Save value in element i
		addi $t3, $zero, 1   #To show that there was a modification
		#jal print_array      # Print array
		b test_loop_element
	
	
	exit:               ### Exit program
		jal print_array      # print sorted array
		li $v0, 10 
		syscall 
	
	
	
	
