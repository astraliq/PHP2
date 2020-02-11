<div class="user_content">
	<div class="user_menu_block">	
		<div class="user_order_control" style="background-color: rgba(154,206,222,0.4);">
			<button class="user_menu_btn" onclick="changeUserMenu('orders')">{{ content.btn_order_name }}</button>
		</div>
		<div class="user_history_control">
			<button class="user_menu_btn" onclick="changeUserMenu('history')">История посещения</button>
		</div>
		
	</div>
	<div class="user_profile_block_orders">
		{%if content.orders == null %}			
			<p>Вы еще ничего не заказали ;)</p>	
			<a href="/index.php?path=catalog">Перейти в каталог</a>		
		{% endif %}	
		{% for key,order in content.orders %}
			{% include 'orderTable.tpl' %}
		{% endfor %}

	</div>
	<div class="user_profile_block_history" style="display: none;">
		<table class="history_table">
			<thead>
			<tr>
				<td>№ п/п</td>
				<td>Страница</td>
				<td>Дата посещения</td>
			</tr>
			</thead>
			<tbody>
				{% for key,historyRecord in content.history %}
					<tr data-id="{{ historyRecord.id }}">
						<td>{{ key + 1 }}</td>
						<td><a href="/{{ historyRecord.page }}" class="history_link">{{ historyRecord.page }}</a></td>
						<td>{{ historyRecord.date }}</td>
					</tr>
				{% endfor %}
			</tbody>
		</table>
	</div>
</div>