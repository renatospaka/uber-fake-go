FROM golang:1.21

## UPDATE THE OS
RUN apt-get update && \
    apt-get install -y tzdata net-tools

WORKDIR /app

## SET ENVIRONMENT
ENV PATH="/go/bin:${PATH}"
ENV CGO_ENABLED=1 GOOS=linux GOARCH=amd64 GO111MODULE=on
ENV TZ America/Sao_Paulo

# COPY NECESSARY FILES
COPY go.mod go.* ./
RUN go mod download

# COPY THE PROJECT
COPY . ./

# UPDATE THE PROJECT
RUN go mod tidy

## KEEP THE CONTAINER RUNNiNG
CMD ["tail", "-f", "/dev/null"]
