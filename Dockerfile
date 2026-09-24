FROM golang:1.26 AS build
ARG LITTLE_BIGTABLE_REF=v0.1.1
WORKDIR /src
RUN git clone --depth 1 --branch ${LITTLE_BIGTABLE_REF} https://github.com/bitly/little_bigtable.git .
RUN CGO_ENABLED=1 go build -o /out/little_bigtable .

FROM debian:12-slim
RUN useradd -u 10001 -M -s /usr/sbin/nologin emulator
COPY --from=build /out/little_bigtable /usr/local/bin/little_bigtable
USER emulator
EXPOSE 9000
ENTRYPOINT ["/usr/local/bin/little_bigtable"]
CMD ["-host", "0.0.0.0", "-port", "9000", "-db-file", "/data/little_bigtable.db"]
