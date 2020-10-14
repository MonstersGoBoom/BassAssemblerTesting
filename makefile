
all: main.prg

Object1.bin: objects.s 
	bass -s objects.lst -S objects.s 


main.prg: test.s Object1.bin 
	bass -s test.lst -S test.s -o main.prg 

clean:
	rm main.prg 
	rm Object1.bin	
	rm Object2.bin	

