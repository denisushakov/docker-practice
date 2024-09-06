FROM golang:1.22-alpine AS build

WORKDIR /app

COPY go.mod go.sum ./ 

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /app/my_app .

# Проверка существования исполняемого файла
RUN ls -l /app/my_app

FROM alpine:latest

COPY tracker.db /app/tracker.db

EXPOSE 8080

CMD ["/app/my_app"]