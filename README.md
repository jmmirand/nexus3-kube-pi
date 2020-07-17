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

Para solucionarlo creamos esta imagen que solo instala lo estrictamente necesario y seguimos las instrucciones de instalación

## Construcción

Para la construcción de la imagen y subida al repositorio Github [jmmirand/nexus3-kube-pi](https://hub.docker.com/repository/docker/jmmirand/nexus3-kube-pi)

```
docker build --tag jmmirand/nexus3-kube-pi:3.25.0 .

docker push jmmirand/nexus3-kube-pi:3.25.0

```
