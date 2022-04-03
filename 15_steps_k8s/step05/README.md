# Container API

Build image.

```shell
❯ di build --tag deamon .
[+] Building 2.6s (8/8) FINISHED                                                                                                    
 => [internal] load build definition from Dockerfile                                                                           0.0s
 => => transferring dockerfile: 158B                                                                                           0.0s
 => [internal] load .dockerignore                                                                                              0.0s
 => => transferring context: 2B                                                                                                0.0s
 => [internal] load metadata for docker.io/library/alpine:latest                                                               0.9s
 => [internal] load build context                                                                                              0.0s
 => => transferring context: 227B                                                                                              0.0s
 => CACHED [1/3] FROM docker.io/library/alpine:latest@sha256:f22945d45ee2eb4dd463ed5a431d9f04fcd80ca768bb1acf898d91ce51f7bf04  0.0s
 => [2/3] RUN apk update &&     apk add bash                                                                                   1.6s
 => [3/3] ADD ./deamon.sh /deamon.sh                                                                                           0.0s 
 => exporting to image                                                                                                         0.0s 
 => => exporting layers                                                                                                        0.0s 
 => => writing image sha256:a1c8423c13905ef98a3b4f88d3af9d389659bf5215270b9ea7aca333d42117dd                                   0.0s 
 => => naming to docker.io/library/deamon      

❯ di ls | grep deamon    
deamon                        latest              a1c8423c1390   21 seconds ago   9.65MB
```

Run container.

```shell
❯ dc run --name deamon deamon
05:20:26 : 0 
05:20:29 : 1 
05:20:32 : 2 
05:20:35 : 3 
05:20:38 : 4 
05:20:41 : 5 
05:20:44 : 6 
05:20:47 : 7 
05:20:50 : 8 
```

Stop container.

```shell
❯ dc stop deamon                                          
deamon
```

Restart container.

```shell
❯ dc start -i deamon         
05:22:06 : 0 
05:22:09 : 1 
05:22:12 : 2 
05:22:15 : 3 
```

Data in memory is not retained.
