---
attachments: [Clipboard_2021-08-23-21-47-39.png, Clipboard_2021-08-23-21-48-02.png, Clipboard_2021-08-23-23-01-15.png, Clipboard_2021-08-24-01-55-29.png, Clipboard_2021-08-25-14-07-46.png, Clipboard_2021-08-25-14-20-00.png, Clipboard_2021-08-25-20-46-28.png]
tags: [Orga2]
title: Clase T01
created: '2021-08-19T22:14:19.460Z'
modified: '2021-08-27T04:22:31.883Z'
---

# Clase T01

### Arquitectura:

Conjunto de recursos accesibles al programador
+ Registros
+ Set de instrucciones (ISA)
+ Estructuras de memoria

### Microarquitectura:

Implementación electrónica de la arquitectura. Organización + Hardware

### Organización

Detallesde implementación de la ISA.
+ Organización e interconexión de la memoria
+ Diseño de bloques de CPU
+ Implementación de paralelismo
+ Hay procesadores con la misma ISA (arquitectura) pero con organización (implementación) diferente

### Hardware

+ Diseño lógico
+ Tecnología de fabricación

---

## Pipeline
+ Video 2

### Instruction Level Parallelism
+ Cada bloque del procesador que resuelve una etapa (stage) de la máquina de estados para la ejecución de una instrucción  opera en forma simultánea
  + Todos los bloques funcionan en paralelo
+ En cada ciclo de clock, se hacen fetch, decode, operand fetch, ejecución, y return, cada una de una instrucción diferente, en escalerita (idealmente)

#### Obstáculos estructurales:
La memoria en la arquitectura von Neumann comparte datos e instrucciones. Si necesitamos un operando en memoria para una instrucción mientras estamos fetcheando otra instrucción, estamos necesitando hacer dos fetch a memoria al mismo tiempo cuando sólo podemos acceder a una cosa en memoria a la vez.
+ Además, retirar un resultado puede significar escribir a memoria, es decir se puede crear un triple acceso a una misma memoria.
Cada vez que se genera un obstáculo estructural, el pipeline se atrasa en una etapa (se pospone una operación).

#### Obstáculos de control:
Un branch (salto) significa una discontinuidad en el flujo de ejecución: saltos condicionales, incondicionales, llamadas a funciones, etc.
El pipeline busca instrucciones en secuencia, entonces un branch hace que el pipeline deba vaciarse entero y llegar a retirar el resultado del branch antes de continuar la ejecución.

### Proposiciones de RISC:
+ Mayor cantidad de registros, de propósito general
  + Si se tienen los operandos en registro, no se necesita acceder a memoria
+ Instrucciones que se ejecutan en un solo ciclo de clock
  + Las instrucciones que requieren múltiplos ciclos de clock cloggean el pipeline
+ Las instrucciones tienen códigos de operación de igual formato y tamaño
  + El decode es más sencillo y no cloggea el pipeline ni necesita microcódigo
+ Los datos en memoria solo se pueden acceder para leer o escribir
  + Todas las operaciones se ejecutan sobre registros

---

## Arquitectura x86

### Modos de opéración

#### Modo Real
+ Entorno de operación del procesador 8086/8088 original (con algunas extensiones)
  + 1Mb direccionable de memoria
+ Todos los procesadores x86 bootean en este modo y pasan por software a otro modo

#### Modo Protegido
+ Capacidad de multitasking
+ Modo en el que funcionan por excelencia los procesadores x86
+ Espacio de direccionamiento de 4 Gb desde el 80386, extensible

#### Modo Mantenimiento
+ Se ingresa a este modo por 2 caminos:
  + Señal de interrupción #SMM
  + mensaje SMI desde se APIC local
+ Low power mode (sleep)
+ Guarda el contexto completo de la tarea interrumpida, y reasume la tarea cuando sale del modo de mantenimiento

#### Modo Extendido a 64 bits
+ Los procesadores Intel 64 incluyen un modo IA-32e
  + Para pasar a este modo debe estar en modo protegido con paginación habilitada y PAE
+ Tiene 2 sub-modos
 + Sub-modo compatibilidad (32 bits)
 + Sub-modo 64 bits

---

## Modelo de programación de aplicaciones

### Arquitectura básica de 16 bits
![](@attachment/Clipboard_2021-08-23-21-48-02.png)

#### Registros
Nota: H y L son High (más significativa) y Low (menos significativa)
Registros de 16 bits de propósito general con funciones individuales
Los registros de propósito general son:
+ AX (AH/AL): Acomulador general
+ BX (BH/BL): puntero Base/a memoria
+ CX (CH/CL): registro Contador
+ DX (DH/DL): registro de Datos
+ SI (Source), DI (Destination): punteros a memoria (funcionan como índices)
+ BP: Base Pointer
+ SP: Stack Pointer
+ Registros de Segmentos (punteros a):
  + CS (Code)
  + SS (Stack)
  + DS (Data)
  + ES (Extra data)
+ IP: Instruction Pointer
+ Flags: contexto de estado

#### Espacio de direccionamiento
+ 1Mb
  + 2^20 - 1 direcciones de memoria

### Arquitectura IA-32
![](@attachment/Clipboard_2021-08-23-23-01-15.png)
#### Registros
Extiende los mismos registros que la 8086 a 32 bits; la parte baja de los registros (i.e. los 16 bits menos significativos) se corresponden 1 a 1 con los registros del 8086.
Se agregan los registros de segmentos FS y GS para datos.

#### Espacio de direccionamiento
+ 2^32 - 1 direcciones
+ I/O se mapea separadamente en 64kb
  + Si se direcciona a un espacio en memoria entre 0 y 64kb se tiene que aclarar si es memoria o I/O

#### Floating Point Unit (FPU)
+ Esencialmente una ALU que trabaja con puntos flotantes
+ Registros:
 + R0 a R7
 + Registros de control
+ Registros de hasta 80 bits (extended double precision floating point)

#### MMX (MultiMedia eXtension) y XMM
+ Digital Signal Processing (procesamiento de video y audio)
+ Registros MMX de 64 bits MM0 a MM7
  + Data-level parallelism
  + Son las partes bajas de los registros de la FPU
+ Luego se agregan registros XMM0 a XMM7 de 124 bits
  + Independiente de la FPU

### Arquitectura Intel 64/AMD 64
![](@attachment/Clipboard_2021-08-24-01-55-29.png)
#### Registros
Se extienden los registros a 64 bits. La parte baja de los registros es idéntica a IA-32, y se agregan 8 más registros de propósito general.
Los registros de segmentos son idénticos.

#### Otros cambios
+ Espacio de direccionamiento: 2^64 - 1 direcciones
+ Se agregan 8 registros XMM
+ Se hacen accesibles las partes menos significativas de todos los registros, a nivel byte (L), word (W), y doubleword (D), incluyendo los registros que no tenían antes esta feature

---

## Modos de direccionamiento
Los tipos de direccionamiento de operandos de las arquitecturas x86.

### Modo Implícito
Operaciones cuya instrucción tiene un operando implícito, i.e. no es necesario explicitar un operando. e.g.:
+ `CLC`: Clear Carry (operando es el Flag CF implícitamente)
+ Otras instrucciones con flags de operando implícito.
+ `HLT`, `NOP`
+ Instrucciones que operan sobre registros específicos

### Modo Inmediato
El operando fuente es un valor literal dentro del código de la instrucción, y no se tiene que buscar un valor a memoria o registro luego de la decodificación. e.g.:
+ `add al, '9'`; Agrega 9 a AL

### Modo Registro
El operando es un registro. e.g.:
+ `mov eax,ebp`

### Modos de Direccionamiento a Memoria
La memoria para x86 es una secuencia de bytes, direccionables por el Address Bus. La memoria conectada al Address Bus se llama **memoria física**, y el espacio de direcciones se llama **direcciones físicas**.

#### Segmentación
##### Segmentación vs Paginación
Intel eligió la segmentación, posiblemente por razones de falta de memoria.
+ Los segmentos:
  + Tienen tamaño variable
  + Pueden solaparse con otros segmentos
  + Tienen direcciones arbitrarias
  + Requieren más control pero pueden ser más eficientes en memoria
+ Las páginas:
  + Tienen tamaño fijo
  + Son contiguas
  + No se solapan
  + Requieren menos control pero pueden ser más ineficientes en memoria

##### Estructura de segmentos
+ x86 tiene registros de segmento que guardan selectores de segmento.
 + Los selectores de segmento especifican un segmento en memoria.
 + El segmento se expresa con una dirección de memoria (dónde arranca el segmento) y un offset (hasta dónde llega)

##### Direccionamiento por segmentos
Para identificar un operando en memoria, se utiliza una **dirección lógica**.
La dirección lógica se obtiene con un registro de segmento y un offset. Se llama dirección lógica porque debe ser procesado para convertirlo en una dirección física.
Sin embargo:
+ No siempre es necesario explicitar un segmento. En algunas instrucciones, el segmento queda de manera implícita:
![](@attachment/Clipboard_2021-08-25-14-07-46.png)

El desplazamiento depende de varios factores. Puede calcularse a partir de cualquier combinación de los siguientes:
+ Desplazamiento directo: explícitamente incluído en la instrucción (8, 16, o 32 bits)
+ Base: dirección contenida en un regitro de propósito general, a partir de la cual se calcula el desplazamiento (32 bits en IA-32 o 64 en IA-32e)
  + Se puede indicar por cualquier GPR
  + Cuando se emplean de base ESP o EBP se asocian al segmento de Stack. En otros casos se asocian al segmento de Data.
+ Índice: dirección contenida en un registro de propósito general, típicamente que se incrementa para recorrer por ejemplo un buffer de memoria (ídem base)
  + Se puede indicar por cualquier GPR menos el ESP
+ Escala: es un valor por el cual se multiplica el valor del índice (2, 4, u 8)
  + Sólo opera sobre el índice
Pueden ser positivos o negativos en complemento a 2 (excepto el factor de escala).
De estos cuatro componentes se obtiene la **dirección efectiva**, que es la dirección que ocupa el elemento direccionado respecto al inicio de un segmento.
En general la expresión del cálculo interno del procesador es:
$$DireccionEfectiva = Base + (Indice * escala) + Desplazamiento$$
![](@attachment/Clipboard_2021-08-25-14-20-00.png)

#### Modos

##### Modo Desplazamiento
Se incluye en el código de la instrucción el tamaño del dato a leer en la dirección de memoria apuntada y el desplazamiento/offset. e.g.:
`or ecx, dword [0x300040A0]`
Significa que se hace OR entre ECX y la doubleword contenida desde la dirección de memoria 0x300040A0.

##### Modo Base Directo
El offset está directamente contenido en un registro "base". e.g.:
~~~
mov edx, i              ; pongo en edx la dirección de i
inc [edx]               ; incremento el dato en la dirección contenida por edx
~~~

##### Modo Base + Desplazamiento
Combina un registro base con un desplazamiento. e.g.:
~~~
mov ebx, K_data         ; ebx apunta a la base de K_data, una secuencia de datos
mov al, byte [ebx + 5]  ; apunto a ebx con un desplazamiento de 5, o sea al sexto elemento de K_data
~~~

##### Modo Índice * Escala + Desplazamiento
Forma eficiente de acceder a elementos de un array con elementos de tamaño 2, 4, u 8 bytes.
El desplazamiento base apunta al inicio del array y el valor índice se guarda en un registro que incrementa para pasar al próximo elemento.
~~~
%define Dir_Table 0x2000F000  ; principio de una tabla con elementos de 4 bytes
%define mask 0xFFFFFFFE
mov ecx,size_tabla            ; donde size_tabla es la cantidad de elementos en la tabla
xor esi,esi                   ; setteo esi en 0
mas:
and [esi*4 + Dir_Tabla], mask ; apunto al elemento de 4 bytes número esi de la tabla
inc esi                       ; incremento el índice 
loop mas                      ; si ecx no es 0, loop
~~~

##### Modo Base + Índice + Desplazamiento
Es una falopeada. e.g.:
`mov byte [ebx + edi + 0x000B8000], 0x00`
donde ebx es la base, edi es el índide, y 0x000B8000 es el desplazamiento.

##### Modo Base + Índice*Escala + Desplazamiento
Ídem.
`mov byte [ebx + edi*2 + 0x000B8000], 0x00`

---

## Endianness (Little-Endian)
Los procesadores x86 son **little endian**.
+ Los datos de múltiples bytes almacenan su byte menos significativo secuencialmente primero, y luego en órden de significatividad. Es decir, el último byte secuencialmente es el byte más significativo.
  + La dirección con la que se referencia una variable almacena su byte menos significativo.
![](@attachment/Clipboard_2021-08-25-20-46-28.png)
+ Intel adoptó little-endianness porque la memoria se maneja de a bytes.

## Alineación de memoria
Una variable está alineada en memoria si su dirección es un múltiplo de su tamaño.
Los procesadores x86 no tienen restricciones sobre la alineación de variables.
  + Da flexibilidad con el aprovechamiento de memoria
  + Puede tener impacto en performance, por ejemplo si un dato queda en 2 filas diferentes y se requieren dos ciclos de lectura para leerla.
  + Ésto se puede evitar usando las directivas de alineación de los lenguajes de programación.
  `align 16`

---

## Stack
El stack es un segmento de direcciones contiguas en memoria.
+ Se apunta siempre por el SS
+ Comienza en las direcciones más altas de memorias y crece hacia las direcciones más bajas (se apila)
  + "Crece" hacia "abajo" (expand down según Intel)

Se recorre con el GRP SP (o ESP, RSP)
+ El Stack Pointer se manipula con las intrucciones PUSH Y POP
  + **PUSH** decrementa el stack pointer y luego escribe el dato en el stack
  + **POP** Lee el ítem apuntado por el par SS: stack pointer, y luego incrementa el stack pointer

El stack se suele usar cuando:
+ se hace un CALL a una subrutina/función
+ se envía una interrupción al procesador desde hardware
+ se ejecuta una interrupción desde una aplicación (software) a través de la instrucción INT
+ se invoca una función en un lenguaje de nivel alto

El stack pointer debe apuntar a direcciones de memoria alineadas al tamaño del stack pointer. El tamaño de cada elemento en el stack se corresponde con el modo de trabajo en el que está el procesador. (16, 32, o 64 bits)
+ El stack debe estar alineado a una dirección múltiplo de 4. El stack pointer se incrementa y decrementa en 2, 4 u 8 bytes correspondientes al modo de trabajo.

### Llamadas Near y Far
Una subrutina **Near** está en el mismo segmento de memoria que el llamado.
Una subrutina **Far** está en otro segmento de memoria.

Cuando se realiza un `CALL` Near el procesador:
`call subroutine`
+ Pushea el instruction pointer al stack, i.e. decrementa el stack pointer y guarda el valor del instruction pointer (que apunta a la instrucción siguiente a CALL)
+ Escribe la dirección de la subrutina llamada en el instruction pointer
+ Continúa ejecución desde la nueva dirección
Cuando se realiza un `RET`
+ Poppea la dirección de retorno del stack, i.e. escribe la dirección de retorno en el instruction pointer e incrementa el stack pointer

Cuando se realiza un `CALL` Far, el procesador:
+ Además pushea el CS al stack primero, porque necesita acordarse el segmento de memoria a donde retornar, ya que la dirección está expresada en relación al segmento.
`call code2:subroutine`
donde code2 es otra sección de código.
+ Al retornar, se poppea el code segment y luego el instruction pointer. Como se tienen que recuperar 2 datos, la operación de retorno Far es diferente de la operación de retorno Near.
`retf`

### Interrupción
Cuando ocurre una interrupción, el procesador:
+ Pushea primero los flags (EFLAGS/RFLAGS), luego el CS y luego el instruction pointer.
+ Al retornar, usa `iret` que recupera los flags además del resto.
