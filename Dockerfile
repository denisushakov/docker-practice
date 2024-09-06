FROM golang:1.22 AS build

WORKDIR /app

COPY go.mod go.sum ./ 

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /app/my_app .

# Проверка существования исполняемого файла
RUN ls -l /app/my_app

FROM scratch

COPY --from=build /app/my_app /app/my_app

EXPOSE 8080

CMD ["/app/my_app"]