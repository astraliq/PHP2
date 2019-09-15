<tr class="basket-item-row">
	<td class="number"> {{ key + 1 }} </td>
	<td class="basket-items_id"> {{ cartItem.id}} </td>
	<td class="basket-items_img"><img src="/img/img_phones/{{ cartItem.img }}" alt="phone" height="80"></td>
	<td class="basket-items_name"> {{ cartItem.title }} </td>
	<td class="basket-items_price">
		<span class="item_prcice"> {{ cartItem.price }} </span> руб.
	</td>
	<td class="basket-items_count">
		<span class="basket-items_input_count" > {{ cartItem.quantity}} </span>
		<!-- <button class="btn-cart-count" type="button" disabled>+</button> -->
		<!-- <button class="btn-cart-count" type="button" disabled>-</button> -->
	</td>
	<!-- <td class="basket-items_del">+</td> -->
</tr>