```
+---------------------+      +---------------------+      +---------------------+
|    Dados Brutos     |      |   Modelos Atuais    |      |     Usuário Final   |
+---------------------+      +---------------------+      +---------------------+
|                     |      |                     |      |                     |
| - brands.csv        |----->| - brand_performance |----->| - Dashboards        |
| - customers.csv     |----->| - customer_orders   |----->| - Relatórios        |
| - orders.csv        |----->| - daily_sales       |----->| - Análises ad-hoc   |
| - order_items.csv   |----->| - product_sales     |----->|                     |
| - products.csv      |      |                     |      |                     |
| - product_           |      |                     |      |                     |
|   categories.csv    |      |                     |      |                     |
|                     |      |                     |      |                     |
+---------------------+      +---------------------+      +---------------------+

Problemas na Arquitetura Atual:
- Não há camadas intermediárias (staging, intermediate)
- Junções diretas entre tabelas brutas e modelos de relatório
- Múltiplos cálculos redundantes em diferentes modelos
- Inconsistência de nomenclatura
- Ausência de testes e documentação
- Modelos que misturam diferentes níveis de granularidade
```
