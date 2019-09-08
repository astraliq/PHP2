	<div class="container-fluid">
		<div class="content">
			<div class="data_block">
				<div class="data_block-block">
					<label for="login">Логин / E-mail:</label>
					<input class="data_block-input" type="login" placeholder="Логин / Электронная почта" id="login" name="login" min="3" max="35" required>
					<label for="password">Пароль:</label>
					<input class="data_block-input" type="password" placeholder="Пароль" id="password" name="password" min="4" required>
					<label for="password_repeat">Повтор пароля:</label>
					<input class="data_block-input" type="password" placeholder="Повторите пароль" id="password_repeat" name="password_repeat" required>
				</div>
			</div>
			<p class="message"></p>
			<button class="submit_btn" onclick="registration()">зарегистрироваться</button>
			<button class="reset" onclick="resetForm()">очистить</button>
		</div>
	</div>