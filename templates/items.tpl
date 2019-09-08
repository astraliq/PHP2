<div class="product-item">
	<a href="item.php?id={{IMGID}}">
		<h3 class="product-item-h3"> {{NAME}} </h3>
	</a>
	<a href="#modal{{IMGID}}" name="modal"><img class="basket_img" src="{{IMG}}" alt="{{ALT}}" title="{{NAME}}"></a>
	
	<span class="product-item-price">  {{PRICE}}  руб.</span>
	<!-- <button class="in_basket" :id="product.id" :data-title="product.title" :data-price="product.price" @click="$root.$refs.cart.addProduct(product)">В корзину</button> -->
</div>
<div id="modal{{IMGID}}" class="modalwindow">
    <!-- Заголовок модального окна -->
    <h2 class="modal_title">{{NAME}}</h2>
    <!-- кнопка закрытия окна определяется как класс close -->
    <a href="#" class="close">X</a>
    <div class="content_modal">
        <img src="{{IMG}}" alt="{{ALT}}" title="{{IMGTITLE}}" class="modal_img">
	</div>
</div>