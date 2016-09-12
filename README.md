## Docker instructions:

### Build:

```
docker build -t klaital/abandonedforge .
```

### Run:
```
docker run -P --name aforge -i -t klaital/abandonedforge
```
You will need to find the port that is exposing the rails instance via this command:
```
docker port aforge
```


