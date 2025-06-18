# Desafio Técnico: Arquitetura de Dados E-commerce

## Visão Geral

Este desafio técnico tem como objetivo avaliar suas habilidades em arquitetura de dados, modelagem SQL e processos de transformação de dados. Você irá trabalhar com um conjunto de dados de e-commerce que precisa de reestruturação e otimização.  

***É importante ter em mente de que os códigos não serão de fato executados, a avaliação será sobre a organização e apresentação das idéias do desafiado e suas habilidades de demonstrar seus conhecimentos sobre arquitetura de bancos de dados. Assim como a organização de seus commits no repositório publico do github que deve ser disponibilizado como resposta à esse desafio.***

## Contexto

Você se juntou a uma empresa de e-commerce em crescimento que opera múltiplas marcas de varejo online. A equipe de dados tem utilizado uma configuração analítica básica, mas com o crescimento do negócio, surgiu a necessidade de melhorar a arquitetura de dados, implementar melhores práticas e otimizar o desempenho das consultas.

A configuração atual de dados apresenta vários problemas:
- Convenções de nomenclatura inconsistentes
- Transformações de dados redundantes
- Joins ineficientes causando problemas de desempenho
- Falta de documentação e testes
- Ausência de separação clara entre as camadas de dados (raw, transformed e reporting)

## Tarefa

Sua tarefa é analisar a arquitetura de dados atual e implementar melhorias para resolver os problemas identificados. Você deve:

1. **Analisar a arquitetura atual**: Entender o modelo de dados existente e identificar problemas.
2. **Redesenhar a arquitetura de dados**: Criar uma separação clara entre camadas de dados e implementar um design de esquema mais eficiente.
3. **Implementar transformações**: Desenvolver transformações SQL para converter dados brutos em um formato adequado para análise.
4. **Documentar sua abordagem**: Fornecer documentação explicando suas decisões de design e recomendações para melhorias futuras.

## Requisitos

### Obrigatórios
- Implementar modelagem adequada de dados com convenções de nomenclatura claras
- Criar uma arquitetura em camadas (raw, staging, intermediate e marts)
- Escrever transformações SQL eficientes
- Incluir pelo menos um exemplo de testes de qualidade de dados

### Opcionais (Extras)
- Implementar a solução usando dbt (data build tool)
- Criar um diagrama simples da linhagem de dados proposta

## Conjunto de Dados

O conjunto de dados representa transações de e-commerce em várias marcas. Ele inclui:

- Clientes (Customers)
- Produtos (Products)
- Pedidos (Orders)
- Itens de Pedidos (Order Items)
- Categorias de Produtos (Product Categories)
- Informações de Marcas (Brands)

Os arquivos de dados brutos estão disponíveis no diretório `data/raw` em formato CSV. Os arquivos contem apenas algumas poucas linhas, pois o foco deles é servir como amostra do conteúdo dos dados de cada uma das fontes. Porém, como iremos avaliar a proposta de arquitetura levando em consideração um cenário de Big Data, o uso de boas práticas para performance de queries em ambientes de grande volume de dados é importante para a solução.  

## Modelos Existentes

No diretório `data/existing_models` você encontrará os modelos SQL atuais que precisam ser refatorados:

- `brand_performance.sql`: Análise de desempenho por marca
- `customer_orders.sql`: Informações de clientes e pedidos
- `daily_sales.sql`: Análise de vendas diárias
- `product_sales.sql`: Análise de vendas por produto

Esses modelos apresentam os problemas mencionados acima e precisam ser redesenhados seguindo as melhores práticas de modelagem de dados.

## Opções de Implementação

Você pode escolher uma das seguintes abordagens:

### Opção 1: Implementação com dbt
Se você estiver familiarizado com dbt, implemente sua solução como um projeto dbt. Configure modelos, testes e documentação seguindo as melhores práticas do dbt. Um template de projeto dbt já está disponível no diretório `dbt_project_template`.

### Opção 2: Scripts SQL
Se preferir não usar dbt, organize sua solução como um conjunto de scripts SQL com documentação clara sobre a ordem de execução e dependências. Um guia para esta abordagem está disponível em `NON_DBT_IMPLEMENTATION_GUIDE.md`.

## Entrega

Por favor, envie sua solução:

1. Fazendo um fork deste repositório
2. Implementando sua solução
3. Compartilhando o link do seu repositório (que deve estar público para que tenhâmos acesso)

Sua submissão deve incluir:

- Scripts SQL para transformação de dados (ou modelos dbt, se você escolher essa abordagem)
- Documentação da sua solução (no README ou em arquivos markdown separados)
- [Opcional] Quaisquer diagramas ou recursos visuais que ajudem a explicar sua arquitetura

## Critérios de Avaliação

Sua solução será avaliada com base em:

- **Design de Arquitetura**: Quão bem você estruturou o modelo de dados e as camadas
- **Eficiência SQL**: O desempenho e legibilidade de suas transformações
- **Documentação**: Clareza e completude de sua documentação
- **Resolução de Problemas**: Sua abordagem para resolver os problemas identificados
- **Escalabilidade**: Quão bem sua solução lidaria com volumes crescentes de dados

## Tempo Esperado

Você tem **72 horas** a partir do recebimento para enviar sua solução.  

## Problemas Específicos a Serem Resolvidos

Ao analisar os modelos existentes, observe que:

1. **Não há clara separação em camadas**: Os modelos acessam diretamente tabelas brutas sem passar por camadas intermediárias.

2. **Joins ineficientes**: Alguns modelos usam múltiplos joins desnecessários ou em ordem subótima.

3. **Cálculos redundantes**: Muitos cálculos são repetidos em diferentes modelos.

4. **Inconsistência de nomes**: Diferentes convenções de nomenclatura são usadas em todo o código.

5. **Falta de testes**: Não há validação de dados ou testes para garantir a qualidade.

## Dicas

- Comece analisando cada modelo existente para entender seu propósito e identificar problemas específicos.
- Planeje sua arquitetura em camadas antes de começar a codificar.
- Considere como diferentes modelos podem compartilhar lógica comum.
- Documente suas decisões de design e por que você escolheu implementar de determinada maneira.
- Não se esqueça de incluir testes para validar seus modelos.

---

Boa sorte! Se tiver alguma dúvida, não hesite em perguntar.
