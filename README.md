# clone-gitlab

`clone-gitlab.sh` is a pure bash script that will clone recursively all repositories from a Gitlab group
## Usage

```text
wait-for-it.sh host groupd_id token
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

```text
$ ./wait-for-it.sh gitlab.com 222 <YOUR_TOKEN>

```
