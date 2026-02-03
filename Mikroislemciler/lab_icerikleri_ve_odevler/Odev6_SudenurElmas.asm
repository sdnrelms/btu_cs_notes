#start=thermometer.exe# 
#start=Simple.exe# 

#make_bin#  
 
name "thermo"

start:
    
    IN AL, 110      ; port 110 dan kullanicinin girdigi degeri oku
    MOV BL, AL      ; hedef sicakligi BL yazmacina yedekle
                                             
    IN AL, 125      ; port 125'ten o anki sicakligi oku
    
    MOV CL, BL      ; hedef sicakligi CL'ye kopyala
    INC CL          ; CL = hedef + 1 (maksimum izin verilen)
    
    CMP AL, CL      ; mevcut sicaklik (hedef+1) ile karsilastir               
    JGE ISITICI_KAPAT   ; eger mevcut >= (hedef+1) ise kapat
    
    CMP AL, BL      ; mevcut sicaklik hedef ile karsilastir
    JL ISITICI_AC   ; eger mevcut < hedef ise ac
    
    JMP start       ; hedef <= mevcut < (hedef+1) ise mevcut durumu koru, basa don
    
ISITICI_KAPAT:
    MOV AL, 0       ; isiticiyi kapatmak icin 0 degeri hazirla
    OUT 127, AL     ; port 127'ye 0 gonder 
    JMP start       ; basa don 
ISITICI_AC:
    MOV AL, 1       ; isiticiyi acmak icin 1 degeri hazirla.
    OUT 127, AL     ; port 127'ye 1 gonder 
    JMP start       ; basa don