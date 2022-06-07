# workon
A simple tool to navigate your repositories 


## How to install
1. Clone the latest project to your local
```
git clone https://github.com/J0hnnyZhang/workon.git
```

2. Export workspace, where you want workon to work with. you can skip this step if you want it uses the default 
workspace, which is the home directory of current user.
```shell
 eport WORKON_WORKSPACE=$"your workspace path"
```

3. Setup workon, goto the workon code base root dir and `run setup.sh`
```shell
cd ${workon project root directory} && sh setup.sh
```
## How to use

- Go to your directory
```shell
 workon $dir
```
 if no argument, will goto $WORKON_WORKSPACE directory
 
- Add a new repository to your command
```shell
 workadd $dir
```

- Add a shortname to a long name repository
```shell
 workalias $repo $shortname
```