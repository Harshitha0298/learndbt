{% set fruits = ["apple","plum","banana", "orange"] %}

{% for fruit in fruits %}
    {%if fruit!="plum"%}
        {{ fruit }}
    {%else%}
        I hate {{fruit}}
    {%endif%}
{% endfor %}