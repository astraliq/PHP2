<h3>Заказ #{{ID}}</h3>
{{USERID}}
<div>{{BUTTONS}}</div>
<div>Статус заказ: {{STATUS}}</div>
<table class="cartTable">
	<thead>
	<tr>
		<td>Название</td>
		<td>Стоимость</td>
		<td>Количество</td>
		<td>Сумма</td>
	</tr>
	</thead>
	<tbody>
	{{CONTENT}}
	<tr>
		<td colspan="3">Итого</td>
		<td>{{SUM}}</td>

	</tr>
	</tbody>
</table>
<div><b>Адрес доставки:</b> {{ADDRESS}}</div>
<hr>

