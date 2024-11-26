def --wrapped postgres [
    --postgres: string,
    --dbName(-d): string,
    --user(-U): string,
    --password(-p): string,
    --save(-s),
    --detach(-d)
    ...args: string
] {
    let postgresVersion = if ($postgres | is-empty) { "17" } else { $postgres }
    let containerVersion = $"($postgresVersion)-alpine"

    # Password
    mut postgresPassword = ""

    if ($password | is-empty) { $postgresPassword = random chars } else { $postgresPassword = $password }

    # Database
    mut postgresDb = ""

    if ($dbName | is-empty) {
        if ($user | is-empty) {
            $postgresDb = ["postgres", (random chars --length=5)] | str join "-"
        } else {
            $postgresDb = $user
        }
    } else {
        $postgresDb = $dbName
    }

    # User
    mut postgresUser = ""
    if ($user | is-empty) {
        $postgresUser = "postgres"
    } else {
        $postgresUser = $user
    }

    mut rootPath = ""
    mut dbPath = ""
    if ($save) {
        $rootPath = $"~/Data/DB/pgsql/($postgresDb)" | path expand
        $dbPath = $"($rootPath)/data"
    } else {
        $dbPath = $"/tmp/($postgresDb)/"
    }
    mkdir $dbPath

    if ($save and ($"($rootPath)/.env" | path exists) != true) {
        touch $"($rootPath)/.env"
        let envVariables = [
            POSTGRES_USER=($postgresUser),
            POSTGRES_PASSWORD=($postgresPassword),
            POSTGRES_DB=($postgresDb),
        ]
        open $"($rootPath)/.env" | $envVariables | str join (char newline) | save -f $"($rootPath)/.env"
    }

    print "Database configuration"
    print "––––––––––––––––––––––"
    print $"Name: ($postgresDb)"
    print $"Filepath: ($rootPath)"
    print $"User: ($postgresUser)"
    print $"Password: ($postgresPassword)"
    print $"Connection string: `postgres://($postgresUser):($postgresPassword)@localhost:5432/($postgresDb)`"

    mut $dockerArgs = ""
    if ($detach) {$dockerArgs += " -d"}
    docker run $"--rm($dockerArgs)" -e POSTGRES_PASSWORD=($postgresPassword) -e POSTGRES_DB=($postgresDb) -e POSTGRES_USER=($postgresUser) -v $"($dbPath):/var/lib/postgresql/data" postgres:($containerVersion)
}
