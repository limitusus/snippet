# CircleCI Context lister

## Usage

`.envrc`

```sh
export CIRCLECI_OWNER_SLUG=gh/your-organization-name
export CIRCLECI_API_TOKEN=YOUR_PERSONAL_API_TOKEN
```

```console
direnv allow .
./context
```

will show the CSV formatted `context_name,variable_name` pairs.
