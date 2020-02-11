<div class="container-fluid">
	{%if user == 'admin' %}
		<a class='btn' href='index.php?path=catalog/change/{{ content.id }}'>Изменить товар</a>
		<a class='btn' onclick='deleteProduct({{ content.id }})'>Удалить товар</a>
	{% endif %}
	<div class="content" id="content_of_items">
		<div class="shortspec_margin">
			<h3 class="titles" id="first_title">Описание товара</h3><br>
			<a href="/img/img_phones/{{ content.img }}" target="_blank" class="item_main_img"><img src="/img/img_phones/{{ content.img }}" alt="{{ content.title }}"></a>
			<p class="description">
				{% if content.description is empty %}
				    Описание отсутствует
				{% else %}
					{{ content.description|nl2br }}
				{% endif %}
			</p>
		</div>
		<getdatalist ref="getdatalist" :productid="{{ content.id }}"></getdatalist>
		<button class="in_basket" type="button" @click="$root.$refs.cart.addProduct($root.$refs.getdatalist.products[0])">Купить</button>
<!-- 		<div class="specification_margin">
			<h3 class="titles">Характеристики товара</h3><br>
			<a href="../img/2.jpg" target="_blank" class="item_img"><img src="../img/2.jpg" alt="phone"></a><br>

			<ul class="spcn">
				<li>смартфон с&nbsp;MS&nbsp;Windows&nbsp;10 Mobile</li>
				<li>экран&nbsp;5&Prime;, разрешение 1280&times;720</li>
				<li>камера 8&nbsp;МП, автофокус, F/2.2</li>
				<li>память 16&nbsp;Гб, слот для карты памяти</li>
				<li>3G, 4G&nbsp;LTE, Wi-Fi, Bluetooth, NFC, GPS, ГЛОНАСС</li>
				<li>объем оперативной памяти 1&nbsp;Гб</li>
				<li>аккумулятор 2000 мА&sdot;ч</li>
				<li>вес 122&nbsp;г, ШxВxТ 70.90&times;142&times;6.90&nbsp;мм</li>
			</ul>
		</div> -->
		<br>
		<!-- <div><a href="edit_item.php?id={{IMGID}}" class="page_turn">Редактировать описание товара</a></div> -->
		<br>
	</div>
</div>
	