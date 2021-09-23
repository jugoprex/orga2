---
title: Clase 03꞉ Apps de celulares
tags: [Import-e370]
created: '2021-05-25T04:04:42.969Z'
modified: '2021-05-25T23:29:14.657Z'
---

# Clase 03: Apps de celulares

### Vistazo general de la clase

En este encuentro vimos algunos nuevos conceptos poderosos: los *ciclos* o *repeticiones*, las *alternativas condicionales*, los *eventos*, y los *sensores*. Estas herramientas nos permiten programar autómatas que pueden tener comportamientos que **dependen de su ambiente**.

En otras palabras, aprendimos que podemos hacer programas que puedan detectar eventos externos a través de sensores, y que pueden reaccionar de distintas maneras dependiendo del evento detectado.

Con estas herramientas nos pusimos a pensar en cómo diseñar e implementar algunas aplicaciones de celular y utilizamos la plataforma MIT App Inventor para construir algunas de ellas.

### Alternativas condicionales

A veces, queremos que nuestro autómata actúe de cierta manera cuando se cumple alguna **condición**, y de cierta otra manera cuando no se cumple. Por ejemplo: si queremos programar a un autómata para que nos despierte a las 8:00 de la mañana, queremos que si son las 8:00 A.M. el autómata suene una alarma, y si no son las 8:00 A.M. que no haga nada.

Para esto utilizamos las **alternativas condicionales**. Son una forma de programar a un autómata para que lleve a cabo una de dos *alternativas* dependiendo de si se cumple o no una *condición*. Tienen la siguiente forma:

    Si [condición]
        Entonces [hacer algo]
        Sino [hacer otra cosa]

En el ejemplo anterior, la alternativa condicional tendría la siguiente forma:

    Si son las 8:00 A.M.
        Entonces sonar la alarma
        Sino no hacer nada

### Repeticiones

Vemos, sin embargo, que si ejecutamos las instrucciones de arriba el autómata va a chequear la hora una única vez. Si son las 8:00, va a sonar la alarma, y sino, no va a hacer nada nunca (o hasta que volvamos a ejecutar nuestras instrucciones). Para combatir esto podemos indicarle al autómata que repita cierta secuencia de instrucciones cuantas veces queramos. En este caso, cambiaríamos el programa de la siguiente manera:

    Repetir para siempre:
        Si son las 8:00 A.M.
            Entonces sonar la alarma
            Sino no hacer nada

Para pensar: ¿y si queremos que no se repita para siempre? ¿Podríamos indicar que se repita sólo una cierta cantidad de veces? ¿Y si queremos que sólo se repita dada una cierta condición? Lo veremos más adelante. :)

### Sensores

Los humanos somos capaces de percibir el mundo a nuestro alrededor a través de nuestros sentidos: la vista, el oído, el gusto, etc. Gracias a esta habilidad, podemos llegar a conclusiones sobre lo que percibimos y reaccionar de la manera que consideramos adecuada.

Los **sensores** cumplen para los autómatas un rol parecido al de los sentidos para nosotros. Son componentes de un autómata que le permiten percibir otras cosas. Los celulares, por ejemplo, tienen muchos sensores: la cámara, el micrófono, el sensor de luz ambiental, las antenas de señal, los sensores de proximidad, y muchos otros.

Cuando creamos una aplicación, frecuentemente nos sirve hacer uso de los sensores que tenemos a nuestra disposición. Si nos ponemos a pensar en la primer clase, podemos recordar el ejemplo de la aspiradora robótica. Cuando abarcamos el problema de navegar a la aspiradora alrededor de un rincón, le dimos una secuencia de instrucciones específica para ese rincón en ese cuarto. ¿Qué pasaría si le diésemos las mismas instrucciones pero en otro cuarto? ¿Y si ahora queremos hacer un programa que le permita navegar distintos cuartos? Supongamos que la aspiradora tiene sensores que le permiten saber en qué dirección está apuntando, si hay una pared enfrente suyo, y cuánta distancia hay hasta la pared. ¿Cómo podríamos utilizar estos sensores para mejorar nuestro programa?

### Eventos

Como vimos en clase en el caso del autómata que se tiene que despertar temprano en clase, a veces es conveniente que en vez de constantemente estar chequeando si una condición se cumple o no, nuestro autómata sea capaz de reaccionar a un **evento** que sucede que nos permita deducir que se cumplió la condición.

En el ejemplo de alternativas condicionales anterior, podemos ver que lo que hicimos fue programar un reloj despertador que a las 8:00 A.M. suena una alarma. Esa alarma podemos ver que es un *evento* al cual otros autómatas (y nosotros, je) podemos reaccionar.
