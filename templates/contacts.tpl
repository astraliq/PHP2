	<div class="container-fluid">
		<div class="content">
			<h3 id="text_make_feedback">Оставьте свой отзыв о работе нашего магазина</h3><br>
			<div class="feedback_reviews">	
				<div class="feedbackform">
					<form method="POST">
						<fieldset>
							<legend>Оставьте отзыв</legend>
							<span class="feedback_titles">Ваше имя: </span>
							<input type="text" placeholder="Имя" name="name"><br>
								<!-- Электронная почта: <input type="email" class="inputtext" placeholder="Email"><br> -->
								<!-- Ваш пол:<br>
								<label for="man">М</label> <input type="radio" name="pol" checked id="man">
								<label for="woman">Ж</label> <input type="radio" name="pol" id="woman"><br> -->
								<span class="feedback_titles">Оценка:</span>
								<div id="reviewStars-input">
								    <input id="star-4" type="radio" name="rate" value="5" />
								    <label title="Отлично" for="star-4"></label>

								    <input id="star-3" type="radio" name="rate" value="4" />
								    <label title="Хорошо" for="star-3"></label>

								    <input id="star-2" type="radio" name="rate" value="3" />
								    <label title="Пойдет" for="star-2"></label>

								    <input id="star-1" type="radio" name="rate" value="2" />
								    <label title="Плохо" for="star-1"></label>

								    <input id="star-0" type="radio" name="rate" value="1" />
								    <label title="Очень плохо" for="star-0"></label>
								</div>
								<br><br>
								<span class="feedback_titles">Комментарий:</span>
								<textarea name="comment" placeholder="Ваш магазин супер-пупер"></textarea><br>
								<div class="messages">{{MESSAGE}}</div><br>
								<input type="text" value="create" hidden name="action">
								<input type="submit" value="Отправить" class="input_mainform">
								<input type="reset" value="Очистить поля" class="input_mainform"></p>
						</fieldset>
					</form>
				</div>
				<div class="reviews_block">
					<h4>Отзывы</h4>
					<hr>
					{{REVIEWS}}
				</div>
			</div>
			<div class="contats">
				<h2>Контактная информация</h2>
				<table class="contact_table">
					<tr>
						<td><b>Телефоны:</b></td>
						<td>(8412) 12-34-56, 45-67-89</td>
					</tr>
					<tr>
						<td><b>Электронная почта:</b></td>
						<td>mail@allsmarts.com</td>
					</tr>
					<tr>
						<td><b>Адрес:</b></td>
						<td>г. Пенза, ул. Пушкина, 45</td>
					</tr>
				</table>

			</div>
			<div class="map">
				<h2>Где мы находимся</h2><br>
				<script type="text/javascript" charset="utf-8" async src="https://api-maps.yandex.ru/services/constructor/1.0/js/?um=constructor%3Ae1c941a71a870bbe8c8a2d044ad29c0fd2a1330993a4218453ab1c1ac99b68ae&amp;width=100%25&amp;height=374&amp;lang=ru_RU&amp;scroll=true"></script>
				<br>
			</div>
		</div>
	</div>