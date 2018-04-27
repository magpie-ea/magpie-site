---
layout: reuse
title: Templates
section: reuse
---

# {{ page.title }}

Here is a bunch of templates.


{% for guide in site.data.reuse %}
{% for node in guide.templates %}
{% include_relative templates/{{node.slug}}.md %}
{% endfor %}
{% endfor %}


