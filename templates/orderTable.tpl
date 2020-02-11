<h3>Заказ #{{ order.id }}</h3>
{%if user == 'admin' %}
	<h6>ID пользователя: {{ order.userID }}</h6>
{% endif %}
<div>
	{%if user == 'admin' %}
		<a class='btn' onclick='changeOrderStatus({{ order.id }}, 2)'>Отменить</a>
		<a class='btn' onclick='deleteOrder({{ order.id }})'>Удалить заказ</a>
		<a class='btn' onclick='setOrderStatus({{ order.id }})'>Изменить статус заказа на</a>
		<select id='select_status_{{ order.id }}'>
		  <option value='1' selected='selected'>Не обработан</option>
		  <option value='2'>Отменен</option>
		  <option value='3'>Оплачен</option>
		  <option value='4'>Доставлен</option>
		</select>
	{% elseif order.status == 1 %}
		<a class='btn' onclick='changeOrderStatus({{ order.id }}, 2)'>Отменить</a>
	{% endif %}
</div>
<div><b>Статус заказа:</b> {{ order.statusName }}</div>
<table class="cartTable orderTable">
	<thead>
	<tr>
		<td>Название</td>
		<td>Стоимость</td>
		<td>Количество</td>
		<td>Сумма</td>
	</tr>
	</thead>
	<tbody>
		{% set sum = 0 %} 
		{% for key,product in content.productsInOrders[order.id] %}
			{% include 'orderTableRow.tpl' %}
			{% set sum = product.price * product.quantity + sum %} 
		{% endfor %}
	<tr>
		<td colspan="3">Итого</td>
		<td>
			{{ sum }}
		</td>

	</tr>
	</tbody>
</table>
<div><b>Адрес доставки: </b>{{ order.address }}</div>
<hr>

