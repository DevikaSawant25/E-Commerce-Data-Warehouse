{% macro sk_from(cols) -%}
  {{ dbt_utils.surrogate_key(cols) }}
{%- endmacro %}
