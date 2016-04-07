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

mov r0,#9
bl FindTag
ldr r1,[r0]
lsl r1,#2
sub r1,#8
add r0,#8
mov r2,#0
mov r3,#0
bl DrawString
loop$:
b loop$

.section .data
.align 4
stri:
.int 0x4444
