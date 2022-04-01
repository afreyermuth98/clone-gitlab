# clone-gitlab

`clone-gitlab.sh` is a pure bash script that will clone recursively all repositories from a Gitlab group

Disclaimer : It only works with HTTPS
## Prerequisites
You need to have an API token

## Usage

### Manual
```text
clone-gitlab.sh host group_id token token_name
```

### Docker
```text
docker run -v ${PWD}:/script docker.io/anthonymmk/clone-gitlab <GITLAB_HOST> <GROUP_ID> <TOKEN> <TOKEN_NAME>
```

## Examples

For example, let's imagine you have a parent group (ID = 222) with this structure :

```text
|- parentgroup
   |-- kidgroup1
   |   |-- repository1
   |   |-- repository2
   |   └-- repository3
   └-- kidgroup2
       |-- kidgroup2-1
       |   |-- repository4
       |   |-- repository5
       └-- kidgroup2-2
           |-- repository6
```

### Manual
```text
$ ./clone-gitlab.sh gitlab.com 222 glpat-tOkEnToKeNtOkEnToKen clone_token
```

### Docker
```text
docker run -v ${PWD}:/script docker.io/anthonymmk/clone-gitlab gitlab.com 222 glpat-tOkEnToKeNtOkEnToKen clone_token
```