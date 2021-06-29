# workon
A simple tool to navigate your repositories 


## How to install
1. export workspace, where your codes located
```shell
 eport WORKSPACE=$"path to code directory"
```

2. pull this repo to your workspace directory
```shell
 cd $WORKSPACE && git clone https://github.com/DewMaple/workon
```
3. add the following lines to your bash_profile or zshrc
   if you want to use another command alias, just replace *workon*, *workadd*, *workalias* to what you like
```shell
  alias workon='. $WORKSPACE/workon/workon.sh'
  alias workadd='python $WORKSPACE/workon/workon/workon.py assemble'
  alias workalias='python $WORKSPACE/workon/workon/workon.py alias'
```

## How to use

- Go to your repository directory
```shell
 workon $repo
```
 if no argument, will goto $WORKSPACE directory
 
- Add a new repository to your command
```shell
 workadd $repo
```

- Add a shortname to a long name repository
```shell
 workalias $repo $shortname
```