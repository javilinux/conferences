### [Aplicación de parches de seguridad sin perdida de servicio en OpenShift](https://github.com/javilinux/conferences/tree/master/2018/supersec/downtime)

*Javier Ramirez Molina*

*OpenShift Support at Red Hat*

*SuperSec 2018 Almería*

---

### Más Información

https://github.com/javilinux/conferences/2018/supersec/downtime

<small>
[OpenShift](https://www.openshift.org)

[Oc cluster up](https://github.com/openshift/origin/blob/master/docs/cluster_up_down.md)

[Minishift](https://www.openshift.org/minishift/)

[OpenShift Deployment Strategies](https://docs.openshift.org/latest/dev_guide/deployments/deployment_strategies.html)

[OpenShift Advanced Deployment Strategies](https://docs.openshift.org/latest/dev_guide/deployments/advanced_deployment_strategies.html#advanced-deployment-strategies-blue-green-deployments)

[Learn OpenShift](https://learn.openshift.com/)

[OpenShift for Developers](https://www.openshift.com/for-developers/)
[DevOps with OpenShift](https://www.openshift.com/devops-with-openshift/)
[Deploying to OpenShift](https://blog.openshift.com/deploying-to-openshift-our-latest-free-ebook/)
</small>

---

### Disclaimer

*Opiniones propias*

*Versiones upstream y cuenta de developer*

---

#### Introducción

- Vulnerabilidad encontrada en un contenedor.
- Nuevo despliegue sin perdida de servicio en OpenShift.

---

#### Estrategias de despliegue en OpenShift

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
#### Entorno demo

- Aplicación deployment-example:
https://github.com/openshift/origin/tree/master/examples/deployment

- Usaré ficheros yaml con los distintos componentes:
   - Servicios
   - Imagen
   - Configuración de despliegue

---

#### Estrategia Recreate

- Remueve instancias antiguas y crea nuevas.
- Soporta hooks.

----

#### Flujo de la estrategia recreate

1. Ejecuta el pre-hook.
2. Escala a 0 la versión antigua.
3. Ejeucta el mid-hook.
4. Escala la nueva versión.
5. Ejecuta el post-hook.

----

#### Demo recreate

```
oc new-project recreatedemo
oc create -f recreatedemo.yaml
oc tag deployment-example:v2 deployment-example:latest && oc logs -f dc/deployment-example
```
---
#### Conclusion recreate

*No evita la pérdida de servicio.*

---
#### Rolling

- Reemplaza poco a poco las insntancias.
- Se hacen comprobaciones antes de reemplazar.

----
#### Flujo de la estrategia Rolling

1. Se ejecutan los pre- hook.
2. Se arrancan las replicas con la version nueva del código.
3. Se echan abajo las replicas antiguas.
4. Se repite el proceso hasta que se estan ejecutando el número deseado de replicas nuevas y no existen replicas viejas.
5. Se ejecutan los post- hook. 

----
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

----
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

Cambiamos la ruta para que apunte al nuevo servicio.

----
#### Demo estrategia Blue-Green
```
oc new-project bluegreen
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

Distribuir la carga mediante rutas.

----
#### Demo estrategia A/B
```
oc new-project ab
oc new-app openshift/deployment-example:v1 --name=ab-example-a
oc new-app openshift/deployment-example:v2 --name=ab-example-b
oc expose svc/ab-example-a --name=web
oc set route-backends web ab-example-a=1 ab-example-b=9
for i in `seq 100` ; do curl -s web-ab.127.0.0.1.nip.io | grep div ; done
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

