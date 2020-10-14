	; simple test of BadAss assembler 
	;	creates 3 files 
	; 2 object.bin files for different "tasks"
	; the main prg incbin's those files 
	;	we then copy them to alternate locations and run them

	!section "ZP",2,size=254,NO_STORE

;	seperate file
!section "Object1.bin",$4000,NO_STORE|TO_PRG
Object:
	beq .init
	.main:
		inc .data
		lda .data
		sta $d020 
		rts
	.init:
		lda #$00
		sta .data
		rts 

	;	shared variables
	!section "Object.variables",in="ZP"
	.data: 
		!ds 1
	.dataword:
		!ds 1

;	seperate file
!section "Object2.bin",$4100,NO_STORE|TO_PRG
Object2:
	.main:
		lda .data
		sta $d021
		rts
	;	shared variables with Object
	!section "Object.variables",in="ZP"
	.data: 
		!ds 1
	.dataword:
		!ds 1





