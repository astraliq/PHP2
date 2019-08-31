{% for img in imgList %}
	<div class="product-item">
		<a href="#modal{{loop.index}}" name="modal">
			<img class="basket_img" src="{{imglink}}{{img}}" alt="{{img}}" title="{{img}}">
		</a>
	</div>
	<div id="modal{{loop.index}}" class="modalwindow">
	    <!-- Заголовок модального окна -->
	    <h2 class="modal_title">Картинка №{{loop.index}}</h2>
	    <!-- кнопка закрытия окна определяется как класс close -->
	    <a href="#" class="close">X</a>
	    <div class="content">
	        <img src="{{imglink}}{{img}}" alt="{{img}}" title="{{img}}" class="modal_img">
		</div>
	</div>
{% endfor %}