def --wrapped composer [
    --global(-g): string
    ...args: string
] {
    let composerHome = "~/.composer" | path expand

    let volume = ""
    if ($global | is-not-empty) {
        volume = $"--volume ($composerHome):/tmp"

    docker run -it --rm --name "composer" --volume $"(pwd):/app" $volume composer ...$args
}
