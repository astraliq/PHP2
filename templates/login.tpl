	<div class="container-fluid">
		<div class="content">
			<div class="form_login_block">
				<div class="data_block">
				<!-- 	<div class="data_block-block">
						<label for="login">Логин / E-mail:</label>
						<input class="data_block-input" type="login" placeholder="Логин / Электронная почта" id="login" name="login" required>
						<label for="pass">Пароль:</label>
						<input class="data_block-input" type="password" placeholder="Пароль" id="pass" name="password" required>
					</div> -->
					<div class="form-group">
						<label for="login">Логин / E-mail:</label>
						<input type="login" class="form-control" id="login" aria-describedby="emailHelp" placeholder="Логин / Электронная почта" name="login" required>
					</div>
					<div class="form-group">
						<label for="pass">Пароль: </label>
						<input type="password" class="form-control" id="pass" placeholder="Пароль" name="password" required>
					</div>
				</div>
				<p class="message"></p>
				<button class="btn-lg" onclick="login()">войти</button>
				<!-- <input class="submit" type="submit" id="submit" value="войти"> -->
				<button class="btn-lg" onclick="resetForm()">очистить</button>
			</div>
		</div>
	</div>