
## Aplicação Jupyter Notebook em Docker

Este repositório contém uma configuração Docker para a execução de um servidor Jupyter Notebook. A aplicação permite que você utilize Jupyter Notebook em um contêiner Docker, facilitando o gerenciamento do ambiente de desenvolvimento e das dependências.

### Requisitos
- Ter instalado `Docker`

### Passos para Configuração e Execução
### 1. Clonar o Repositório
Se você ainda não fez o download do código, clone o repositório no seu ambiente local:
 
> git clone <URL_DO_REPOSITORIO> \
    cd <PASTA_DO_REPOSITORIO>


### 2. Construir a Imagem Docker
No diretório onde se encontra o arquivo Dockerfile, execute o seguinte comando para criar a imagem Docker:

` docker build -t jupyter . ` 

Este comando cria uma imagem chamada `jupyter-image`, que será usada para iniciar o contêiner com o `Jupyter Notebook`.

### 3. Executar o Contêiner
* Para iniciar o contêiner com o Jupyter Notebook, execute o seguinte comando:


`docker  run -d --rm --name jupyter -p 1234:1234 -v "$(pwd)/ProjetoDocker:/home/notebooks" jupyter-image` 


Explicação dos parâmetros usados:
```
-d: Executa o contêiner em segundo plano.

--rm: Remove automaticamente o contêiner .

-p 1234:1234: Mapeia a porta local 1234 onde o Jupyter Notebook estará disponível.

-v Indica o caminho de onde serão salvos os volumes do diretório do conteiner para o diretório da máquina host.

``` 

### 4. Acessar o Jupyter Notebook
Após iniciar o contêiner, abra seu navegador e acesse o Jupyter Notebook em:

`http://localhost:1234`

Você verá uma página de login. O token de autenticação estará nos logs do contêiner, que você pode acessar com:
` docker container logs  jupyter ` 
**Copie o token e cole na página do Jupyter para acessar o ambiente.**

### 5. Parar o Contêiner
Para interromper o contêiner em execução, utilize o seguinte comando:

` docker stop jupyter` 

## Avaliação do Contêiner
### 1. Dados do Volume
O volume criado é montado no caminho `/home/notebooks`  dentro do contêiner, com o objetivo de persistir os arquivos de notebooks criados. Esse volume permite o acesso aos arquivos no contêiner diretamente do sistema de arquivos local.

### 2. Tamanho da Imagem vs. Tamanho do Contêiner em Execução
Tamanho da Imagem: Após construir a imagem com o comando ` docker build` , o tamanho da imagem jupyter-image pode ser verificado com:
` docker images jupyter-image` 
É mostrado um tamanho real e um virtual, o tamanho virtual indica o tamanho da imagem por si só, já o tamanho real irá indicar o tamanho do contêiner enquanto executa a imagem.

Tamanho do Contêiner em Execução: Para verificar o uso real de espaço em disco pelo contêiner em execução, utilize:

` docker ps -s --filter "name=jupyter"` 

### 3. Requisitos de Memória
O uso de memória do contêiner pode ser monitorado em tempo real com o comando:

`docker stats jupyter`

Este comando exibe a quantidade de memória utilizada pelo contêiner, além de outras métricas como uso de CPU e I/O. 

Para o teste de uso de memória em tempo real é possível criar um código genérico de uso de memória e avaliar o requisito da memória dentro do conteiner.

### 4. Tempo de Inicialização
Para avaliar o tempo de inicialização, observe o tempo que o comando `time docker run` leva para colocar o contêiner em execução e abrir o servidor Jupyter. Em geral, o tempo de inicialização demorou 
> real    0m8.410s \
user    0m0.037s    \
sys     0m0.019s
