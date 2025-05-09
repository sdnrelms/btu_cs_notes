<?php
include 'admin_configs.php';

$kullanici_adi = $_POST['kullanici_adi'];
$sifre = $_POST['sifre'];

$giris_basarili = false; 

foreach ($admins as $kullanici => $parola) {
    if ($kullanici == $kullanici_adi && $parola == $sifre) {
        $giris_basarili = true;
        break; 
    }
}

if ($giris_basarili) {

    setcookie("kullanici", $kullanici_adi, time() + (86400 * 7)); // 1 haftalık

    echo "<h2>Giriş Başarılı!</h2>";
    echo "Hoş geldin, $kullanici_adi.";
} else {
    echo "<h2>Giriş Başarısız!</h2>";
    echo "Kullanıcı adı veya şifre yanlış.";
}
?>
