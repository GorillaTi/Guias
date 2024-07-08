# Tipos de Redes, Drivers y monitoreo en Docker

Hasta ahora hemos visto, la Docker network de tipo Bridge. Sin embargo a veces, no queremos usar la red de Docker y usar directamente la red de nuestro host. Esto es posible usando el argumento ‐‐net=host cuando despleguemos nuestro contenedor.

Recordar que el argumento ‐‐net puede ser usado para determinar que red usar cuando despleguemos nuestro contenedor (igual que en rkt).

```docker
docker inspect ‐‐format='{‌{json .NetworkSettings}}'**
```

Sí por el contrario quieres que tu contenedor no tenga acceso a la red, puedes utilizar el mismo argumento pero pasándo el valor '­­net=none'. Docker añadirá el contenedor a un network group pero sin interfaz de red.  
A parte de usar estos tres tipos de redes es posible crear tu propia configuración de red para utilizar en tus contenedores Docker.

Por defecto, los contenedores están protegidos por el firewall del anfitrión y no abren ninguna ruta a sistemas externos. Esto puede cambiarse manipulando un poco con la bandera –network con las siguientes opciones:

- ***bridge*** : Red a través del bridge por defecto de docker

- ***none*** : No hay red

- ***container*** : red unida con otro contenedor especificado

- ***host*** : red de anfitrión (sin firewall)

Todas estas opciones pueden ser gestionadas con el comando *docker network*

```docker
$ docker network ls
```

```shell-session
NETWORK ID      NAME     DRIVER     SCOPE
86f4403c1e05    bridge   bridge     local
d030ab158e04    host     host       local
2765cfb12659    none     null       local
```

Si especificamos *none* como la red entonces no seremos capaces de conectarnos al contenedor y viceversa; El contenedor no tiene acceso al mundo exterior. la opción host hace que las interfaces del contenedor sean idénticas a las del anfitrión, comparten la misma IP así que todo lo que corre en el contenedor es visible desde afuera del mismo. Y finalmente la opción mas usada es la que viene por defecto: bridge, ya que nos permite controlar que vamos a exponer y que no, lo cual es mas seguro y accesible.

## Drivers de red con Docker

**Weave**: Es independiente de la topología de red que utilices y esta compuesto de varios componentes que se instalan en cada host y es el daemon que se encarga de todo la gestión de la red a nivel de cada host.

**Weave­dns**: Es una herramienta para crear dominios que pueden ser accedidos desde cualquier contenedor.

**Weave­proxy**: Crea un proxy que engloba y substituye el proxy de Docker para la comunicación entre Docker hosts.

**Weave­scope**: Es la herramienta para visualizar la topología que forman todos los contenedores.

Algunos de los aspectos a destacar de Weave son:

- Es de los primeros en ofrecer soporte para la comunicación entre hosts.

- Es simple, weave routers se retro alimentan de la información de otros weave router en otros hosts. Esto les permite tener conocimiento de los contenedores y hosts con los que pueden comunicarse.

- La información de red está distribuida a través de todos los nodos que componen la Weave network. Esto mejora la tolerancia a fallos.

- Tiene un sistema de encriptación incorporado, aunque caro a nivel de performance.

- Es capaz de hacer tunneling incluso a través de cortafuegos.

- Service discovery usando weave DNS.

- Usa NAT multicast y MTUs.

- Simple DNS load balancing (round­robin), que nos permite balancear los contenedores en la red tipo round­robin.

- Funciona en Giant Swarm, Kubernetes, Mesos lo que permite tener una visión de la topología de red y donde estan tus contenedores usando Weave­scope.

- Usa de Gossip protocol para compartir la información de red y la reglas de enrutado.

**Desventajas de Weave:**

No es el más rápido de todos los drivers de networking. Aunque ha mejorado su performance recientemente.

**Flannel**

Desarrollado por CoreOS y pensado para Kubernetes con el concepto de subnets para pods. Al igual que Docker networking, utiliza una base de datos clave/valor, Flannel hace uso de etcd para almacenar toda la información de red.

Algunos aspectos a destacar de Flannel son:

Proporciona la posibilidad de crear una network overlay (L3)

- Una subnet CIDR (enrutamiento entre dominios sin clases) por host (como con Kubernetes)

- Host A: 11.0.47.1/24

- Host B: 11.0.87.1/24

- No hay necesidad de hacer mapeos estáticos de puertos y IPs

- Usa etcd para salvaguardar la información de la network

- Contenedores hablan via direcciones IP

- Uso de IPSEC como protocolo de encapsulación

- Ofrece dos tipos de mecanismos para encapsular los paquetes:

- UDP

- VxLAN

- Ofrece drivers para configurar distintos tipos de networks: VxLAN, UDP, alloc,

- host­gw, aws­vpc.
  
  **Calico**

- Ofrece un modelo de networking parecido al de Internet (L2­L3).

- Permite definir perfiles ACLs para los contenedores. Incrementa la seguridad entre contenedores ya que no es necesario que los contenedores creen iptables si usan links entre ellos.

- Usa BGP para compartir la información de enrutado entre todos los hosts que componen el cluster de Calico.

- Escala bastante bien con una gran cantidad de contenedores.

- Uno de los mejores a nivel de Performance por detrás de Flannel.

El ecosistema de los contenedores en general es:

- Desconocido.

- Inestable.

- Repleto de tecnologías bastante inmaduras.

El Reto en el caso de las redes con Docker es entender y aprender patrones en los que los contenedores pueden llegar a fracasar.

De ahí que el Monitoring se vea como un mecanismo para aprender y anticipar a fallos.

## Infraestructura para monitoring de contenedores

Una infraestructura para monitoreo de contenedores requiere:

- Un sistema de monitoreo basado en contenedores.

- Presentar una arquitectura jerárquica así como un sistema central de monitoreo de los clusters para que cada host pueda llevar a cabo el monitoreo de sus contenedores.

Las características de una infraestructura para monitorear contenedores son:

- Ligera.

- Tener alta disponibilidad.

- Ser escalable.

- Contenerizada.

- Distribuida.

- Capaz de reducir el ruido para evitar distracción.

- Que tenga más código para analizar métricas que para coleccionarlas.

Las partes de una infraestructura de este tipo son:

- Logs

- Colección y almacenamiento de datos.

- Exploración del sistema.

- Alertas o Notificaciones.

### Logs

Es necesario visualizar los logs para saber que esta pasando en los contenedores de haber una falla en el sistema, por esto es importante:

- Coleccionarlos.

- Procesarlos.

- Almacenarlos.

Docker ofrece un comando muy sencillo para mostrar los logs en stdout que es el siguiente:

```docker
$ docker logs CONTAINER_NAME
```

También ofrece la posibilidad de utilizar diferentes plugins para redireccionar los logs que son:

- Json­file

- Fluentd.

- Journald.

- Syslog.

- Awslog.

- Gelf.

Los plugins hay que configurarlos cuando arranquemos el Docker daemon de la siguiente manera:

```docker
$ docker daemon ‐‐logs‐driver=DRIVER_NAME
```

Algunas de las arquitecturas tradicionales y efectivas en el uso y almacenamiento de logs son:

- Elasticsearch.

- Logstash.

- Logstash­forwarder.

- Kibana.

### Consejos para el almacenamiento de Logs en Docker

Algunas recomendaciones de las arquitecturas tradicionales y mas efectivas en el uso y almacenamiento de logs en Docker son:

- Descubrir lo desconocido a través de los logs.

- Usar containers para los componentes de ELK.

- Usar niveles de acceso (DEBUG, INFO, ERROR, etc...).

## Exploración del Sistema

- Prevenir y identificar patrones de errores antes de tiempo.

- Definir alertas de una manera jerárquica.

Cluster => Hosts => Contenedor

## Conclusiones

1. Usa soluciones que estén contenerizadas. :D

2. Usa las herramientas que mejor se adaptan a tu problema.

3. Colecciona métricas para prevenir y entender los desconocido.

4. Analiza los datos coleccionados para detectar patrones en los fallos.
