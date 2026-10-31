**README ·**

¿De qué trata el proyecto?

RetailPro modela las ventas de una tienda de tecnología durante marzo de
2024: 5 clientes de distintas ciudades de Argentina, 6 productos en 4
categorías y 10 operaciones de venta. El objetivo es practicar el
recorrido completo de un análisis de datos mediante el diseño de una
base relacional, consultas SQL y la comunicación de resultados de
negocio.

* Diseñar y cargar una base de datos relacional.
* Consultar indicadores clave: facturación, ticket promedio, ranking de
productos y clientes recurrentes.
* Cruzar tablas con JOIN para detectar clientes o productos sin
movimiento y comparar canales de venta.
* Comunicar los resultados en lenguaje de negocio.

Los datos son ficticios y de volumen reducido: están pensados para
aprender y practicar, no para representar una operación real.



Estructura del proyecto

|**Archivo**|**Qué contiene**|
|-|-|
|**ventas\_tech\_db.sql**|Crea la base Ventas\_Tech\_DB, sus 4 tablas y carga los datos de ejemplo. Se ejecuta primero.|
|**m4\_consultas\_negocio.sql**|Consultas de negocio: resumen mensual, ranking de productos, clientes recurrentes y comparación contra el promedio.|
|**m5\_consultas\_joins.sql**|Consultas con INNER JOIN, LEFT JOIN y UNION ALL: vista base, clientes sin ventas, productos sin ventas y consolidado por canal.|
|**Pipeline\_ETL\_Requelme\_Belén.pbix**|Archivo de Power BI Desktop con el pipeline de carga y transformación (ETL).|
|**Requelme\_Belen\_Checkpoint2.pbix**|Archivo de Power BI Desktop correspondiente al segundo checkpoint del proyecto.|

# 

Modelo de datos

La base Ventas\_Tech\_DB tiene cuatro tablas relacionadas entre sí:

**categorias (1) → productos (1) → ventas ← (1) clientes**

|**Tabla**|**Descripción**|**Campos principales**|
|-|-|-|
|**categorias**|Rubros de producto.|id\_categoria (PK), nombre\_categoria, descripcion|
|**clientes**|Clientes registrados con ciudad y fecha de alta.|id\_cliente (PK), nombre, email, ciudad, fecha\_registro|
|**productos**|Catálogo con precio, stock y estado.|id\_producto (PK), nombre\_producto, id\_categoria (FK), precio, stock, activo|
|**ventas**|Cada operación: quién compró, qué, cuánto y a qué precio.|id\_venta (PK), id\_cliente (FK), id\_producto (FK), cantidad, precio\_unitario, fecha\_venta|

El total de cada venta se calcula como cantidad × precio\_unitario.



Cómo ejecutar el proyecto

El orden de ejecución se reorganizó para que el proyecto pueda
reproducirse de forma clara y sin confundir la carga de datos con el
análisis.

**1. Crear y cargar la base**: Ejecutar ventas\_tech\_db.sql. Crea
Ventas\_Tech\_DB, genera las tablas categorias, clientes, productos y
ventas, e inserta los datos de ejemplo.

**2. Ejecutar las consultas de negocio**: Abrir m4\_consultas\_negocio.sql
con Ventas\_Tech\_DB seleccionada y ejecutar las consultas de indicadores.

**3. Ejecutar las consultas con JOIN**: Abrir m5\_consultas\_joins.sql y
ejecutar los cruces entre tablas.



Consultas incluidas y preguntas de negocio



m4\_consultas\_negocio.sql

|**#**|**Consulta**|**Pregunta de negocio**|
|-|-|-|
|1|Resumen ejecutivo mensual|¿Cuánto se facturó, cuántos pedidos hubo y cuál fue el ticket promedio por mes?|
|2|Top 5 de productos por facturación|¿Qué productos generan más ingresos?|
|3|Clientes recurrentes|¿Qué clientes compraron más de una vez y cuánto gastaron?|
|4|Meses por encima o por debajo del promedio|¿Cada mes está arriba o abajo del promedio de facturación?|

## 

m5\_consultas\_joins.sql

|**#**|**Consulta**|**Pregunta de negocio**|
|-|-|-|
|1|Vista base del proyecto|¿Cómo se integran las ventas con cliente, producto y categoría?|
|2|Clientes sin ventas|¿Hay clientes registrados que nunca compraron?|
|3|Productos sin ventas|¿Hay productos sin rotación?|
|4|Consolidado por canal|¿Cuánto se factura por canal Online vs. Presencial?|

# 

SUPUESTOS Y LIMITACIONES

* El canal de venta no es un dato de la base. En la consulta 4 de
m5\_consultas\_joins.sql se asume que los productos 1, 2 y 3 se venden
online y los productos 4, 5 y 6 de forma presencial.
* Todas las ventas corresponden a marzo de 2024, por lo que la
comparación contra el promedio mensual tiene una variación temporal
limitada.
* Los scripts utilizan sintaxis específica de SQL Server, como TOP, BIT
y USE.
* Los importes se expresan en la unidad monetaria de los datos de
ejemplo, sin conversión.

# 

Autora

Belén Requelme  
Proyecto de práctica en análisis de datos.

