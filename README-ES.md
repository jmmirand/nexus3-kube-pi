# Nexus3  para Raspberry PI

La imagen oficial de Nexus3 cuando la intentamos ejecutar en una Raspberry PI 4 Modelo B nos da un error

**standard_init_linux.go:211: exec user process caused "exec format error"**

``` bash
ubuntu@master:~/kube-nexus-pi$ docker run sonatype/nexus3
Unable to find image 'sonatype/nexus3:latest' locally
latest: Pulling from sonatype/nexus3
865dc90c13b3: Pull complete
886bc343b9fd: Pull complete
37044071693a: Pull complete
3fd6bb466e42: Pull complete
Digest: sha256:8926032ab7eb9389351df78e68f21d1452dd57200152f424a57bcb26094e50c4
Status: Downloaded newer image for sonatype/nexus3:latest
standard_init_linux.go:211: exec user process caused "exec format error"
```

Esto después de hacer varias pruebas requiere que se construya la imagen en una Rasberry Pi para que pueda ser ejecutada.

Conclusión para solucionarlo, creamos esta imagen instalando estrictamente necesario usando el [manual de instalación de nexus sonatype](https://help.sonatype.com/repomanager3/installation/installation-methods#InstallationMethods-Unix)

**Además** :
 * Desactivamos la generación de pasword por defecto admin
 * Usuario/Password por defecto admin/admin123
 * Directorio de Datos /nexus-data


## Construcción

Para la construcción de la imagen y subida al repositorio Github [jmmirand/nexus3-kube-pi](https://hub.docker.com/repository/docker/jmmirand/nexus3-kube-pi)

```
docker build --tag jmmirand/nexus3-kube-pi:3.25.0 .

docker push jmmirand/nexus3-kube-pi:3.25.0

```


## Ejecución vía Docker


```
docker run jmmirand/nexus3-kube-pi:3.25.0 -p 8081:8081
```

Si queremos persistir los datos en un volumen externo.

```
docker run  -p 8081:8081 -v $(PWD)/nexus-data:/nexus-data jmmirand/nexus3-kube-pi:3.25.0
```


## Ejecución en Kubernete

Para ejecuta nexus desde un cluster Kubernetes ejecutamos

```
kubectl create -f kube-nexus-pi-deploy-metadata.yml

open http://nexus.192.168.1.11.nip.io/

```
