# Cloud Computing - TP3: Deployment recursos de infraestructura

## Participación

| Legajo | Nombre        | Participación |
|--------|---------------|------------|
| 57440  | Hinojo Toré, Nicole R.   | 25%        |
| 60142  | Spitzner, Agustín | 25%        |
| 60212  | Riera Torraca, Valentino | 25%        |
| 60401  | Zahnd, Martín E.   | 25%        |

## Descripción

El proyecto consiste en una aplicacion web que funciona como portal de gestion de turnos, focalizado en nuestro caso para el ámbito medico.

## Documentacion

- [Cambios en cuanto a tp2](doc/Architecture_Full_Fixed.pdf)
- [Arquitectura a deplegar](doc/Architecture_TP3.pdf)
## Preparación

Se requiere tener instalado terraform, para la conexión con aws se requiere actualizar con las credenciales de AWS el archivo: `~/.aws/credentials`.

Tambien se debe setear en la parte de [locals](/organization/locals.tf) el account_id al que vaya a ser utilizado 

## Componentes deployados

1. VPC
2. Api gateway
3. Lambda con funcionalidad mockeada
4. Tablas de DynamoDb
5. Bucket de sitio estático
6. Cloudfront (para bucket y api-gw)

## Comandos a correr

```bash
# root del proyecto
$ cd terraform/organization
# inicializar el proyecto, descargar dependencias
$ terrafom init
# cambios a ocurrir
$ terrafom plan
# aplicar los cambios
$ terraform apply
```
## Algunas Funciones utilizadas

- [format, try, replace](/modules/storage/main.tf)
- [filebase64sha256](/modules/lambda/main.tf)

## Meta argumentos

- [count](/modules/storage/main.tf)
- [for_each, depeds_on](/organization/main.tf)

## Problemas

Tenemos problemas en la configuracion del sitio web estatico y sus permisos, pero los elementos están creados.
