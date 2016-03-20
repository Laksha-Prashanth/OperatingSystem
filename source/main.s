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
	fbAddr .req r3
	ldr fbAddr,[fbInfoAddr,#32]
	
	ldr r0,=0xf0ff
	bl SetForeColour
	ldr r0,=0x5
	ldr r1,=0x5
	ldr r2,=0xfff5
	ldr r3,=0xfff5
	bl DrawLine
	
	mov r0,#75
	mov r1,#25
	mov r2,#25
	bl DrawCharacter
	b render$

.unreq fbAddr
.unreq fbInfoAddr
