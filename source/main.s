.section .init
.globl _start

_start:
b main

.section .text
main:
mov sp,#0x8000

mov r0,#1024
mov r1,#768
mov r2,#16
bl InitialiseFrameBuffer

//Switch on OK LED if there is a problem
teq r0,#0
bne noError$

mov r0,#16
mov r1,#1
bl SetGpioFunction
mov r0,#16
mov r1,#0
bl SetGpio

error$:
b error$

noError$:
fbInfoAddr .req r4
mov fbInfoAddr,r0

bl SetGraphicsAddress

render$:
	
	ldr r0,=0xf0ff
	bl SetForeColour
	ldr r0,=0x5
	ldr r1,=0x5
	ldr r2,=0xfff5
	ldr r3,=0xfff5
	bl DrawLine

	ldr r0,=stri
	mov r1,#7
	mov r2,#105
	mov r3,#105
	bl DrawString
	
	ldr r0,=0x00ff
	bl SetForeColour
	ldr r0,=0x5
	ldr r1,=0x55
	ldr r2,=0x25
	ldr r3,=0xfff5
	bl DrawLine

	b render$

.section .data
.align 4
stri:
.int 0x4444
