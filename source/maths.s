.globl DivideU32
DivideU32:
result .req r0
remainder .req r1
shift .req r2
current .req r3

clz shift,r1
clz r3,r0
subs shift,r3
lsl current,r1,shift
mov remainder,r0
mov result,#0


loop$:
	cmp shift,#0
	blt end$
	cmp remainder,current

	addge result,result,#1
	subge remainder,current
	sub shift,#1
	lsr current,#1
	lsl result,#1
	b loop$

end$:
.unreq current
mov pc,lr

.unreq result
.unreq remainder
.unreq shift
