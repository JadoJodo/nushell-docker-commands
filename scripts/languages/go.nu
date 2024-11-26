def --wrapped go [
    --versions,
    --use(-u): string,
    ...args: string
] {
    let goVersion = if ($use | is-empty) { "1.23" } else { $use }
    let containerVersion = $"($goVersion)-alpine"
    (
        docker run -it --rm --name $"go-($containerVersion)"
            -v $"(pwd):/usr/src/app"
            -w /usr/src/app $"golang:($containerVersion)"
            go ...$args
    )
}
