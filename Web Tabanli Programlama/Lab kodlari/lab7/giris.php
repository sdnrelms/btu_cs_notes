<!-- https://chatgpt.com/share/68107d7d-0d3c-8007-a3ac-4b503030d0c2 -->
 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Giriş Formu</title>
    <style>
        body{
            font-family: sans-serif;
            margin-top: 200px;
            text-align: center;
        }
        h1, h2{
            font-family: Roboto;
            color: blue;
        }
        form{
            flex-direction: column;
            display: flex;
            justify-content: center; 
            align-items: center;   
        }
        .btn {
            margin-top: 20px;
        }
    </style>
</head>
<body>

<?php
if (isset($_COOKIE['kullanici'])) {
    echo "<h2>Hoş geldin, " . htmlspecialchars($_COOKIE['kullanici']) . "!</h2>";
    echo "<a href='cikis.php'>Çıkış yapmak için tıklayınız</a>";
} else {
?>
    <h1>Giriş Yap</h1>
    <form action="kontrol.php" method="post">
        <div>
            Kullanıcı Adı: <input type="text" name="kullanici_adi"><br><br>
            Şifre: <input type="password" name="sifre"><br><br>
        </div>
        <div class="btn"><button type="submit">GÖNDER</button></div>
    </form>
<?php
}
?>

</body>
</html>
