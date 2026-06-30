org 100h

start:
    mov ax, 0900h       ;ax'e segment adresi yukle
    mov es, ax          ;ekstra segmenti 0900h yap
    
    
    mov cx, 101         ;sayac - 0'dan 100'e kadar 101 sayi
    mov si, 0200h       ;bellekteki hedef adres 0900:0200
    mov bx, 0           ;karekoku alinacak ilk sayi(0'la baslar)

dongu:    
    call karekok        ;alt programi cagir 
    
    mov es:[si], al     ;sonucu bellek adresine yaz
    inc si              ;sonraki bellek adresine gec
    inc bx              ;bir sonraki karekoku alinacak sayi   
    
    loop dongu          ;cx'i azalt 0 degilse devam
    
    ;program sonlandirma
    mov ah, 4ch
    int 21h  
                        
                        
;karekoku alinacak sayi -> bx
;sonuc - tam sayi kismi -> ax
;(n+1)^2 > BX olana kadar devam et 

karekok proc
    push bx             ;bx'i koru (girdi degeri)
    push cx             ;cx'i koru (aday sayi)
    push dx             ;dx'i koru (carpma sonucu icin)
    
    xor ax, ax          ;ilk aday - 0
    
karekok_dongu:
    mov cx, ax          ;cx mevcut aday
    inc cx              ;cx aday'in bir fazlasi
    
    mov ax, cx          ;ax aday + 1
    mul cx              ;(aday+1)^2
    
    test dx, dx         ;tasma oldu mu kontrolu
    jnz karekok_bitti   ;DX != 0 ise 16 bit asti
    
    cmp ax,bx           ;alinan kare degeri karekoku alinacak degeri gecerse
    ja karekok_bitti    ;dur - son gecerli aday oldu
    
    mov ax, cx          ;bir sonraki aday
    jmp karekok_dongu   ;bu donguye devam et
   
karekok_bitti:
    dec cx              ;-1 yapiyoruz cunku deger bx'i gecmisti, bi kucugu en yakin olur
    mov ax, cx          ;sonucu ax e koy
    
    pop dx              ;dx, cx ve bx'i geri yukle
    pop cx
    pop bx
    ret                 ;ana programa don
    
karekok endp

end start
    
    