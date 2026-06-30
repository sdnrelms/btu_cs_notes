PORTA EQU 110     ; Input port adresi
PORTB EQU 199     ; LED display output port adresi

DATA SEGMENT
    carpan      DW 1234h, 5678h      ; 32 bit carpan 
    carpilan    DW 0ABCDh, 9876h     ; 32 bit carpilan 
    sonuc       DW 0, 0, 0, 0        ; 64 bit carpim sonucu
    temp_carpilan DW 0, 0, 0, 0      ; Carpilan kopyasi (her adimda 2 katina cikar)
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA

start:
    MOV AX, DATA                     ; DATA segment adresini AX'e yukle
    MOV DS, AX                       ; DS register'ini DATA'ya isaret ettir
    
    ; Sonucu sifirla (64 bit = 4 word)
    XOR AX, AX                       ; AX = 0
    MOV [sonuc], AX                  ; Sonucun 0-15 bitlerini 0
    MOV [sonuc+2], AX                ; Sonucun 16-31 bitlerini 0
    MOV [sonuc+4], AX                ; Sonucun 32-47 bitlerini 0
    MOV [sonuc+6], AX                ; Sonucun 48-63 bitlerini 0
    
    ; Carpilani gecici alana kopyala
    MOV AX, [carpilan]               ; Carpilanin alt 16 bitini al
    MOV [temp_carpilan], AX          ; Gecici alana kopyala
    MOV AX, [carpilan+2]             ; Carpilanin ust 16 bitini al
    MOV [temp_carpilan+2], AX        ; Gecici alana kopyala
    XOR AX, AX                       ; AX = 0
    MOV [temp_carpilan+4], AX        ; Ust kismi 0'la doldur (32-47 bit)
    MOV [temp_carpilan+6], AX        ; Ust kismi 0'la doldur (48-63 bit)
    
    MOV CX, 32                       ; 32 iterasyon (32 bit carpan icin)

tekrar:
    ; Carpanin en dusuk bitini kontrol et
    TEST WORD PTR [carpan], 1        ; LSB = 1 mi?
    JZ sadece_kaydir                 ; Eger 0 ise toplamaya gerek yok
    
    ; LSB 1 ise temp_carpilani sonuca ekle (64-bit toplama)
    CLC                              ; Carry flag'i temizle
    MOV AX, [sonuc]                  ; Sonucun 0-15 bitini al
    ADD AX, [temp_carpilan]          ; temp_carpilanin 0-15 bitini ekle
    MOV [sonuc], AX                  ; Geri yaz
    
    MOV AX, [sonuc+2]                ; Sonucun 16-31 bitini al
    ADC AX, [temp_carpilan+2]        ; temp_carpilanin 16-31 bitini ekle (carry ile)
    MOV [sonuc+2], AX                ; Geri yaz
    
    MOV AX, [sonuc+4]                ; Sonucun 32-47 bitini al
    ADC AX, [temp_carpilan+4]        ; temp_carpilanin 32-47 bitini ekle (carry ile)
    MOV [sonuc+4], AX                ; Geri yaz
    
    MOV AX, [sonuc+6]                ; Sonucun 48-63 bitini al
    ADC AX, [temp_carpilan+6]        ; temp_carpilanin 48-63 bitini ekle (carry ile)
    MOV [sonuc+6], AX                ; Geri yaz

sadece_kaydir:
    ; temp_carpilani sola kaydir (64-bit sola kaydirma, deger 2 katina cikar)
    CLC                              ; Carry flag'i temizle
    RCL WORD PTR [temp_carpilan], 1  ; 0-15 bitleri sola kaydir
    RCL WORD PTR [temp_carpilan+2], 1; 16-31 bitleri sola kaydir (carry ile)
    RCL WORD PTR [temp_carpilan+4], 1; 32-47 bitleri sola kaydir (carry ile)
    RCL WORD PTR [temp_carpilan+6], 1; 48-63 bitleri sola kaydir (carry ile)
    
    ; Carpani saga kaydir (32-bit saga kaydirma, bir sonraki biti kontrol et)
    SHR WORD PTR [carpan+2], 1       ; Ust 16 biti saga kaydir
    RCR WORD PTR [carpan], 1         ; Alt 16 biti saga kaydir (ust wordden gelen carry ile)
    
    LOOP tekrar                      ; CX--, CX 0 degilse devam et

; Port islemleri - Kullanici menusu
menu:
    MOV DX, PORTA                    ; Input port adresini DX'e yukle
    IN  AL, DX                       ; Kullanicinin secimini oku

    CMP AL, 1                        ; Secim 1 mi
    JE  goster_alt                   ; Evet, alt 16 biti goster
    CMP AL, 2                        ; Secim 2 mi
    JE  goster_16_31                 ; Evet, 16-31 bitleri goster
    CMP AL, 3                        ; Secim 3 mu
    JE  goster_32_47                 ; Evet, 32-47 bitleri goster
    CMP AL, 4                        ; Secim 4 mu
    JE  goster_ust                   ; Evet, ust 16 biti goster
    JMP menu                         ; Gecersiz secim, tekrar sor

goster_alt:
    MOV AX, [sonuc]                  ; Sonucun 0-15 bitini AX'e al
    JMP yazdir                       ; Display'e yazdir

goster_16_31:
    MOV AX, [sonuc+2]                ; Sonucun 16-31 bitini AX'e al
    JMP yazdir                       ; Display'e yazdir

goster_32_47:
    MOV AX, [sonuc+4]                ; Sonucun 32-47 bitini AX'e al
    JMP yazdir                       ; Display'e yazdir

goster_ust:
    MOV AX, [sonuc+6]                ; Sonucun 48-63 bitini AX'e al

yazdir:
    MOV DX, PORTB                    ; Output port adresini DX'e yukle
    OUT DX, AX                       ; AX'i LED display'e gonder
    JMP menu                         ; Menuye geri don

CODE ENDS
END start                            ; Program giris noktasi