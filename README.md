# TOCKTOCK

Base de um sistema web de gerenciamento de tarefas em Java, com Spring Boot e MySQL. A tela inicial mostra apenas o nome **tocktock** no canto superior.

## Requisitos

- Java 17 ou superior
- Maven 3.6.3 ou superior
- MySQL instalado

## Executar neste computador

O banco `tocktock` já foi criado em uma instância MySQL isolada na pasta `.local/mysql`. O usuário e a senha da aplicação estão no arquivo `.env`, que não é enviado ao Git.

Se o MySQL do projeto não estiver rodando, inicie-o:

```bash
./scripts/start-db.sh
```

Carregue as credenciais e inicie o projeto no mesmo terminal:

```bash
set -a
source .env
set +a
mvn spring-boot:run
```

Acesse http://localhost:8080/.

Para conferir a conexão com o banco: `mysql --socket="$PWD/.local/mysql.sock" -u root -e 'SHOW DATABASES LIKE "tocktock";'`.

Os dados MySQL preexistentes em `/opt/homebrew/var/mysql` foram preservados. Eles usam uma versão incompatível com o binário MySQL instalado atualmente; por isso este projeto usa sua própria instância local.
