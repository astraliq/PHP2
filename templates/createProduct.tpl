<form enctype="multipart/form-data" action="" method="POST" id="add_prod_form">
	<div>
		<h4>Название: </h4> <input type="text" name="title" value="{{ content.product.title }}">
	</div>
	<div>
		<h4>Описание: </h4>
		<!-- для textarea значение по умолчанию выглядит так -->
		<textarea name="description" cols="30" rows="20">{{ content.product.description }}</textarea>
	</div>
	<div>
		<h5>Цена без учета скидок: </h5><input type="number" name="price" value="{{ content.product.price }}">
	</div>
	<div>
		<h5>Загрузить изображение товара: </h5><input name="image" id="product_image" type="file" />
		{% if content.product.img is not null %}
			<h5>Текущее изображение</h5><img src='/img/img_phones/{{ content.product.img }}' height='150' width='150' class='basket_img'>
		{% endif %}
	</div>
	<p class="message"> </p>
	<button type="button" class="submit_btn" onclick="
		{% if content.method == 'add' %}
			addProduct()
		{% else %}
			{{ 'changeProduct(' ~ content.product.id ~ ')'}}
		{% endif %} " id="submit_btn">{{ content.button }}</button>
	<!-- <div>
		<input type="submit">
	</div> -->
</form>
