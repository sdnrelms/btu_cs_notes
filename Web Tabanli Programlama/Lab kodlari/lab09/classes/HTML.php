<?php
class HTML
{
    public static function __callStatic($name, $arguments)
    {
        $content = '';
        $attributes = '';

        // ilk parametre kontrolu
        if (isset($arguments[0])) {
            $content = $arguments[0];
        }

        // ikinci parametre varsa ve iliskili dizi ise isleme
        if (isset($arguments[1]) && is_array($arguments[1])) {
            foreach ($arguments[1] as $key => $value) {
                $attributes .= ' ' . $key . '="' . htmlspecialchars($value) . '"';
            }
        }

        // etiket olarak return etme
        return "<$name$attributes>$content</$name>";
    }
}
?>
