{% macro get_sales_velocity(won_date, contact_date) %}
    DATE_DIFF(DATE({{ won_date }}), {{ contact_date }}, DAY)
{% endmacro %}