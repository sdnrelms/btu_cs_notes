ORG 100h

.DATA
; 10 adet rastgele 32-bit (DoubleWord) sayi yerlesimi
SAYILAR DD 12345678h, 9ABCDEF0h, 11113111h, 22222222h, 33333433h
        DD 44444444h, 33310013h, 00000001h, FFFFFFFFh, 88888885h 

.CODE
START:
    ; Sonuclarin yazilacagi ES:DI adresi (0700:0300) 
    MOV AX, 0700h
    MOV ES, AX
    MOV DI, 0300h
    
    LEA SI, SAYILAR     ; Sayilarin baslangic adresi
    MOV CX, 10          ; 10 adet sayi var

DONGU_HESAPLA:     

    MOV AX, [SI]        ; Dusuk 16 bit
    MOV BX, [SI+2]      ; Yuksek 16 bit
    
    ; 32 bitin parity'sini hesapla (XOR ile bit sayisini azalt)
    XOR AX, BX          ; 32 bit -> 16 bit'e indir
    XOR AL, AH          ; 16 bit -> 8 bit'e indir (AL'de son durum)
    
    OR AL, AL           ; Parity Flag'i guncelle   
    JPO TEK_ESLIK       ; PF=0 ise (tek sayida 1 biti) atla
    
CIFT_ESLIK:
    MOV AL, 00h         ; Cift eslik ise 00h 
    JMP KAYDET

TEK_ESLIK:
    MOV AL, 01h         ; Tek eslik ise 01h 

KAYDET:
    STOSB               ; AL'yi ES:[DI]'ya yaz ve DI'yi 1 artir
    ADD SI, 4           ; Bir sonraki DoubleWord (4 byte) icin SI'yi artir
    LOOP DONGU_HESAPLA  ; 10 sayi bitene kadar don

IO_DONGUSU:
    IN AL, 110          ; Port 110'dan veri oku
    
    ; 1-10 araligini kontrol et
    CMP AL, 1
    JB IO_DONGUSU       ; 1'den kucukse bekle
    CMP AL, 10
    JA IO_DONGUSU       ; 10'dan buyukse bekle
    
    DEC AL              ; 1-10 araligini 0-9 array index'ine cevir
    MOV BL, AL          ; Indexi BL'ye al
    MOV BH, 0           ; BH sifirla
    
    ; Bellekten ilgili parity sonucunu oku
    MOV DI, 0300h
    ADD DI, BX          ; Baslangic + Index (Baslangic adresi)
    
    MOV AL, ES:[DI]     ; Parity sonucunu (0 veya 1) AL'ye cek
    MOV AH, 0           ; Gosterge icin AH temizle
    
    ; Port 199'a yaz (LED Display)
    OUT 199, AX         
    
    JMP IO_DONGUSU      ; Surekli kontrol et

RET                         


