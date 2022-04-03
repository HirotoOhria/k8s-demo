FROM  alpine:latest

RUN   apk update && apk add figlet
ADD   ./message.txt /message.txt

CMD   cat /message.txt | figlet