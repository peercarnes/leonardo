#Peer Carnes
#Leonardo assmebly
#9/28/20


.data
prompt: .asciiz "\nPlease enter a nonnegative integer: "	#Prints a prompt message asking for user input

tryAgain: .asciiz "\n Try again."     #runs if userinput is empty

comma: .asciiz ", "     #grab comma

	.text 
main: 

lInitialPrompt:  #reads the initial input and applies it to base case or the nonnegative entry

	li	$v0, 4			#print initial message
	la 	$a0, prompt     #print out prompt
	syscall             #Do it

	li 	$v0, 5 			#get user input
	syscall             #Do it
	
	move 	$s0, $v0 		#store the user's input in $s0
	
	# input must be >= 0
	bge	$s0, $0, lNonnegEntry	#if $t0 >= 0 goto lNonnegEntry
	
	li	$v0, 4			#print error message
	la 	$a0, tryAgain   #print out try again error message
	syscall             #Do it
	j 	lInitialPrompt		#jump back to beginning of program to try again

lNonnegEntry: 				#Program goes here with successful entry
					#will always print out at least 1
	move  	$s1, $0			#$s1 start at zero
	move	$s2, $0			#$s2 start at zero
	move	$s3, $0			#L start at zero
loop:                       #loop for finding leonardo numbers
	beq 	$s0, $s3, loopOut	#if $s3 == $s0 skip to loopOut
	beq 	$s3, 1, oneLoop 	#if $s3 == 1 skip to oneLoop

	
	la 	$t3, ($s1)		    #$t3 = $s1 -- hold value aside
	
	addi 	$s1, $s1, 1		    #$s1 + 1
	add 	$s1, $s1, $s2 		#$s1 = $s1 + $s2 
	
	move 	$s2, $t3     #$t3 move to $s2
	
	
	li	$v0, 1			#Print out int
	la	$a0, 0($s1)		#Print out $s1
	syscall             #Do it
	
	li	$v0, 4			#print comma
	la	$a0, comma
	syscall		        #Do it
	
	addi 	$s3, $s3, 1		#$s3 (L) + 1	
	
	j	loop
	
oneLoop:				#loop of L = 1
	li	$s2, 1			#$s2 = 1
	
	li	$v0, 1			#Print out int
	la	$a0, 0($s1)		#Print out $s1
	syscall             #Do it
	
	li	$v0, 4			#Print a comma following num
	la	$a0, comma
	syscall		        #Do it
	
	addi 	$s3, $s3, 1		#$s3 + 1	
	
	j	loop		#go to beginning of loop
loopOut:  #loop output, ends the program
	beq 	$s0, 1, baseCase1	#if $s0 = 1 go to baseCase1	
	
	addi 	$s1, $s1, 1		#$s1 + 1
	add 	$s1, $s1, $s2 		#$s1 = $s1 + $s2 
	
	li	$v0, 1			#Print out int
	la	$a0, 0($s1)		#Print out $s1
	syscall             #Do it
	
	j 	end			#jump to the end of the program
	
baseCase1:				#print a 1 here 
	li	$v0, 1			#Print out int
	la	$a0, 0($s1)		#Print out $s1
	syscall             #Do it
	
end:	
	li	$v0, 10			# exit cleanly
	syscall	            #Do it
