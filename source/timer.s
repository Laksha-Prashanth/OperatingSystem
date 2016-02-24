.globl GetSystemTimerBase
GetSystemTimerBase:
ldr r0,=0x20003004
mov pc,lr

.globl GetTimeStamp
GetTimeStamp:
push {lr}
bl GetSystemTimerBase
ldrd r0,r1,[r0,#0]
pop {pc}

.globl Wait
Wait:
mov r2,r0
push {lr}
bl GetTimeStamp
add r2,r0

loop$:
bl GetTimeStamp
cmp r0,r2
bls loop$

pop {pc}
