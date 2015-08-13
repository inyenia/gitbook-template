# Cómo colaborar con la documentación

Esta documentación se genera haciendo uso de markdown y GitBook [GitBook](https://github.com/GitbookIO/gitbook)

Para modificar la documentación solo hay que añadir o modificar uno de los fichero .md existentes dentro de la carpeta doc de este proyecto, puedes consultar la sintasis desde [Markdown Guide](https://guides.github.com/features/mastering-markdown/)

Puedes descargar el editor de GitBook para tu sistema operativo desde https://github.com/GitbookIO/editor/releases una vez instalada solo tienes que abrir la carpeta doc del proyecto con la app.

Si necesitas añadir imágenes, puedes añadirlas dentro de la carpeta resources. Añadir dentro de esta carpeta el fuente de la imagen por si es necesario modificarla.

Puedes añadir la imágenes con el siguiente código

```
![Image demo](resources/keep-calm-portada.jpg)
```

Si añades una nueva sección al documento recuerda que tienes que añadirla en el fichero ./doc/SUMMARY.md si no utilizas el editor de GitBook.

### Generar documentación en formato PDF y HTML

Esta documentación esta genereda con la versión 2.1.0 de GitBook si tienes instalado en tu equipo una versión inferior a la 2.0.0 necesitas desistalar la antigua versión de GitBook con el siguiente comando.

###### Desistalar GitBook con NPM

````
$ npm uninstall -g gitbook
````

###### Instalar versión de GitBook con NPM

```
$ npm install -g gitbook-cli
$ gitbook versions:install latest
$ gitbook versions
```

###### Instalación de Calibre

Se necesita tener instalada la app Calibre para poder generar la documentación en formato pdf.

* Descargar desde: http://code.calibre-ebook.com/dist/osx
* Instalar Calibre
* Añadir Calibre al PATH (puedes añadirlo a ~/.zshrc)

````
export PATH=$PATH:/Applications/calibre.app/Contents/MacOS
````

#### Actualizar documentación

Para facilitar la integración con GitBook se ha preparado el shell script ./doc-build.sh que realiza lo siguiente:

* Añade en el README.md la versión del pom de tu proyecto o la versión indicada como parámetro y la fecha actual
* Genera páginas html
* Genera PDF

Por los que si tienes instalado GitBook y Calibre en tu equipo según lo explicado anteriormente puedes ejecutar el shell script doc-build.sh en tu equipo.

````
./doc-build.sh
````

Puedes insdicar la versión de la documentación a generar

````
./doc-build.sh 1.0.1
````

#### Configuración de GitBook

Desde el siguiete enlace se puede acceder a toda la documentación de GitBook http://help.gitbook.com

Los siguiente puntos son solo una pequeña ayuda.

* La portada del pdf es la imagen ./doc/cover.jpg
* Todos los .md tienen que estar enlazados en ./doc/SUMMARY.md
* La generación de html y pdf se configura en el fichero ./doc/book.json
* En la carpeta ./doc/styles/ se pueden modificar los ficheros pdf.css y html.css que configuran los estilos del pdf y html generado.
* En el fichero LANGS.md se configuran los idiomas disponibles, esta documentación está solo en español si la quisieramos traducir a inglés tendriamos que copiar el contenido de la carpeta ./doc/es a la carpeta ./doc/en traducirlo todo y añadir lo siguiente en el fichero LANGS.md

```
* [English](en)
```
