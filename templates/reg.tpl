	<div class="container-fluid">
		<div class="content">
			<div class="form_login_block">
				<div class="data_block">
					<div class="data_block-block">
						<!-- <label for="login">Логин / E-mail:</label>
						<input class="data_block-input" type="login" placeholder="Логин / Электронная почта" id="login" name="login" min="3" max="35" required>
						<label for="password">Пароль:</label>
						<input class="data_block-input" type="password" placeholder="Пароль" id="password" name="password" min="4" required>
						<label for="password_repeat">Повтор пароля:</label>
						<input class="data_block-input" type="password" placeholder="Повторите пароль" id="password_repeat" name="password_repeat" required> -->

						<div class="form-group">
							<label for="login">Логин / E-mail:</label>
							<input type="login" class="form-control" id="login" aria-describedby="emailHelp" placeholder="Логин / Электронная почта" name="login"  min="3" max="35" required>
						</div>
						<div class="form-group">
							<label for="pass">Пароль: </label>
							<input type="password" class="form-control" id="pass" placeholder="Пароль" name="password" min="4" required>
						</div>
						<div class="form-group">
							<label for="password_repeat">Повтор пароля: </label>
							<input type="password" class="form-control" id="password_repeat" placeholder="Повторите пароль" name="password_repeat" min="4" required>
						</div>
					</div>
				</div>
				<p class="message"></p>
				<button class="btn-lg" onclick="registration()">зарегистрироваться</button>
				<button class="btn-lg" onclick="resetForm()">очистить</button>
			</div>
		</div>
	</div>