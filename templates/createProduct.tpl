<form enctype="multipart/form-data" action="" method="POST" id="add_prod_form">
	<div>
		<h4>Название: </h4> <input type="text" name="title" value="{{TITLE}}">
	</div>
	<div>
		<h4>Описание: </h4>
		<!-- для textarea значение по умолчанию выглядит так -->
		<textarea name="description" cols="30" rows="10">{{DESCRIPTION}}</textarea>
	</div>
	<div>
		<h5>Цена без учета скидок: </h5><input type="number" name="price" value="{{PRICE}}">
	</div>
	<div>
		<h5>Загрузить изображение товара: </h5><input name="image" id="product_image" type="file" />
		{{IMAGE}}
	</div>
	<p class="message"> </p>
	<button type="button" class="submit_btn" onclick="{{METHOD}}" id="submit_btn">{{BTNNAME}}</button>
	<!-- <div>
		<input type="submit">
	</div> -->
</form>
