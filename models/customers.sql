-- Arquivo 01 - customer model
-- Objetivo: criar nova tabela 'customers' sesm registros duplicados de company_name, contact_name

-- Etapa 1 - Usamos WINDOWS FUNCTIONS para adicionar uma coluna que vai ter valor
with markup as (
    select * , 
    first_value(customer_id)
    over(
        partition by company_name, contact_name -- vou particionar por essa colunas
        order by company_name -- ordenar pelo nome, nesse caso, é totalmente opcional
        rows between unbounded preceding and unbounded following -- A windows vai começar na 1° janela da particao
    ) as result
    from {{source('sources','customers')}}
), removed as (
    select distinct result from markup
), final as (
    select * from {{source('sources','customers')}} where customer_id in (select result from removed)
)

select * from final
-- Antes eram 94 linhas, ao final, deverá ser 91 linhas. Ou seja, 3 registro foram removidos