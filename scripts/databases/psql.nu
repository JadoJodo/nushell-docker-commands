def --wrapped psql [
    --psql: string,
    --dbName(-d): string,
    --host(-h): string,
    --network: string,
    --password(-p): string,
    --user(-U): string,
    ...args: string
] {
    let psqlVersion = if ($psql | is-empty) { "17" } else { $psql }
    let containerVersion = $"($psqlVersion)-alpine"

    mut command = ""

    if ($network | is-not-empty) {
        $command += $"--network ($network) "
    }

    $command += "postgres psql"

    if ($dbName | is-not-empty) {
        $command += $"-d ($dbName) "
    }

    if ($host | is-not-empty) {
        $command += $"-h ($host) "
    }

    if ($user | is-not-empty) {
        $command += $"-U ($user) "
    }

    if ($password | is-not-empty) {
        $command += $"-p ($password) "
    }

    docker run -it --rm $"postgres:($containerVersion)" psql $command ...$args
}
