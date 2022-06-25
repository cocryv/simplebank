# On découpe en plusieurs stage comme ça l'image docker est plus petite (on crée le build, ensuite depuis le run stage on utilise le build)

#Build stage
FROM golang:1.18.3-alpine3.16 AS builder
WORKDIR /app
COPY . .
RUN go build -o main main.go

#Run stage
FROM alpine:3.16
WORKDIR /app
COPY --from=builder /app/main .
COPY app.env .

EXPOSE 8080
CMD [ "/app/main" ]


# docker run --name simplebank --network bank-network -p 8080:8080 -e GIN_MODE=release -e DB_SOURCE="postgresql://root:root@postgres14/simple_bank?sslmode=disable" simplebank:latest