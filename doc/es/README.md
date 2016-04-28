# GitBook Template

Versión {{ book.version }}, actualizada el {{ book.date }}

Ejemplo de documentación generada con GitBook puedes leer información de como modificar la documentación en la sección [Ayuda con GitBook](gitbook/README.md)

Uso de snippets de código

{% include "./snippets/example1.md" %}

Imagen de ejemplo
![Demo image](resources/keep-calm-portada.jpg)

Ejemplo de código

`````
<!DOCTYPE HTML>
<html>
<body>

  <p>Header...</p>

  <script>
    alert('Hello, World!')
  </script>

  <p>...Footer</p>

</body>
</html>
`````
Ejemplo de código java

```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World");
    }
}
```

Tabla de ejemplo

|   demo 1   |   demo 2   |   demo 3   |
|     --     |     --     |     --     |
|     11     |     21     |     31     |
|     12     |     22     |     32     |
|     13     |     23     |     33     |
|     14     |     24     |     34     |
