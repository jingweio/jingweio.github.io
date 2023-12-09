---
layout: page
permalink: /publications/
title: Publications
description: An up-to-date list is available on <a href='https://scholar.google.com/citations?hl=en&user=5qlAKK0AAAAJ&view_op=list_works&sortby=pubdate'>Google Scholar</a>.
# preprint_years: [2024, 2022]
preprint_years: [2022]
paper_years: [2024, 2023, 2022, 2021, 2016]
nav: true
nav_order: 2
---
<!-- _pages/publications.md -->

<div class="publications">
    <div class="preprints">
        <h2>Preprints</h2>
        {%- for y in page.preprint_years %}
            <h2 class="year" style="font-size: 40px;">{{y}}</h2>
            {% bibliography -f preprints -q @*[year={{y}}]* %}
        {% endfor %}
    </div>
    <div class="conferences-journals">
        <h2>Conferences and Journals</h2>
        {%- for y in page.paper_years %}
            <h2 class="year" style="font-size: 40px;">{{y}}</h2>
            {% bibliography -f papers -q @*[year={{y}}]* %}
        {% endfor %}
    </div>
</div>
