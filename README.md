## Build web

This is assuming you have all dependencies install and configured (docs TODO)

```bash
# Build
cd soapong2/
make build-web

# Host
cd out/debug/web
python3 -m http.server 1738
```

## Build windows exe

```batch
rem Build
cd soapong2/
odin build game

rem Run
odin.exe
```