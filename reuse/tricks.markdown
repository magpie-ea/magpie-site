---
layout: reuse
title: Tricks & hacks
section: reuse
---

# {{ page.title }}

Here is a bunch of tricks.


{% for guide in site.data.reuse %}
{% for node in guide.tricks %}
{% include_relative tricks/{{node.slug}}.md %}
{% endfor %}
{% endfor %}
