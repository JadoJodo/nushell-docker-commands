def --wrapped php [
    --php: string,
    ...args: string
] {
    let phpVersion = if ($php | is-empty) { "8.3" } else { $php }
    let containerVersion = $"($phpVersion)-cli-alpine"

    if ($args | is-not-empty) {
        (
            docker run -it --rm --name $"php-($containerVersion)"
                -v $"(pwd):/usr/src/run"
                -w /usr/src/run $"php:($containerVersion)"
                php ...$args
        )
    } else {
        (
            docker run -it --rm --name php-run
                -v $"(pwd):/usr/src/run"
                -w /usr/src/run $"php:($containerVersion)"
                php -a
        )
    }
}
