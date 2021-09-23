---
attachments: [Clipboard_2021-09-22-01-32-58.png, Clipboard_2021-09-22-01-33-53.png, Clipboard_2021-09-22-01-55-58.png, Clipboard_2021-09-22-02-17-15.png]
tags: [Orga2]
title: Clase T03
created: '2021-09-22T04:23:13.496Z'
modified: '2021-09-22T05:17:26.415Z'
---

# Clase T03

## Bare Metal Programming

### Built In Self Test

Es un test interno que se ejecuta automáticamente cuando se arranca el procesador o se settea el pin #RESET
+ Si el test pasa, `eax` se inicializa en 0x0
+ Los registros toman valores bien determinados
+ Los caches se invalidan
+ Las TLB se invalidan
+ Se limpian los Branch Target Buffers (buffers de saltos)

Hay una señal #INIT que tiene comportamiento parecido pero no reinicia los valores en los registros de la FPU, MSR, y MTRRs.

#### Valores inicializados
##### CR0
![](@attachment/Clipboard_2021-09-22-01-32-58.png)

##### Registros corrientes
![](@attachment/Clipboard_2021-09-22-01-33-53.png)

### Secuencia de boot
El primer OPCODE FETCH se realiza en la dirección física 0xFFFF0 (fondo del 1Mb) en modo real.
 + 0xFFFF0 debería estar mappeado a ROM
  + Esto es incómodo: ocupar un ROM en el medio de direcciones mappeadas a RAM

El modo real tiene acceso a recursos de modo protegido indirectamente:
Hay registros cache "ocultos" para la global descriptor table en modo protegido. Los procesadores cuando están en modo real hacen uso de estos registros ocultos y les asigna valores convenientes.
![](@attachment/Clipboard_2021-09-22-01-55-58.png)

Como el IP arranca en 0xFFF0, el EIP arranca en 0xFFFFFFF0 (CS+IP), al fondo de los 4Gb mappeables en modo protegido.
  + En la práctica, la ROM se mappea ahí
    + El procesador "piensa" que está mappeado en 0xFFFF0, el decodificador de memoria lo ubica en la dirección física verdadera
  + Para direccionar a un valor por encima del 1Mb mappeable en modo real, el CS no puede cambiar mientras el procesador trabaja en modo real.

#### Código imagen de la ROM
```
ORG 0xFF000 ; indica al ensamblador que el origen es en la dirección 0xFF000
USE16       ; indica al ensamblador que se use 16 bits
TIMES 4080 db 0x90 ; escribimos 0x90 (NOP) directamente en las primeras 4080 direcciones para que init16 quede en 0xFFFF0
init16:
  cli
  jmp init16
align 16 ; rellena con NOPs hasta la próxima dirección múltiplo de 16
```

Esto no es escalable porque asume que la ROM arranca en 0xFF000. Entonces se usa esto:

![](@attachment/Clipboard_2021-09-22-02-17-15.png)
