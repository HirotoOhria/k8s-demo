# Container Development

Set display message.

```shell
❯ cat message 
This is tutorial of 15 steps k8s.
```

Build image.

```shell
❯ d build -t step03 .
[+] Building 5.9s (9/9) FINISHED                                                                                                    
 => [internal] load build definition from Dockerfile                                                                           0.0s
 => => transferring dockerfile: 153B                                                                                           0.0s
 => [internal] load .dockerignore                                                                                              0.0s
 => => transferring context: 2B                                                                                                0.0s
 => [internal] load metadata for docker.io/library/alpine:latest                                                               2.9s
 => [auth] library/alpine:pull token for registry-1.docker.io                                                                  0.0s
 => [1/3] FROM docker.io/library/alpine:latest@sha256:f22945d45ee2eb4dd463ed5a431d9f04fcd80ca768bb1acf898d91ce51f7bf04         0.6s
 => => resolve docker.io/library/alpine:latest@sha256:f22945d45ee2eb4dd463ed5a431d9f04fcd80ca768bb1acf898d91ce51f7bf04         0.0s
 => => sha256:03078ca19a05ae588902a0db13807f141a48f9b549ae3d235310fa68ff24355d 1.49kB / 1.49kB                                 0.0s
 => => sha256:80fa7f07ec7b717ec5f8e2717b91e3d659e129052ec3def2570a5674322688d9 2.72MB / 2.72MB                                 0.4s
 => => sha256:f22945d45ee2eb4dd463ed5a431d9f04fcd80ca768bb1acf898d91ce51f7bf04 1.64kB / 1.64kB                                 0.0s
 => => sha256:d72e2d383f2d5fb1e8186ebfd1fbb22a87c04f52ac12fc379d21abb368d373df 528B / 528B                                     0.0s
 => => extracting sha256:80fa7f07ec7b717ec5f8e2717b91e3d659e129052ec3def2570a5674322688d9                                      0.2s
 => [internal] load build context                                                                                              0.0s
 => => transferring context: 68B                                                                                               0.0s
 => [2/3] RUN   apk update && apk add figlet                                                                                   2.3s
 => [3/3] ADD   ./message.txt /message.txt                                                                                     0.0s
 => exporting to image                                                                                                         0.0s
 => => exporting layers                                                                                                        0.0s
 => => writing image sha256:e2814aa0436b70300aa0f9b8e0d4597b0845417fb0bd2bcfa96671091119aa6f                                   0.0s
 => => naming to docker.io/library/step03                                                                                      0.0s 
                                                                                                                                    
Use 'docker scan' to run Snyk tests against images to find vulnerabilities and learn how to fix them
```

Run container.

```shell
❯ d run step03            
 _____ _     _       _       _         _             _       _          __ 
|_   _| |__ (_)___  (_)___  | |_ _   _| |_ ___  _ __(_) __ _| |   ___  / _|
  | | | '_ \| / __| | / __| | __| | | | __/ _ \| '__| |/ _` | |  / _ \| |_ 
  | | | | | | \__ \ | \__ \ | |_| |_| | || (_) | |  | | (_| | | | (_) |  _|
  |_| |_| |_|_|___/ |_|___/  \__|\__,_|\__\___/|_|  |_|\__,_|_|  \___/|_|  
                                                                           
 _ ____        _                   _    ___        
/ | ___|   ___| |_ ___ _ __  ___  | | _( _ ) ___   
| |___ \  / __| __/ _ \ '_ \/ __| | |/ / _ \/ __|  
| |___) | \__ \ ||  __/ |_) \__ \ |   < (_) \__ \_ 
|_|____/  |___/\__\___| .__/|___/ |_|\_\___/|___(_)
                      |_|
```

Container is finished.

```shell
❯ d ps -a
CONTAINER ID   IMAGE     COMMAND                  CREATED              STATUS                          PORTS     NAMES
7c3a03f1a176   step03    "/bin/sh -c 'cat /me…"   About a minute ago   Exited (0) About a minute ago             ecstatic_germain
```

Awesome]!

# Awareness

- CMD can write not using open / close brackets