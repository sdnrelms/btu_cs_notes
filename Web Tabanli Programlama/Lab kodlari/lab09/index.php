<?php
spl_autoload_register(function ($class_name) {
    $file = __DIR__ . '/classes/' . $class_name . '.php';       // classes dizinine gitme
    if (file_exists($file)) {
        include $file;
    } else {
        echo "Hata: '$class_name' sınıfına ait dosya bulunamadı ($file)<br>";
    }
});

// Deneme
echo HTML::body(
    HTML::div(
        HTML::h1("Örnek bir başlık.") . HTML::p("Örnek bir paragraf."),
        ['class' => 'container']
    )
);
?>
