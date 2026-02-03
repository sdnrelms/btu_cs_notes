#start=Simple.exe# 
#start=LED_Display.exe# 

; SABIT VE DEGISKEN TANIMLAMALARI   

MATRIS_BOYUTU   EQU 7           ; Matris 7x7 boyutunda

data segment
    ; --- Veri Matrisi --- (bellekte 0700:0100 den gorulebilir)
    matris  db 0,1,1,1,1,1,1
            db 1,0,1,1,1,1,1
            db 1,1,0,1,1,1,1
            db 1,1,1,0,1,1,1
            db 1,1,1,1,0,1,1
            db 1,1,1,1,1,0,1
            db 1,1,1,1,1,1,0
            
    ; --- Sonuc ve Kontrol Degiskenleri ---
    satir_pariteleri db MATRIS_BOYUTU dup(0) ; Hesaplanan satir sonuclari
    sutun_pariteleri db MATRIS_BOYUTU dup(0) ; Hesaplanan sutun sonuclari
    
    hatali_satir_no  db 0       ; Hata yoksa 0, varsa satir numarasi
    hatali_sutun_no  db 0       ; Hata yoksa 0, varsa sutun numarasi
data ends

code segment
    assume ds:data, cs:code

start:
    ; Data segmentini ayarla
    mov ax, data
    mov ds, ax

; ANA PROGRAM DONGUSU (MAIN LOOP)
; Porttan gelen emre gore islem yapan alt programi cagirir.

KOMUT_BEKLEME_DONGUSU:
    in al, 110                  ; 110 nolu portu dinle
    
    cmp al, 1
    je ISLEM_HESAPLAMA_BASLAT   ; 1 geldi -> Hesaplama yap
    
    cmp al, 2
    je ISLEM_KONTROL_BASLAT     ; 2 geldi -> Kontrol yap
    
    jmp KOMUT_BEKLEME_DONGUSU   ; Baska bir sey geldiyse bekle

ISLEM_HESAPLAMA_BASLAT:
    call PARITE_HESAPLA_PROSEDURU ; Alt programi cagir
    jmp KOMUT_BEKLEME_DONGUSU     ; Is bitti, tekrar emir bekle

ISLEM_KONTROL_BASLAT:
    call HATA_KONTROL_PROSEDURU   ; Alt programi cagir
    jmp KOMUT_BEKLEME_DONGUSU     ; Is bitti, tekrar emir bekle


; PROSEDUR 1: PARITE HESAPLAMA (CALCULATE PARITY)
; Matrisin satir ve sutunlarini toplar, Odd Parity hesaplar. 

PARITE_HESAPLA_PROSEDURU proc near
    
    ; --- 1. Kisim: Satir Paritelerini Hesapla ---
    xor si, si                  ; Matris indisi (SI) sifirla
    xor di, di                  ; Parite dizisi indisi (DI) sifirla
    mov cx, MATRIS_BOYUTU       ; Dis dongu 7 kere donecek

HESAPLA_SATIR_DIS_DONGU:
    push cx                     ; Dis sayaci sakla (icerde CX degisecek)
    mov dl, 0                   ; Satir toplamini sifirla
    mov cx, MATRIS_BOYUTU       ; Ic dongu 7 kere donecek

HESAPLA_SATIR_IC_DONGU:
    add dl, matris[si]          ; Hucreyi toplama ekle
    inc si                      ; Sonraki hucreye gec
    loop HESAPLA_SATIR_IC_DONGU
    
    ; Odd Parity (Tek Eslik) Mantigi:
    ; Toplam tek ise sonuc 0, cift ise sonuc 1 olmali.
    and dl, 1                   ; Sayi tek mi cift mi
    xor dl, 1                   ; Sonucun tersini al
    mov satir_pariteleri[di], dl ; Kaydet
    
    inc di                      ; Sonraki satir sonucu icin yer ayarla
    pop cx                      ; Dis sayaci geri yukle
    loop HESAPLA_SATIR_DIS_DONGU
    
    ; --- 2. Kisim: Sutun Paritelerini Hesapla ---
    xor di, di                  ; DI'yi tekrar sifirla
    mov cx, MATRIS_BOYUTU
    
HESAPLA_SUTUN_DIS_DONGU:
    push cx
    mov si, di                  ; SI her seferinde sutun basina (0,1,2..) doner
    mov dl, 0                   ; Toplami sifirla
    mov cx, MATRIS_BOYUTU
    
HESAPLA_SUTUN_IC_DONGU:
    add dl, matris[si]
    add si, MATRIS_BOYUTU       ; 7 ekleyerek alt satirdaki hucreye zipla
    loop HESAPLA_SUTUN_IC_DONGU
    
    ; Odd Parity Hesapla ve Kaydet
    and dl, 1
    xor dl, 1
    mov sutun_pariteleri[di], dl
    
    inc di
    pop cx
    loop HESAPLA_SUTUN_DIS_DONGU
    
    ret                         ; Ana programa geri don
PARITE_HESAPLA_PROSEDURU endp


; PROSEDUR 2: HATA KONTROL (CHECK ERROR)
; Matrisi tekrar hesaplar ve kaydedilenle karsilastirir.     

HATA_KONTROL_PROSEDURU proc near
    ; Onceki hata kayitlarini temizle
    mov hatali_satir_no, 0
    mov hatali_sutun_no, 0
    
    ; --- 1. Kisim: Satir Kontrolu ---
    xor si, si
    xor di, di
    mov cx, MATRIS_BOYUTU

KONTROL_SATIR_DIS_DONGU:
    push cx
    mov dl, 0
    mov cx, MATRIS_BOYUTU

KONTROL_SATIR_IC_DONGU:
    add dl, matris[si]
    inc si
    loop KONTROL_SATIR_IC_DONGU
    
    ; Su anki durumu hesapla
    and dl, 1
    xor dl, 1
    
    ; Hafizadaki eski parite ile karsilastir
    cmp dl, satir_pariteleri[di]
    jne SATIR_HATASI_BULUNDU    ; Esit degilse hata var!
    
    inc di
    pop cx
    loop KONTROL_SATIR_DIS_DONGU
    jmp KONTROL_SUTUN_GECIS     ; Satirlar temizse sutunlara gec

SATIR_HATASI_BULUNDU:
    pop cx                      ; Stack duzenini bozmamak icin temizle
    mov ax, di
    inc al                      ; Index 0 tabanli, biz 1 tabanli istiyoruz
    mov hatali_satir_no, al     ; Hatali satiri kaydet
    ; Satiri bulduk ama sutuna da bakmaliyiz

KONTROL_SUTUN_GECIS:
    ; --- 2. Kisim: Sutun Kontrolu ---
    xor di, di
    mov cx, MATRIS_BOYUTU

KONTROL_SUTUN_DIS_DONGU:
    push cx
    mov si, di
    mov dl, 0
    mov cx, MATRIS_BOYUTU

KONTROL_SUTUN_IC_DONGU:
    add dl, matris[si]
    add si, MATRIS_BOYUTU
    loop KONTROL_SUTUN_IC_DONGU
    
    and dl, 1
    xor dl, 1
    cmp dl, sutun_pariteleri[di]
    jne SUTUN_HATASI_BULUNDU
    
    inc di
    pop cx
    loop KONTROL_SUTUN_DIS_DONGU
    jmp SONUCU_PORTA_YAZ

SUTUN_HATASI_BULUNDU:
    pop cx
    mov ax, di
    inc al
    mov hatali_sutun_no, al

SONUCU_PORTA_YAZ:
    ; Formul: (SatirNo * 10) + SutunNo
    ; Ornek: Satir 2, Sutun 3 hataliysa -> Port'a 23 gider.
    ; Hata yoksa 0 ve 0 -> Port'a 0 gider.
    
    mov al, hatali_satir_no
    mov bl, 10
    mul bl                      ; Satir * 10
    add al, hatali_sutun_no     ; + Sutun
    
    out 199, al                 ; Sonucu 199 portuna gonder
    ret                         ; Ana programa geri don
HATA_KONTROL_PROSEDURU endp

code ends
end start