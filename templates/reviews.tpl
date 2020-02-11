<div class="review">
	<span class="review_titles review_name">{{ review.name }}</span>
	<span class="review_titles review_rate">Оценка: {{ review.rate }}</span>
	<!-- <span class="review_titles review_comment_title"></span> -->
	<p class="review_comment"><b>Комментарий:</b> {{ review.comment }}</p>
	<span class="review_titles review_date">Дата: {{ review.date }}</span>
	{%if user == 'admin' %}
		<a href="index.php?action=change&id={{ review.id }}" class="review_action">Изменить</a>
		<a href="index.php?action=delete&id={{ review.id }}" class="review_action">Удалить</a>
	{% endif %}
</div>
<hr>