data segment
    ; Siralanacak 10 adet birer byte'lik dizi

    sayilar db 0F2h,0A3h,0C1h,88h,70h,4Eh,29h,1Bh,05h,00h     
    
    ; sayilar dizisi DS:offset(sayilar) adresinde baslar ve 10 byte boyunca devam eder, simulasyonu calistirdiktan sonra view->memory kismini acilarak bakilabilir  
data ends

code segment
    assume ds:data, cs:code    ; Segment register'larini tanimla
    
start:
    mov ax, data      ; Data segmentinin adresini AX yazmacina yukle
    mov ds,ax         ; AX'teki adresi DS yazmacina aktar
    
    mov bx, 0         ; Dizi baslangic ofseti olarak BX'i sifirla
    mov cx, 0         ; Dis dongu sayaci (i = 0)
    
dis_dongu:            ; Dis dongu baslangici
    cmp cx, 9         ; Dongu sayaci 9 oldu mu kontrol et 
    jae bitir         ; Eger cx >= 9 ise programi bitirmeye git
    
    mov si, cx        ; O anki konumu (cx) en kucuk elemanin indeksi (si) olarak varsay
    
    mov di, cx        ; Ic dongu icin di'ye cx degerini ata
    inc di            ; Ic dongu bir sonraki elemandan baslasin (j = i + 1)
    
ic_dongu:             ; Ic dongu baslangici
    cmp di, 10        ; Ic dongu dizinin sonuna geldi mi?
    jae degistirme    ; Eger geldiyse, degistirme islemine git
    
    mov al, [bx + si] ; Su ana kadar bulunan en kucuk sayiyi AL'ye yukle
    cmp [bx + di], al ; Siradaki sayiyi (di), eldeki en kucukle (al) karsilastir
    jae pas_gec       ; Eger siradaki sayi daha buyuk veya esitse, islem yapma -> pas_gec'e git
    
    mov si, di        ; Eger daha kucuk bir sayi bulunduysa, yeni en kucuk indeksini (si) guncelle
    
pas_gec:
    inc di            ; Ic dongu sayacini bir artir (bir sonraki sayiya gec)
    jmp ic_dongu      ; Ic dongunun basina don
    
degistirme:           ; Swap - degistirme islemi
    
    mov di, cx        ; DI'ya dis dongudeki o anki sirayi (i) ata
    
    mov al, [bx + di] ; O anki siradaki (i) sayiyi AL'ye al
    mov ah, [bx + si] ; Bulunan en kucuk sayiyi (si) AH'ye al
    
    mov [bx + di], ah ; En kucuk sayiyi, o anki siraya (i) yaz
    mov [bx + si], al ; O anki siradaki sayiyi, en kucuk sayinin eski yerine yaz
    
    inc cx            ; Dis dongu sayacini bir artir
    jmp dis_dongu     ; Dis dongunun basina don
    
bitir:
    mov ah, 4ch       
    int 21h           
    
code ends
end start