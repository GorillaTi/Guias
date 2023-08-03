### Guía de:

# Configurar Nginx Inverso - WordPress

---

## ACERCA DE:

Versión: 1.0.0

Nivel: Avanzado

Área: CPD

Elaborado por: Edmundo Céspedes Ayllón

e-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

---

### 1. Configuración Nginx como proxy inverso

Configuración convencional de proxy inverso 

```nginx
server {
  listen 443 ssl;
  server_name example.org;   

  ssl_certificate example.pem;
  ssl_certificate_key example.pem;

  location / {

    proxy_pass         http://example.org:8080;

    proxy_set_header   Host $host;
    proxy_set_header   X-Real-IP  $remote_addr;
    proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header   X-Forwarded-Proto https;
    proxy_set_header   X-Forwarded-Host $host;
  }
}
```

Se describe a continuación los parámetros utilizados para la configuración:

1. `listen 443 ssl;`: Define que el servidor Nginx escuche en el puerto 443 (puerto por defecto para conexiones HTTPS) y habilite el soporte SSL/TLS para la comunicación segura.

2. `server_name example.org;`: Indica que este servidor Nginx atenderá las solicitudes para el dominio "example.org". Es decir, actuará como proxy inverso para este dominio.

3. `ssl_certificate example.pem;` y `ssl_certificate_key example.pem;`: Especifican la ubicación de los archivos de certificado y clave privada que se utilizarán para establecer la conexión segura SSL/TLS. El certificado (example.pem) contiene la clave pública y el certificado SSL, mientras que la clave privada (example.pem) se utiliza para descifrar los datos cifrados.

4. `location / {`: Define la ubicación en la que se aplicarán las reglas de proxy inverso. En este caso, todas las solicitudes que lleguen a la raíz del dominio "example.org" serán procesadas por estas reglas.

5. `proxy_pass http://example.org:8080;`: Especifica la dirección del servidor backend al que se deben redirigir las solicitudes. En este caso, todas las solicitudes que lleguen a Nginx serán reenviadas al servidor en "[http://example.org:8080](http://example.org:8080)".

6. `proxy_set_header ...;`: Estas directivas se utilizan para establecer las cabeceras HTTP que se enviarán al servidor backend. En este caso, se están configurando los siguientes encabezados:
   
   - `Host $host;`: Establece el encabezado "Host" para que coincida con el nombre del dominio en la solicitud original.
   - `X-Real-IP $remote_addr;`: Agrega el encabezado "X-Real-IP" con la dirección IP real del cliente que hizo la solicitud.
   - `X-Forwarded-For $proxy_add_x_forwarded_for;`: Añade el encabezado "X-Forwarded-For" con la lista de direcciones IP de los clientes anteriores, lo que ayuda a identificar las direcciones IP originales de los clientes en caso de que haya varios proxies en el camino.
   - `X-Forwarded-Proto https;`: Establece el encabezado "X-Forwarded-Proto" en "https", indicando que la solicitud original se realizó mediante HTTPS.
   - `X-Forwarded-Host $host;`: Añade el encabezado "X-Forwarded-Host" con el nombre del dominio en la solicitud original.

Estos parámetros aseguran que las solicitudes HTTPS dirigidas al dominio "example.org" sean reenviadas al servidor backend en "[http://example.org:8080](http://example.org:8080)" mientras se mantienen las cabeceras importantes para el seguimiento y la seguridad.

### 2. Forzar el uso de SSL en WordPress

Desde el proxy puedes forzar el uso de SSL en el sitio aunque, para evitar 
algunas re-direcciones conviene configurar WordPress para que use SSL.

Se puede hacer la configuración en el escritorio de WordPress, o editando el fichero **wp-config.php** de WordPress. Añadir tras la apertura de la etiqueta `<?php` las siguientes líneas:

```php
define('FORCE_SSL_ADMIN', true); 

define('WP_HOME','https://example.org');
define('WP_SITEURL','https://example.org');
```

Para forzar el uso de `https` en WordPress.

### 3. Solucionar redirect loop

Piensa que la comunicación entre el servidor proxy y el que aloja WordPress se hace mediante `http` *(no segura)*. Por eso la función **[is_ssl()](https://codex.wordpress.org/Function_Reference/is_ssl#Notes)** de WordPress no será capaz de detectar que la página se esta sirviendo realmente mediante `https` y responderá con una re-dirección 302, esto provoca un bucle de re-direcciones infinito, para evitar el problema hay que modificar el fichero **wp-config.php** e incluir las siguientes lineas:

```php
<?php
define('FORCE_SSL_ADMIN', true); 

define('WP_HOME','https://example.org');
define('WP_SITEURL','https://example.org');

if (strpos($_SERVER['HTTP_X_FORWARDED_PROTO'], 'https') !== false)
       $_SERVER['HTTPS']='on';
```

La nueva configuración revisa la cabecera `X-Forwarded-Proto` que envía Nginx y en el caso de existir activa la bandera `HTTPS` simula el uso de `https`.

> **NOTA.-** Si se usa el servicio Apache, para utilizar la variable HTTPS, se debe instalar el módulo mod_ssl y openssl. Es requerido aun que realmente no se gestione ningún certificado SSL desde Apache.

### Basado en:

[SuperAdmin.es](https://superadmin.es/blog/devops/proxy-inverso-wordpress-nginx/)
