### [Aplicación de parches de seguridad sin perdida de servicio en OpenShift](https://github.com/javilinux/conferences/tree/master/2018/supersec/downtime)

*Javier Ramirez Molina*

*OpenShift Support at Red Hat*

*twitter.com/javilinux*

*javilinux@gmail.com*

---

### Disclaimer

*Opiniones propias*

*Versiones upstream y cuenta de developer*

---

#### Introducción
 
En esta charla veremos las distintas estrategias de despliegue que podemos utilizar en OpenShift:
* Recreate
* Rolling
* Custom
* Blue-Green
* A/B

---

#### ¿Que es OpenShift?

- Plataforma como servicio.
- Docker (CRI-O), Kubernetes, Etcd, haproxy...
- Origin es la version upstream.

---

#### Recreate

- Remueve las instancias antiguas y crea nuevas.
- Soporta hooks.

---

#### Flujo de la estrategia recreate

1. Ejecuta el pre- hook.
2. Escala a 0 la versión antigua.
3. Ejeucta el mid- hook.
4. Escala la nueva versión.
5. Ejecuta el post- hook.

---

#### Recreate demo

- Nos bajamos el cliente de OpenShift.
```
oc cluster up
```
- O con Minishift:

```
minishift start
```

```
oc new-project recreatedemo
oc create -f recreatedemo.yaml
oc tag deployment-example:v2 deployment-example:latest && oc logs -f dc/deployment-example
```

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

