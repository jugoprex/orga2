---
attachments: [Clipboard_2021-10-05-17-28-58.png, Clipboard_2021-10-05-18-10-33.png]
tags: [Orga2]
title: Clase P06
created: '2021-10-05T20:01:31.969Z'
modified: '2021-10-05T22:48:12.142Z'
---

# Clase P06

## Paginación

La unidad de paginación traduce una dirección virtual a una dirección física. El proceso es transparente para los procesos.

Se hace esto para que distintos procesos se puedan ejecutar sobre su propio espacio virtual como si fuera memoria física.

### Unidad de paginación
Los dos elementos necesarios para traducir la dirección son:
+ La dirección virtual, que conoce el proceso
+ La estructura de paginación del proceso (directorio y tablas de páginas) que indican qué direcciones virtuales se corresponden a qué direcciones físicas

La ubicación del directorio de páginas se encuentra en `CR3`, en los 20 bits altos

#### Traducción de direcciones virtuales
La dirección virtual se divide en 3 partes:
+ Los 10 upper bits indican en qué entrada del directorio se busca la tabla de páginas necesaria
+ Los 10 bits medios indican en qué entrada de la tabla se encuentra la dirección base de la página necesaria
+ Los 12 bits mas bajos indican el desplazamiento desde la base de la página donde se encuentra el dato

![](@attachment/Clipboard_2021-10-05-17-28-58.png)

### CR3

+ Los 20 bits más altos del CR3 contienen la dirección de la página donde se encuentra el directorio de tablas de páginas
  + Dirección del directorio: `CR3 & ~0xFFF`, i.e. los 20 bits altos de CR3
+ Los 12 bits más bajos son atributos

### Directorio de tablas de páginas (PD - Page Directory)
+ Tiene 1024 entradas
+ Cada entrada (PDE - Page Directory Entry) es de 4 bytes
+ Ocupa 4KB (una página)
+ Los 20 bits altos de la i-ésima entrada corresponden a la dirección de la i-ésima tabla de páginas
Dirección de la tabla i = `pd[i] & ~0xFFF`

### Tabla de páginas (PT - Page Table)

+ Tiene 1024 entradas de 4 bytes, ocupando 4KB (una página)
+ Los 20 bits altos de la entrada i corresponden a la dirección de la página i
Dirección de la página i = `pt[i] & 0xFFF`

![](@attachment/Clipboard_2021-10-05-18-10-33.png)

### Translation Lookaside Buffer (TLB)
El procesador cuenta con una tabla de traducciones pre-computadas, que almacena las últimas traducciones realizadas.
Si se hacen cambios en la estructura de paginación se debe limpiar la TLB.

### Atributos de la PTE

En paginación solo hay 2 niveles de privilegio: kernel (0) y usuario (1)
+ D (Dirty): se settea por la unidad de memoria cuando se escribe en la página, se limpia por software
+ A (Accessed): se settea por la memoria cuando se escribe o lee la página, se limpia por software
+ PCD (Page Cache Disabled): la página no se almacena en memoria rápida
+ PWT (Page Write Through): la escritura hace en cache y memoria a la vez, sino solo se escribe a memoria cuando se desaloja la línea de cache
+ U/S (User/Supervisor): nivel de privilegio
+ R/W (Read/Write): R&W (1) o sólo Write (0)
+ P (Present): se encuentra la página cargada en memoria
