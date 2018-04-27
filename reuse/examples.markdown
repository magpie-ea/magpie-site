---
layout: reuse
title: Full example experiments
section: reuse
---

# {{ page.title }}

Here is a bunch of examples.

{% for guide in site.data.reuse %}
{% for node in guide.examples %}
{% include_relative examples/{{node.slug}}.md %}
{% endfor %}
{% endfor %}
