# little-bigtable-docker

Container build for [bitly/little_bigtable](https://github.com/bitly/little_bigtable),
a local Cloud Bigtable emulator with SQLite persistence (a fork of Google's own
`cbtemulator` reference implementation from `google-cloud-go/bigtable/bttest`).

Used to run a persistent Bigtable-compatible backend for firecrawl's change-tracking
feature in a self-hosted k3s cluster, where the official `cbtemulator` (in-memory only,
wipes on restart) isn't durable enough.

Image published to `ghcr.io/carev01/little-bigtable` by the GitHub Actions workflow on
every push to `main` and on version tags.

## Usage

```
docker run -p 9000:9000 -v little_bigtable_data:/data ghcr.io/carev01/little-bigtable:latest
```

Point any Bigtable client at it via `BIGTABLE_EMULATOR_HOST=host:9000` — this is
auto-detected by the official Bigtable client libraries and the `cbt` CLI.

## Limitations

Inherited from upstream: some filters are not implemented or have partial support
compared to real Bigtable. See the [upstream README](https://github.com/bitly/little_bigtable#limitations).
