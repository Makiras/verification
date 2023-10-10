# Building Docker containers

In order to build the containers on your system first clone the repository. For the best perfromance please use WSL2. If using native Windows, then don't forget to change the path from Linuux `/` to Windows `\`


```bash
git clone https://github.com/makiras/verification.git
cd verification
```

Then

```bash
docker build -f ./{name_of_container} -t {your_name_for_the_container} .
```

For example, to build `ubuntu-focal with ssh + xrdp for synopsys` use the following command:

```bash
docker build -t makiras/verification:sx-synopsys-focal -f ./dockerfiles/sx-synopsys-focal .
```

then run

```bash
docker run -it -p 33890:3389 verification:sx-synopsys-focal foo bar no
```
