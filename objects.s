;-------------------------------------------------------------
; Simple test of BadAss assembler.
; Creates 2 files.
; 2 object.bin files for different "tasks".
; Which are loaded by the test.s project.
;-------------------------------------------------------------

  !section "ZP",2,size=254,NO_STORE

;-------------------------------------------------------------
; Seperate file.
; This is a simple "task".
; no jmp / jsr to internal functions in here makes it relocatable.
;-------------------------------------------------------------

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
	
  ;-------------------------------------------------------------
  ; shared variables
  ; these are in the same space for both objects
  ;-------------------------------------------------------------
	!section "Object.variables",in="ZP"
	.data: 
		!ds 1
	.dataword:
		!ds 1
;-------------------------------------------------------------
; seperate file
; this is another simple "task"
; no jmp / jsr to internal functions in here makes it relocatable
;-------------------------------------------------------------

!section "Object2.bin",$4100,NO_STORE|TO_PRG
Object2:
	.main:
		lda .data
		sta $d021
		rts

  ;-------------------------------------------------------------
  ; shared variables with Object
  ; these are in the same space for both objects
  ;-------------------------------------------------------------
	!section "Object.variables",in="ZP"
	.data: 
		!ds 1
	.dataword:
		!ds 1





