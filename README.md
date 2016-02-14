# Docker: Swift + Blackfish
A swift 2.2+ &amp; blackfish docker with git support for easy deployment


## Mount local volume for Html files

```
sudo docker run --name blackfish -p 8080:80 -v /your_code_directory:/srv/blackfish/public 
```

## Linking
