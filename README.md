# TRACTIAN

Este é um aplicativo da TRACTIAN desenvolvido com Flutter, utilizando os princípios do **Clean Architecture**, **SOLID**
e **MVC** para garantir escalabilidade, manutenibilidade e facilidade de testes.

## Estrutura do Projeto

O projeto segue uma organização modular, com separação em camadas de **dados**, **domínio** e **apresentação**. As
principais pastas são:

### lib

- **app**: Contém o `AppWidget`, ponto de entrada do aplicativo.
- **core**: Recursos compartilhados e infraestrutura do projeto:
    - **infra**: Serviços como comunicação HTTP.
    - **utils**: Ferramentas utilitárias, como debounce.
    - **error**: Tratamento de erros e falhas.
    - **injection**: Configuração de injeção de dependências.
- **features**: Módulos principais do aplicativo:
    - **menu**: Responsável pela seleção de empresas.
    - **assets**: Apresentação e gerenciamento dos ativos no formato de árvore.
- **shared**: Recursos globais como widgets reutilizáveis.
- **l10n**: Arquivos de internacionalização.

## Funcionalidades

- **Listagem de Empresas:** Exibe uma lista de empresas disponíveis.
- **Árvore de Ativos:** Representa os ativos e localizações no formato de árvore.
- **Busca:** Permite pesquisar por ativos ou localizações.

## Tecnologias Utilizadas

- [**Flutter**](https://flutter.dev): Desenvolvimento de interfaces nativas.
- [**Dio**](https://pub.dev/packages/dio): Requisições HTTP.
- [**GoRouter**](https://pub.dev/packages/go_router): Gerenciamento de rotas.
- [**Either**](https://pub.dev/packages/either_dart): Tratamento de erros.
- [**GetIt**](https://pub.dev/packages/get_it): Injeção de dependência.
- **Clean Architecture**: Organização modular em camadas independentes.
- **Testes Unitários**: Garantia de qualidade com validação automatizada.

## TreeUtils: Gerenciamento de Estruturas Hierárquicas

A classe `TreeUtils` ajuda a organizar e buscar dados em hierarquias, como localizações e ativos de uma fábrica. Ela
oferece duas funcionalidades principais:

### **Construção de Árvores**

A partir de listas planas de localizações (`LocationEntity`) e ativos (`AssetEntity`), cria uma estrutura de árvore com
base nos relacionamentos (`parentId` ou `locationId`).

- **Como funciona**:
    - Identifica os nós raiz (sem pai).
    - Conecta cada nó aos seus filhos de forma iterativa usando um mapeamento eficiente.

### **Busca em Árvores**

Filtra a árvore para encontrar apenas os nós que atendem a uma condição específica, recriando a hierarquia
correspondente.

- **Como funciona**:
    - Usa uma busca baseada em profundidade para verificar cada nó e seus descendentes.
    - Retorna uma subárvore contendo apenas os resultados que atendem ao critério.

## Instalação e Execução

1. **Clone o repositório**:
   ```bash
   git clone https://github.com/pablostefan/tractian.git
   ```

2. **Navegue até o diretório do projeto**:
   ```bash
   cd tractian
   ```

3. **Instale as dependências**:
   ```bash
   flutter pub get
   ```

4. **Configuração do Ambiente**:
    - Crie um arquivo `.env` na raiz do projeto e adicione as variáveis de ambiente necessárias.
    - Exemplo de arquivo `.env`:

       ```plaintext
        BASE_URL=https://fake-api.tractian.com
        ```

5. **Execute o aplicativo com o arquivo `.env`**:
    ```bash
    flutter run --dart-define-from-file=.env
    ```

> **Nota**: O comando `--dart-define-from-file=.env` é necessário para carregar as variáveis de
> ambiente configuradas no arquivo `.env`.
> Embora seja recomendável adicionar o arquivo .env ao .gitignore para evitar sua inclusão no repositório,
> ele foi intencionalmente mantido no repositório neste caso específico para facilitar os testes.

## Estrutura de Pastas

```plaintext
lib/
├── app/                         # Ponto de entrada do aplicativo
├── core/                        # Recursos compartilhados
│   ├── error/                   # Tratamento de erros
│   ├── infra/                   # Infraestrutura (ex.: HTTP)
│   ├── injection/               # Injeção de dependências
│   └── utils/                   # Utilitários
├── features/                    # Módulos principais
│   ├── assets/                  # Árvore de ativos
│   │   ├── data/                # Camada de dados
│   │   ├── domain/              # Camada de domínio
│   │   └── presentation/        # Camada de apresentação
│   └── menu/                    # Seleção de empresas
│       ├── data/                # Camada de dados
│       ├── domain/              # Camada de domínio
│       └── presentation/        # Camada de apresentação
└── l10n/                        # String internacionalizadas
└── shared/                      # Recursos compartilhados
```

## Testes de Unidade

O projeto inclui testes de unidade para validar a funcionalidade de partes principais da aplicação.
Esses testes ajudam a garantir a estabilidade e a precisão dos componentes, como as fontes de dados
locais e remotas. Os principais arquivos de teste incluem:

- **assets_repository_test.dart**: Contém testes para a camada de repositório, verificando a interação com o data
  source.
- **assets_usecase_test.dart**: Valida o comportamento do caso de uso responsável por orquestrar a lógica de construção
  da hierarquia de ativos e localizações.
- **companies_repository_test.dart**: Contém testes para o repositório responsável por buscar os dados de empresas.

Para executar os testes de unidade, utilize o comando abaixo:

```bash
flutter test
```

Esses testes permitem uma verificação rápida das funcionalidades principais e ajudam a identificar
possíveis problemas antes do deploy.

## Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`)
3. Commit suas mudanças (`git commit -am 'Adiciona nova feature'`)
4. Envie para o branch (`git push origin feature/nova-feature`)
5. Crie um novo Pull Request