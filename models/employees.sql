
with calc_employees as (
    select 
    EXTRACT(YEAR FROM current_date) - EXTRACT(YEAR FROM birth_date) age, -- caluclar idade em no ano atual (2024)
    EXTRACT(YEAR FROM current_date) - EXTRACT(YEAR FROM hire_date) lengthofservice, -- calcular tempo de servico
    first_name || ' ' || last_name name, -- juntar nome e sobrenome
    * -- pega todas as outras colunas
    from {{source('sources','employees')}}
)

select * from calc_employees