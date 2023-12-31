/* Using dbt_utils to create a sequence of days. */
with date_series as (
           {{ dbt_utils.date_spine(
                datepart="day",
                start_date= "cast('2011-01-01' as date)", 
                end_date="cast('2014-12-31' as date)"
           )
           }}
    )

/* Creating necessary columns to use in PowerBI. */
, date_columns as (
    select distinct
        date(date_day) as metric_date
	    , extract(day from date_day) as day
        , extract(month from date_day) as month
        , extract(year from date_day) as year
        , extract(quarter from date_day) as quarter
    from date_series
)

, month_columns as (
    select
    	*
		, case
            when month = 1 then 'Jan'
            when month = 2 then 'Fev'
            when month = 3 then 'Mar'
            when month = 4 then 'Abr'
            when month = 5 then 'Mai'
            when month = 6 then 'Jun'
            when month = 7 then 'Jul'
            when month = 8 then 'Ago'
            when month = 9 then 'Set'
            when month = 10 then 'Out'
            when month = 11 then 'Nov'
            when month = 12 then 'Dez'
        end as full_month
        , case
            when quarter = 1 then 'Q1'
            when quarter = 2 then 'Q2'
            when quarter = 3 then 'Q3'
            when quarter = 4 then 'Q4'
        end as full_quarter
    from date_columns
)

, transformed as (
    select 
        *
        , concat(full_month, '-', cast(year as string)) as month_year
    from month_columns
)

select *
from transformed
