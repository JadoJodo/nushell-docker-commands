def --wrapped node [
    --node: string,
    ...args: string
] {
    let nodeVersion = if ($node | is-empty) { "current" } else { $node }
    let containerVersion = $"($nodeVersion)-alpine"

    (
        docker run -it --rm --name $"node-($containerVersion)"
            -v $"(pwd):/usr/src/app"
            -w /usr/src/app $"node:($containerVersion)"
            node ...$args
    )
}
