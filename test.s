;-------------------------------------------------------------
; Simple test of BadAss assembler. 
; The main prg incbin's the object files.
; We then copy them to alternate locations and run them.
; Those files are simple relocatable tasklets to test out the assembler.
;-------------------------------------------------------------

	!section "ZP",2,size=254,NO_STORE
	!section "RAM",$801
	!section "Virtual",$1000,size=$1000,NO_STORE

  ;-------------------------------------------------------------
  ; Traditional startup code
  ;-------------------------------------------------------------

	!section "code",in="RAM"
	!byte $0b,$08,$01,$00,$9e,str(start),$00,$00,$00

start:
	sei
	lda test0
	lda #<space
	lda #>space
	sta $d020
		
	;	copy both functions to spare memory
	; $3000
	;	Object1.bin 
	lda #<o1+2 
	sta $2 
	lda #>o1+2 
	sta $3 
	lda #$00 
	sta $4
	lda #$30
	sta $5
	jsr CopyBlock

	;	Object2.bin 
	lda #<o2+2 
	sta $2 
	lda #>o2+2 
	sta $3 
	lda #$00 
	sta $4
	lda #$31
	sta $5
	jsr CopyBlock

	;	call the init of each task 

	lda #$00 
	jsr $3000

	lda #$00 
	jsr $3100

  ;-------------------------------------------------------------
	; Stall / mainloop
  ;-------------------------------------------------------------

again:
	lda $d012 
	cmp #$80 
	bne again

	;	call both tasks
	lda #$1 
	jsr $3000
	lda #$1 
	jsr $3100

	jsr anotherfunc
	jmp again

CopyBlock:
	ldy #$00 
-	
	lda ($2),y 
	sta ($4),y
	iny
	bne -
	rts
;-------------------------------------------------------------
; Storing more ZP data for testing
;-------------------------------------------------------------
!section "variables",in="ZP"
	test0: !ds 1

;-------------------------------------------------------------
; Back to code ( testing switching )
;-------------------------------------------------------------
!section "another",in="RAM"
anotherfunc:
	rts

!section "Objects",in="RAM"
o1:
	!incbin "Object1.bin"
o2:
	!incbin "Object2.bin"

;-------------------------------------------------------------
; Virtual tables space testing
;-------------------------------------------------------------
!section "filler",in="Virtual"
space:
	!ds 256
space2:
	!ds 256





