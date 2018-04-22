##[Escaneo de seguridad y vulnerabilidades de images de contenedores con OpenShift.](https://github.com/javilinux/conferences/2018/supersec/escaneo)

En esta presentación hablaremos sobre estrategias para escaneo de seguridad y vulnerabilidades de imagenes de contenedores. 
¿Que es lo que hay exactemente dentro de un contenedor? ¿Quién debería ser responsable de su seguridad? ¿Como se asemeja a lo que hacemos con los servidores?
Los equipos de seguridad con frequencia no entienden de contenedores o ni siquiera saebn que preguntas hacer. Por desgracia no hay muchas herramientas que nos puedan ayudar, en el sentido amplio. La tecnología de contenedores es nueva y evoluciona a mucha velocidad. Eso junto con el hecho de que la seguridad puede impactar negativamente la productividad de un equipo DevOps, explica porque nos encontramos en el punto de partida en muchas ocasiones.

Hay importantes aspectos de seguridad de los contenedores:
Los contenedores pueden tener varios formatos de empaquetado: Docker es la más popular hoy en dia.
Los contenedores son inmutables y como tal estan basados en imagenes.
Las imagenes de contenedores estan basadas en capas (base, runtime. aplicación)
Las imagenes de contenedores requieren responsabilidad compartida entre los equipos de desarollo y los de operaciones.
Los contenedores no tienen contenido, son en realidad, solo procesos.

Red Hat ofrece varias soluciones para entornos de OpenShift:

1. El catalago de contenedores clasifica la imagenes de Red Hat y provee un historial de la imagen y los parches de seguridad que han sido aplicados.
2. Atomic CLI escanean las imagenes y usa OpenSCAP que determina las vulnerabilidades de seguridad.
3. Cloudforms escanea las imagenes usando OpenSCAP (como Atomic) y también añade capacidades como realizar acciones cuando una imagen es vulnerable, escanear automaticamente nuevas imagenes o incluso hacer informes.


##[Aplicación de parches de seguridad sin perdida de servicio en OpenShift](https://github.com/javilinux/conferences/2018/supersec/downtime)

Uno de los tipicos motivos para el retraso de actualizaciones de seguridad, es la posible perdida de servicio. Incluso cuando se usan contenedores.

En esta charla veremos las distintas estrategias de despliegue que podemos utilizar en OpenShift:
• Recreate
• Rolling
• Custom

También veremos como ajustar los distintos chequeos para que consigamos una estrategia de despliegue que nos permita cambios de versiones en producción que haya pérdida de servicio.
