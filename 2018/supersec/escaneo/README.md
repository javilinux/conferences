### [Escaneo de seguridad y vulnerabilidades de images de contenedores con OpenShift.](https://github.com/javilinux/conferences/tree/master/2018/supersec/escaneo)

*Javier Ramirez Molina*

*OpenShift Support at Red Hat*

---

### Disclaimer

*Opiniones propias*
*Versiones upstream y cuenta de developer*

---

#### Introducción
#### Catalago de Contenedores
#### Atomic CLI + OpenSCAP
#### Cloudforms + OpenSCAP + OpenShift

---

###### ¿Que es lo que hay exactemente dentro de un contenedor? 

* Formatos de empaquetado: Docker es la más popular pera hay otras, cćomo CRI-O o rkt.
* Son inmutables y como tal estan basados en imagenes.
* Las imagenes de contenedores estan basadas en capas (base, runtime. aplicación)

---

###### ¿Quién debería ser responsable de su seguridad? 

* Requieren responsabilidad compartida entre los equipos de desarollo y los de operaciones.
* Los contenedores no tienen contenido, son en realidad, solo procesos.

---
###### ¿Como se asemeja a lo que hacemos con los servidores?

* Técnología muy reciente.
* Falta de herramientas.
* Mucha velocidad de evolución. 
* Los equipos de seguridad con frequencia no entienden de contenedores.
* Los equipos de desarrollo/operaciones no entienden de seguridad.
* La seguridad puede impactar la productividad.
---
###### Catálogo de Contenedores 
- Red Hat ofrece un catálogo de todas las imagenes que proporciona.
- Son frecuentemente escaneadas y actualizadas.
- Historial de cada imagen y un tag por cada versión.
- Las imagenes son calificadas de la A a la F.

---
#### Introducion a las erratas

- Una errata es un conjunto de parches liberados al mismo tiempo.
- Hay erratas de varios tipos:
   - RHBA: Bug (Solución de problemas) 
   - RHEA: Enhancements (Mejoras de productos)
   - RHSA: Security advisories (Seguridad)

---
#### Clasificación de las erratas de seguridad
|Clasificación|Descripcion|
|-------------|-------------|
|Critica|Facilmente explotables de manera remota, sin autenticación y que pueden comprometer el sistemamediante la ejecución de código arbritario|
|Importante|Permiten a usuarios locales que obtengan privilegios de administrador, permiten a usuarios remotos no autenticados ver recursos, permiten usuarios remotos autenticados ejecutar código arbitrario o una denegación de servicio.|

---
#### Clasificación de las erratas de seguridad
|Clasificación|Descripcion|
|-------------|-------------|
|Moderada| Dificilmente explotables pero que en determinadas circunstancias pueden comprometer el sistema.|
|Baja|Resto de erratas de seguridad.|

---
##### Calificación de la seguridad de las imagenes
| Calificación | Condiciones de seguridad                                        |
|--------------|--------------------------|
|A             | No tiene erratas de seguridad Criticas o Importantes sin aplicar|
|B             | Afectada por una errata de seguridad Critica (7 dias) o Importante (30 dias)|
|C             | Afectada por una errata de seguridad Critica (30 dias) o Importante (90 dias)|

---
##### Calificación de la seguridad de las imagenes
| Calificación | Condiciones de seguridad                                        |
|--------------|--------------------------|
|D             | Afectada por una errata de seguridad Critica (90 dias) o Importante (1 año)|
|E             | Afectada por una errata de seguridad Critica o Importante (1 año)|
|F             | Afectada por una errata de seguridad Critica o Importante (más de 1 año)|
|UNKNOWN       | Sin datos suficientes|

---
###### More Information
[Ten layers of containers security](https://www.redhat.com/cms/managed-files/cl-container-security-openshift-cloud-devops-tech-detail-f7530kc-201705-en.pdf)


