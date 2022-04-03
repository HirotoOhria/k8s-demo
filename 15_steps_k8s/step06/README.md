# Fist step of k8s

### Launch pod directly

Install kubectl and minikube.

Start minikube cluster.

```shell
❯ minikube start 
😄  minikube v1.25.2 on Darwin 12.2.1 (arm64)
✨  Automatically selected the docker driver
👍  Starting control plane node minikube in cluster minikube
🚜  Pulling base image ...
🔥  Creating docker container (CPUs=2, Memory=4000MB) ...
🐳  Preparing Kubernetes v1.23.3 on Docker 20.10.12 ...
    ▪ kubelet.housekeeping-interval=5m
    ▪ Generating certificates and keys ...
    ▪ Booting up control plane ...
    ▪ Configuring RBAC rules ...
🔎  Verifying Kubernetes components...
    ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
🌟  Enabled addons: storage-provisioner, default-storageclass
🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default
```

Check info of cluster.

```shell
❯ kubectl cluster-info 
Kubernetes control plane is running at https://127.0.0.1:49925
CoreDNS is running at https://127.0.0.1:49925/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```

Check structure of cluster

```shell
❯ kubectl get node    
NAME       STATUS   ROLES                  AGE   VERSION
minikube   Ready    control-plane,master   95s   v1.23.3
```

Launch pot.

- `-it`: only available when given `--restart=Never`
- `--restart=Never`: launch pod directly. (Not from controller)

```shell
❯ kubectl run hello-world --image=hello-world -it --restart=Never

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (arm64v8)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

Relaunch pod.

```shell
❯ kubectl run hello-world --image=hello-world -it --restart=Never
Error from server (AlreadyExists): pods "hello-world" already exists
```

Check info of pod.

```shell
❯ kubectl get pod 
NAME          READY   STATUS      RESTARTS   AGE
hello-world   0/1     Completed   0          101s
```

Delete pod.

```shell
❯ kubectl delete pod hello-world
pod "hello-world" deleted

❯ kubectl get pod               
No resources found in default namespace.
```

Relaunch pod.

```shell
❯ kubectl run hello-world --image=hello-world -it --restart=Never

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (arm64v8)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

Launch pod in background.

```shell
❯ kubectl run hello-world --image=hello-world --restart=Never     
pod/hello-world created
```

Show logs.

```shell
❯ kubectl logs hello-world                                   

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (arm64v8)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

### Launch pod throw deployment

Launch pod throw controller.
Use deployment controller.

```shell
❯ kubectl run hello-world --image=hello-world
pod/hello-world created
```

Check info of deployment controller.

```shell
❯ kubectl get all                            
NAME              READY   STATUS      RESTARTS      AGE
pod/hello-world   0/1     Completed   2 (30s ago)   36s

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   10m

❯ kubectl get deployments
No resources found in default namespace.
```

Why deployment not created?
I tried `--restart=Always`, but it not works.
Auto deleted deployment because it finished?
I do not resolve this problem.
Skip to next step.

Check info of deployment and pod.

```shell
❯ kubectl get deploy,pod 
NAME              READY   STATUS             RESTARTS        AGE
pod/hello-world   0/1     CrashLoopBackOff   6 (2m55s ago)   9m9s
```

This is mismatch of controller and workload of pod.

Launch 5 pod.

```shell
❯ kubectl create deployment --image=nginx server              
deployment.apps/server created

❯ kubectl get deploy,pod                        
NAME                     READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/server   1/1     1            1           12s

NAME                          READY   STATUS    RESTARTS   AGE
pod/server-5f5dc45899-xxx8n   1/1     Running   0          12s

❯ kubectl scale --replicas=5 deployment/server
deployment.apps/server scaled

❯ kubectl get deploy,pod                      
NAME                     READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/server   2/5     5            2           46s

NAME                          READY   STATUS              RESTARTS   AGE
pod/server-5f5dc45899-jhv9c   0/1     ContainerCreating   0          3s
pod/server-5f5dc45899-k7bvg   0/1     ContainerCreating   0          3s
pod/server-5f5dc45899-pc6rv   0/1     ContainerCreating   0          3s
pod/server-5f5dc45899-qbf9n   1/1     Running             0          3s
pod/server-5f5dc45899-xxx8n   1/1     Running             0          46s
```

Delete pods.

```shell
❯ kubectl delete pod server-5f5dc45899-jhv9c server-5f5dc45899-k7bvg
pod "server-5f5dc45899-jhv9c" deleted
pod "server-5f5dc45899-k7bvg" deleted

❯ kubectl get deploy,pod                                            
NAME                     READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/server   3/5     5            3           113s

NAME                          READY   STATUS              RESTARTS   AGE
pod/server-5f5dc45899-md9j9   0/1     ContainerCreating   0          3s
pod/server-5f5dc45899-mt6zt   0/1     ContainerCreating   0          3s
pod/server-5f5dc45899-pc6rv   1/1     Running             0          70s
pod/server-5f5dc45899-qbf9n   1/1     Running             0          70s
pod/server-5f5dc45899-xxx8n   1/1     Running             0          113s
```

Deployment keep number of pods to `--replicas`.

Delete deployment.

```shell
❯ kubectl delete deployment server
deployment.apps "server" deleted

❯ kubectl get deploy,pod          
No resources found in default namespace.
```

### Launch pod throw job

Launch pod throw job.

```shell
❯ kubectl run hello-world --image=hello-world --restart=OnFailure
pod/hello-world created

❯ kubectl get all                                                
NAME              READY   STATUS      RESTARTS   AGE
pod/hello-world   0/1     Completed   0          7s

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   33m

❯ kubectl logs hello-world

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (arm64v8)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```


























