### [Aplicación de parches de seguridad sin perdida de servicio en OpenShift](https://github.com/javilinux/conferences/tree/master/2018/supersec/downtime)

*Javier Ramirez Molina*

*OpenShift Support at Red Hat*

*SuperSec 2018 Almería*

---

### Disclaimer

*Opiniones propias*

*Versiones upstream y cuenta de developer*

---

#### Introducción
 
Estrategias de despliegue en OpenShift:
* Basadas en configuración:
   * Recreate
   * Rolling
   * Custom
* Basadas en rutas:
   * Blue-Green
   * A/B

---

#### ¿Que es OpenShift?

- Plataforma como servicio.
- Docker (CRI-O), Kubernetes, Etcd, haproxy...
- Origin es la version upstream.

--- 

#### Entorno demo

- Nos bajamos el cliente de OpenShift.
```
oc cluster up
```
- O con Minishift:

```
minishift start
```

---

#### Estrategia Recreate

- Remueve las instancias antiguas y crea nuevas.
- Soporta hooks.

---

#### Flujo de la estrategia recreate

1. Ejecuta el pre-hook.
2. Escala a 0 la versión antigua.
3. Ejeucta el mid-hook.
4. Escala la nueva versión.
5. Ejecuta el post-hook.

---

#### Demo recreate

```
oc new-project recreatedemo
oc create -f recreatedemo.yaml
oc tag deployment-example:v2 deployment-example:latest && oc logs -f dc/deployment-example
```
---
#### Conclusion recreate

##### No evita la perdida de servicio.

---
#### Rolling

- Poco a poco va reemplazando instancias con la version antigua con instancias de la nueva version.
- Se hacen comprobaciones de las nuevas instancias antes de echar abajo las viejas.

---
#### Flujo de la estrategia Rolling

1. Se ejecutan los pre- hook.
2. Se arrancan las replicas con la version nueva del código.
3. Se echan abajo las replicas antiguas.
4. Se repite el proceso hasta que se estan ejecutando el número deseado de replicas nuevas y no existen replicas viejas.
5. Se ejecutan los post- hook. 

---
#### Rolling demo

```
oc new-project rollingdemo
oc create -f rollingdemo.yaml
oc tag deployment-example:v2 deployment-example:latest && oc logs -f dc/deployment-example
```
---
## Conclusion Rolling

- *Puede evitar la perdida de servicio.*
- *Convivencia de 2 versiones distintas simultaneamente.*

---
#### Estrategia custom

- Nos permite definir el comportamiento.

```
customParams:
        command:
        - /bin/sh
        - -c
        - |
          set -e
          openshift-deploy --until=50%
          echo Halfway
          openshift-deploy
          echo Finished
```

---
#### Demo estrategia custom

```
oc new-project customdemo
oc create -f customdemo.yaml
oc tag deployment-example:v2 deployment-example:latest && oc logs -f dc/deployment-example
```

---
#### Conclusion estrategia custom.

*Puede evitar la perdida de servicio.*

---
#### Estrategia Blue-Green

- Simplemente se cambia la ruta para que apunte al servicio de la nueva versión.

---
#### Demo estrategia Blue-Green
```
oc new-app openshift/deployment-example:v1 --name=example-green
oc new-app openshift/deployment-example:v2 --name=example-blue
oc expose svc/example-green --name=bluegreen-example
oc patch route/bluegreen-example -p '{"spec":{"to":{"name":"example-blue"}}}'
```

---
#### Conclusion estrategia Blue-Green.

- *Puede evitar la perdida de servicio.*
- *Fácil vuelta atrás.*

---

#### Estrategia A/B

- Se puede distribuir la carga entre distintas versiones.

---
#### Demo estrategia A/B
```
oc new-project ab
oc new-app openshift/deployment-example:v1 --name=ab-example-a
oc new-app openshift/deployment-example:v2 --name=ab-example-b
oc expose svc/ab-example-a --name=web
oc set route-backends web ab-example-a=1 ab-example-b=9
for i in `seq 100` ; do curl -s web-ab.192.168.42.204.nip.io | grep div ; done
```

---
#### Conclusion estrategia A/B
- *Puede evitar la perdia de servicio.*
- *Permite pruebas de varias versiones simultaneas.*
- *Fácil vuelta atrás.*


---
### ¿Preguntas?

*twitter.com/javilinux*

*javilinux@gmail.com*

---

### Más Información


TODO:
- Mas información
- Video?
- Instrucciones
