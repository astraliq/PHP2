	<div class="container-fluid">
		<div class="content">
			<div class="order">
				<h2 class="basket_name">Содержимое корзины</h2>
				<table class="basket-items">
					<tbody class="basket-items_header">
						<tr class="basket-header">
							<td class="basket-items_number basket-items-header">№</td>
							<td class="basket-items_id basket-items-header">id</td>
							<td class="basket-items_img basket-items-header">изображение товара</td>
							<td class="basket-items_name basket-items-header">наименование</td>
							<td class="basket-items_price basket-items-header">цена</td>
							<td class="basket-items_count basket-items-header">кол-во</td>
							<td class="basket-items_last_cell"> </td>
						</tr>
					</tbody>
				</table>
				<div class="basket-items_div_order">
					<table class="basket-items">
						<tbody class="basket-items_block">
							{% for key,cartItem in content %}
								{% include 'orderList.tpl' %}
							{% endfor %}
						</tbody>
					</table>
					<div class="order_data">	
						<span>Адрес доставки: </span>
						<input type="text" placeholder="имя" name="name" id="delivery_name">
						<input type="text" placeholder="телефон" name="phone" id="delivery_phone">
						<input type="text" placeholder="адрес доставки" name="address" id="delivery_address">
					</div>
				</div>
				<table class="basket-items">
					<tbody class="basket-items_footer">
						<tr class="basket-last-row">
							<td class="basket-items_reset">
							<button class="btn-cart-reset btn-cart-order" onclick="createOrder()">Заказать</button>
							</td>
							<td class="basket-items_price basket_total_price"><b>Итого:</b>
							{% set sum = 0 %} 
							{% for cartItem in content %}
								{% set sum = cartItem.price * cartItem.quantity + sum %} 
							{% endfor %}
							{{ sum }} руб.</td>
						</tr>
					</tbody>
				</table>
			</div>
			<p class="message"></p>
		</div>
	</div>