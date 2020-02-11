<main id="content_of_items">
	{%if user == 'admin' %}
		<a href="index.php?path=catalog/add">Добавить товар в каталог</a>
	{% endif %}
	<div class="products">
		{{ content.productsFromVue|raw }}
	</div>
</main>

