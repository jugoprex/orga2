---
title: 'API: Application Programming Interface (interfaz de programación de aplicaciones)'
created: '2021-07-23T00:45:36.800Z'
modified: '2021-07-23T03:23:11.133Z'
---

# API: Application Programming Interface (interfaz de programación de aplicaciones)

Nosotros queremos programar un bot de Discord. Es decir, vamos a escribir código que cuando se ejecute va a interactuar con Discord de alguna manera. Nosotros, como humanos, solemos interactuar con Discord a través de su interfaz gráfica. Es decir, con un monitor, el mouse, y el teclado; clickeando íconos y escribiendo en cajas de texto. Pero necesitamos conseguir que de alguna manera nuestro código pueda leer y mandar mensajes, o cualquier otra cosa que necesitamos que haga.

Para esto, podríamos programar movimientos de mouse y eventos del teclado simulados y hacer que nuestro bot se comunique con Discord a través de la interfaz gráfica igual que nosotros, pero se imaginan que esto no es genial. En cambio, nosotros vamos a usar la API de Discord, que es lo que nos permite hacer que nuestro código interactúe con Discord de manera directa a través de llamadas a funciones (es decir, usando funcionalidades de la API), en vez de a través de la interfaz gráfica.

Una API es la interfaz a través de la cuál un programador puede interactuar con un servicio (o aplicación). Una interfaz define qué cosas se pueden hacer con una aplicación a través de código, incluyendo qué información se le tiene que proveer para que se realice exitósamente cada acción y qué se espera que sea el resultado de esa acción (es decir, qué va a "devolver"), pero sin incluir cómo se implementan específicamente las funcionalidades de esa API.

Ésto nos sirve para construir programas que puedan interactuar con una apĺicación sin utilizar la interfaz gráfica como haría un usuario normalmente. Por ejemplo, podemos usar la API de Discord para llamar una función que mande un mensaje en un servidor, en vez de gráficamente clickear el canal con el mouse, clickear la caja de texto, escribir el mensaje, y clickear "Send."

Se puede pensar como que la interfaz gráfica es la manera en que se comunica un humano con una aplicación, y una API es la manera en que se comunica una computadora con una aplicación. En el fondo, en realidad la interfaz gráfica también se comunica con la aplicación a través de su API, pero la capa gráfica esconde ese paso del usuario.

Un ejemplo (malísimo pero necesito ideas): imaginemos una biblioteca de código para un local que vende panchos. La API del local de panchos probablemente va a tener una función para comprar un pancho, y la definición de la interfaz probablemente te pida que le pases qué ingredientes querés meterle a tu pancho y la información de tu tarjeta de crédito, y probablemente te diga que cuando llamás a esa función te va a devolver un pancho o algún tipo de error (por ejemplo, que no le puede meter 5 salchichas a un pancho o que no se le pudo cobrar a la tarjeta). Todo esto se haría a través de una llamada a la API del local en código. En cambio, si no se hace a través de la API uno tendría que entrar al local, hacer la cola, hablar con un empleado, decir qué ingredientes quiere en su pancho, y darle la tarjeta físicamente. literalmente que carajo acabo de escribir

Volviendo a Discord, eso nos sirve a nosotros para escribir un programa que pueda interactuar con Discord, leer mensajes, mandar texto o imágenes, agregar roles, etc. Cualquier cosa que se pueda hacer a través de la API podemos usar en un programa, que le podemos agregar cualquier lógica que querramos nosotros. Por ejemplo, podemos hacer que nuestro programa lea a través de la API cada mensaje que entra en un canal, y que si el mensaje contiene alguna palabra particular, que mande un mensaje a través de la API que diga algo relevante.

Cómo funciona esto más concretamente?

[aca va el ejemplo de la api de telegram y como se comunica]

se entiende?




