# Documentación de Viafirma Core

La documentación se genera haciendo uso de markdown y GitBook [GitBook](https://github.com/GitbookIO/gitbook)

### Cómo colaborar

Para modificar la documentación solo hay que añadir o modificar uno de los fichero .md existentes dentro de la carpeta doc de este proyecto, puedes consultar la sintasis desde [Markdown Guide](https://guides.github.com/features/mastering-markdown/)

Si necesitas añadir imágenes, puedes añadirlas dentro de una carpeta resources dentro de la carpeta de la sección de correspondiente.

Una vez modificada o añadida la documentación puedes hacer pull request de los cambios, una vez revisados los cambios y realizado el merge en master se ejecutará la siguiente tarea de Jenkins http://dev.viafirma.com/jenkins/XXXXXX/ que genera el nuevo documento en formato pdf y actualizará la documentación online en formato html.

Si añades una nueva sección al documento recuerda que tienes que añadirla en el fichero ./doc/SUMMARY.md

### Actualizar documentación desde Mac OSX

#### Instalación de GitBook con NPM

````
$ npm install gitbook -g
````

#### Instalación versión de GitBook con NPM

```
$ npm uninstall -g gitbook
$ npm install -g gitbook-cli
$ gitbook versions:install latest
$ gitbook versions
```

#### Instalación de Calibre

* Descargar desde: http://code.calibre-ebook.com/dist/osx
* Instalar Calibre
* Añadir Calibre al PATH (puedes añadirlo a ~/.zshrc)

````
export PATH=$PATH:/Applications/calibre.app/Contents/MacOS
````

#### Actualizar documentación

Ejecutar el shell script doc-build.sh

````
./doc-build.sh
````

### Configuración de GitBook

Para facilitar la integración con GitBook se ha preparado el shell script ./doc-build.sh que realiza lo siguiente:

* Añade en el README.md la versión del pom de viafirma-core y la fecha actual
* Genera páginas html
* Genera PDF

#### Configuración de GitBook

* La portada del pdf es la imagen ./doc/cover.jpg
* Todos los .md tienen que estar enlazados en ./doc/SUMMARY.md
* La generación de html se configura en el fichero ./doc/configure-html.json
* La generación de PDF se configura en el fichero ./doc/configure-pdf.json
