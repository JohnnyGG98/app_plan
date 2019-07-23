# APP Plan

Proyecto enfocado a trabajar con la base de datos del Instituto TECAZUAY.  

## Objetivos

- Listado de alumnos.
- Visualizacion de silabos.

## Indicaciones  
### Conexion API 
Para conectarnos a la API y consumir todas la informacion debemos actualizar la direccion URL de la misma, en `Utils: ConsApi`
**Ejemplo**
```dart
  static String path = "http://<IPV4>/zero_api/";
```

### Navegacion
Para navegar a las paginas de Curso y Silabo, es importante pasarle un listado de dos con clave valor. 
**Ejemplo**
```dart
List param = ['clave', 'valor'];
Navigator.pushNamed(context, 'silabo', arguments: param);
```
**Claves que estan adminitas en las paginas**
- Curso
```dart
['periodo', <idPeriodo>]
['nombre', <nombre_curso>+'-'+<idPeriodo>]
['curso', <idCurso>]
['buscar', <query>]
```
- Silabo
```dart
['periodo', <idPeriodo>]
['nombre', <nombre_curso>+'-'+<idPeriodo>]
['curso', <idCurso>]
```
