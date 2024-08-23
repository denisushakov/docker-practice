FROM golang:1.22 AS build

WORKDIR /app

COPY go.mod go.sum ./ 

RUN go mod download

COPY . .

RUN go build -o /app/my_app .

FROM scratch

COPY --from=build /app/my_app /app/my_app

EXPOSE 8080

CMD ["/app/my_app"]