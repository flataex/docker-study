FROM diamol/golang AS builder

COPY main.go .

RUN go build -o /server && \
    chmod +x /server

# app
FROM diamol/base

WORKDIR web


CMD ["/web/server"]
ENV USER=sixeyed
EXPOSE 80

# 파일이 수정될 경우 다른 레이어가 영향을 받지 않도록 뒤에 위치(CMD는 마지막에 실행되는 것이 보장되므로 앞에 있어도 상관 X)
COPY index.html .
COPY --from=builder /server .