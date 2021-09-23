---
attachments: [Clipboard_2021-09-18-02-02-17.png]
tags: [Orga2]
title: Clase T02
created: '2021-08-28T00:03:44.778Z'
modified: '2021-09-22T04:23:57.767Z'
---

# Clase T02

## Devtools

**Nota:** #include es una directiva que indica al preprocessor que se incluya en donde está la directiva los contenidos del archivo apuntado.

![](@attachment/Clipboard_2021-09-18-02-02-17.png)

### Preprocessor

+ Elimina comentarios
+ Reemplaza directivas (#include) por el contenido del archivo referenciado
+ Reemplaza macros por sus definiciones (#define)

### Compilador
+ Valida la sintáxis de un código fuente
+ Si es correcta, genera un código binario (*archivo objeto* `.o`) respetando la semántica del lenguaje compilado targeteado a alguna arquitectura
  + Un programa objeto no es un ejecutable
+ No puede resolver referencias a funciones externas al archivo fuente compilado
  + Apuntan a "direcciones ficticias" para que resuelva el linker

### Linker
+ Toma el archivo objeto generado por el compilador y lo linkea con otros archivos objeto y bibliotecas de código
  + Pone todos los bloques de código juntos y los ordena en secciones comunes
  + Resuelva cada referencia a variables o funciones externas
  + Identifica y marca el punto de entrada del programa (`main()`)
+ Genera un programa ejecutable por el Sistema Operativo
+ Appendea todos los bloques de código en diferentes archivos que estén en la misma sección en el ejecutable final.

## Assembler

### ELF

Linux utiliza el formato de ejecutables ELF (Executable Linkable Format) que define el formato de encabezado para los archivos objeto (linkeables) y para los programas ejecutables. Una de las cosas que define son las secciones de código:
    .data contiene datos y variables estáticas
    .text contiene las instrucciones del programa

### Fields (campos/columnas)
En el lenguaje de ensamblado, las columnas tienen semántica distinta:
+ La primer columna son etiquetas, i.e. nombres para posiciones en memoria. Es opcional.
  + Por ejemplo, la etiqueta _start: donde empieza el código, o posiciones de valores constantes.
+ La segunda columna son mnemónicos, i.e. nombres abreviados de las instrucciones. Por ejemplos, mov, syscall, str, etc.
+ La tercer y cuarta columna son operandos, por ejemplo registros o posiciones de memoria.
+ La columna “cero” son directivas de ensamblador, como section y global, que indican al ensamblador realizar ciertas acciones antes de ensamblar.
  + section .[section] indica comienzo de secciones
  + global indica símbolos globales

Notas:
+ Las funciones pasan los parámetros por los registros en órden RDI, RSI, RDX, RCX, R8, R9, R10, R11 para enteros, XMM0… para punto flotante.

+ **syscall** llama al handler de system calls del kernel del sistema operativo. La función se indica con el valor de rax/eax. El resto de los parámetros dependen de la función particular; en sys_write(), que es la función 1, el file descriptor va en rdi. Entonces, por ejemplo, para imprimir por pantalla se escribe al file descriptor 1, stdout. Se imprime el string apuntado por rsi de tamaño apuntado por rdx.
  + Antes se usaba int 0x80 (int llama al interrupt handler del kernel, 0x80 indica el tipo de interrupción), que tiene numeración de funciones distinta. Por ejemplo, write es 4.

+ `db` define byte, `dw` define word, `dd` define doubleword, `dq` define quadword, escriben un valor directamente en la posición actual de memoria, i.e. la posición en IP. Se hace en la sección .data del programa.

+ nasm (y otros ensambladores) tienen una variable interna $ que se settea en 0 cuando se indica una section e incrementa como contador de programa.

##### usage de nasm:
`nasm -f elf64 -F DWARF -o file.o file.asm`
+ -f indica el formato de ejecutable
+ -F indica el formato de la tabla de símbolos y otros (DWARF recomendado por profe)
+ -o[filename].o nombre del archivo objeto producido
+ [filename].asm nombre del target
##### linker:
`ld -o filename.o executablename -g`

+ REP es un prefijo que repite una instrucción hasta que RCX sea 0.
