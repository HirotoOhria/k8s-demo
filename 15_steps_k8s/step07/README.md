# Manifest and Pod

Launch pod from manifest file.

```shell
❯ kubectl apply -f nginx-pod.yml
pod/nginx created

❯ kubectl get all               
NAME        READY   STATUS              RESTARTS   AGE
pod/nginx   0/1     ContainerCreating   0          2s

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   45m
```

Delete pod from manifest file.

```shell
❯ kubectl delete -f nginx-pod.yml 
pod "nginx" deleted

❯ kubectl get all                
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   46m
```

Check IP address of node.

```shell
❯ kubectl get po nginx -o wide
NAME    READY   STATUS    RESTARTS   AGE   IP           NODE       NOMINATED NODE   READINESS GATES
nginx   1/1     Running   0          11s   172.17.0.3   minikube   <none>           <none>
```

Access to nginx pod from another pod on same cluster.

```shell
❯ kubectl run busybox --image=busybox --rm -it sh 
If you don't see a command prompt, try pressing enter.
/ # wget -q -O - http://172.17.0.3/
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>

❯ kubectl get po -o wide      
NAME      READY   STATUS    RESTARTS   AGE     IP           NODE       NOMINATED NODE   READINESS GATES
busybox   1/1     Running   0          103s    172.17.0.4   minikube   <none>           <none>
nginx     1/1     Running   0          4m46s   172.17.0.3   minikube   <none>           <none>

```

