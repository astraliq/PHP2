<!DOCTYPE html>
<html lang="ru">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<link rel="stylesheet" href="../css/bootstrap.min.css">


	<link rel="stylesheet" href="../css/style.css" type="text/css">
	<title>{{mainTitle}}</title>

	<style>
		html,
		body {
			height: 100%;
		}

		body {
			background-color: #f8f8f8;
			background-image: url(../img/background.png);
			background-repeat: no-repeat;
			background-size: cover;
		}

		.container-fluid {
			min-height: 100%;
		}
	</style>

</head>

<body>
	<header>
<!-- 		<div class="head">
			<i class="icon">&#xe800;</i><a href="#">Вход</a>
			<i class="icon">&#xe801;</i><a href="#">Регистрация</a>
			<a href="#"><i class="icon">&#xf0c9;</i></a>
		</div>
		<a href="/" class="logo"><img src="../img/logo.png" alt="logo"></a>
		<ul class="menu">
			<li><a href="../">Главная</a></li>
			<li><a href="catalog.html">Каталог&nbsp;&nbsp;<i class="icon">&#xf0c9;</i></a>
				<ul class="menu2">
					<li><a href="phone1.html">Lumia 650</a></li>
					<li><a href="phone2.html">Xiaomi Mi8</a></li>
					<li><a href="phone3.html">iPhone X</a></li>
				</ul>
			</li>
			<li><a href="delivery.html">Доставка и оплата</a></li>
			<li><a href="#">Контакты</a></li>
		</ul>
		<ul class="menu-md">
			<li><a href="#">Вход</a></li>
			<li><a href="#">Регистрация</a></li>
		</ul> -->
	</header>
	<main id="content_of_items">
		<h2 class="main_gallery all_titles">{{title}}</h2><br>
		{% include 'gallery.tpl' %}

		<br><br><br>
	</main>
</div>
	<div class="footer">
		<a href="#up"><img src="../img/upar_nowm.png" height="50" alt="Наверх" title="Наверх"></a>
		<div class="footer_center">
			<img class="footer_logo" src="../img/logo2.png" alt="logo">
			<a href="#"><i class="icon footer_icon">&#xf09a;</i></a>
			<a href="#"><i class="icon footer_icon">&#xf189;</i></a>
			<a href="#"><i class="icon footer_icon">&#xf099;</i></a>
			<a href="#"><i class="icon footer_icon">&#xf16d;</i></a>
		</div>
		<p>Все&nbsp;права&nbsp;защищены &copy;&nbsp;2019&nbsp;&copy; All&nbsp;rights&nbsp;reserved
			<br><a href="https://geekbrains.ru" target="_blank">Geekbrains</a></p>
	</div>
	<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script> -->
	<script type="text/javascript" src="/js/jquery-3.4.1.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
	<script type="text/javascript" src="/js/modal.js"></script>
</body>
</html>
