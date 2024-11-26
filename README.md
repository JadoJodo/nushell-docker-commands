# Docker Commands For Nushell

This is a collection of scripts that allow you to run common libraries and tools in ephemeral Docker containers.

By default, the scripts will run the latest version of the container, but you can specify a specific version by passing the `--version` flag.

Also: The current behavior for a lot of these scripts is to mount the current working directory into the container. This is done to make it easier to run commands like `npm install` or `composer install` without having to specify the path to the directory.

Feel free to contribute to this project by submitting a pull request.

---

## Examples

### Node

```nushell
> node --node 18
>> Welcome to Node.js v18.0.0
>> Type ".help" for more information.
>> >
```

### PHP

```nushell
> php --php 8.2 hello.php
>> "Hello World"
> php
>> Interactive Shell
>>
>> php >
```

### Go

```nushell
> go --go 1.23
>> Go is a tool for managing Go source code.
```

### PostgreSQL

```nushell
> postgres --postgres 17 --dbName my-db --user my-user --password my-password
>> database system is ready to accept connections
```

### psql

```nushell
> psql --psql 17 --host my-host --dbName my-db --user my-user --password my-password
>> psql
```
