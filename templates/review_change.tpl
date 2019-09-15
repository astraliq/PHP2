<div class="review">
	<span class="review_titles review_name">{{NAME}}</span>
	<span class="review_titles review_rate">Оценка: {{RATE}}</span>
	<!-- <span class="review_titles review_comment_title"></span> -->
	<p class="review_comment"><b>Комментарий:</b></p>
	<form method="POST" class="review_change_form">
		<textarea name="comment" class="review_titles review_change">{{COMMENT}}</textarea>
		<input type="text" value="{{NAME}}" hidden name="name">
		<input type="text" value="update" hidden name="action">
		<input type="text" value="{{ID}}" hidden name="id">
		<input type="submit" value="Сохранить" class="review_change_save">
		<a href="/contacts/" class="review_action">Отменить</a>
	</form>
</div>
<hr>