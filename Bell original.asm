name "Bell Triangle using Intel 8086"

org 100h  

mov ax,0
mov bx,0
mov cx,0 
mov dx,0
;DOS INT 21h services
;AH	    Description
;00h	Program terminate
;01h	Character input
;02h	Character output
mov ah, 1
int 21h
; AL now contains the number of rows
; 8086 reads integers as characters so sutract 30 to convert ASCII code of no to integer
; ch is no of rows
; bh is index of element
; bl is the no to print
; dh is theno to add to precedding element
; if bh is equal to ch we move to a new row
sub al,30h
mov ch,al 
;mov cx,ax
; Go down for a new line
; convert to dx 
mov dx,13
mov ah,2
int 21h  
mov dx,10
mov ah,2
int 21h
; end for new line   
mov al,1
add al,30h
mov dl,al 
mov ah,2h 
int 21h
sub al,30h
mov ah,0
mov dl,0
mov j,1h
mov dl,' '
mov ah,2h
int 21h 
mov ah,0
mov dl,0 
inc bh 
jmp start ; go to code...

; ----- matrix ------
matrix     db 1,1,2 
;--------------------
; i is index of row starting from 1
; j is index of coloumn starting from 1
; k is the total number of rows    
; m is the number to print
; q is the number to add to preceeding element  
; n is difference between every element and its preceeding
i db ?
j db ?
k db ? 
m db ?
n db ?
q db ?
s dw ?

start: 
mov i, 1h
mov j, 3h
mov k, ch
mov m, 1h
mov q, 0h
mov s,0h

next_i:

	mov ch, i
	inc ch
	mov i, ch
;	mov ch,q
;   inc ch
;	mov q, ch 
mov bh,i
mov ch,j
cmp bh,ch       
jz compare

; Go down for a new line
; convet to dx
newline: mov dx,13
mov ah,2
int 21h  
; convert to dx
mov dx,10
mov ah,2
int 21h         
printsame:  
;add 30 to convert back to ASCII code   
mov al,m
add al,30h
mov dl,al 
mov ah,2h 
int 21h
;sub al,30h
mov ah,0
mov dl,0
mov j,1h
mov dl,' '
mov ah,2h
int 21h 
mov ah,0
mov dl,0 
inc bh
	next_j:
	
; print number  
; m is the number to print
; q is the number to add to preceeding element
printno:
mov bx,s
mov ch,matrix[bx]
add s,1
;mov bl,q
;mov cl,m
;add bl,cl
;mov m,bl
add m,ch
mov al,m   
;add 30 to convert back to ASCII code 
add al,30h
mov dl,al 
mov ah,2h 
int 21h
sub al,30h
mov ah,0
mov dl,0
; leave a blank space
mov dl,' '
mov ah,2h
int 21h 
mov ah,0
mov dl,0 
inc bh  
; end leave a blank space    

	inc j
	mov bh,i
	mov ch,j
	cmp bh,ch
	jz compare
	jnz next_j
	
compare: mov bh,i
         mov ch,k
         cmp bh,ch	
         jz endprog  
         jnz next_i
           
endprog:     
ret
           
           