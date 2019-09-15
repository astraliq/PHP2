<div class="user_content">
	<div class="user_menu_block">	
		<button class="user_menu_btn" onclick="changeUserMenu('orders')">{{ title }}</button>
		<button class="user_menu_btn" onclick="changeUserMenu('history')">История посещения</button>
	</div>
	<div class="user_profile_block_orders">
		{% for key,order in content.orders %}
			{% include 'orderTable.tpl' %}
		{% endfor %}
	</div>
	<div class="user_profile_block_history" >
		{{ content.history }}
	</div>
</div>