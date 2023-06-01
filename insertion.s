.text
.global _start
.extern printf

_start:
	ldr x9, = arr
	ldr x10, = size
	ldr x10, [x10]
	mov x12, xzr			//x12 = j
	add x11, x12, #1		//x11 = i
	mov x13, xzr			//x13 = key
	mov x21, xzr			//just testing 
	bl insertion
	bl prnt
	b finn

.func insertion

insertion:
	sub sp, sp, #8
	str x30, [sp]
	//---------------
	//outer for loop:
	//---------------
outer:	subs xzr, X11, X10
	b.ge exitfunc
	ldr x13, [x9, x11, lsl #3]
	sub x12, x11, #1
	//-----------------
	//inner while loop:
	//-----------------
inner:  subs xzr, x12, x21
	b.lt endinn
	ldr x14, [x9, x12, lsl #3]
	CMP x14, x13
	b.le endinn
	add x12, x12, #1
	str x14, [x9, x12, lsl #3]
	sub x12, x12, #2
	b inner
endinn: add x15, x12, #1
	str x13, [x9, x15, lsl #3] 
	add x11, x11, #1
	b outer
exitfunc:
	ldr x30, [sp]
	br x30
	.endfunc

finn:
	mov x0, #0
	mov W8, #93
	SVC #0


.func prnt

prnt:
	add sp, sp, #24
	str x9, [sp]
	str x10, [sp, #8]
	str x30, [sp, #16]
	mov x26, xzr
loop:	subs xzr, x26, x10
	b.ge done
	ldr x0, =format
	ldr x1, [x9, x26, lsl #3]
	bl printf
	ldr x9, [sp]
	ldr x10, [sp, #8]
	add x26, x26, #1
	b loop
done:
	ldr x9, [sp]
	ldr x10, [sp, #8]
	ldr x30, [sp, #16]
	sub sp, sp, #24
	br x30
	.endfunc	

.data
arr:
	.quad 5, 3, 8, 6, 0, -6, 26, -50
size:
	.dword 8
format:
	.asciz "%d \n"

.end
