<!DOCTYPE html>
<html lang="ru">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<link rel="stylesheet" href="../css/bootstrap.min.css">


	<link rel="stylesheet" href="../css/style.css" type="text/css">
	<!-- <link rel="stylesheet" href="../css/forms.css" type="text/css"> -->
	<title>{{MAINTITLE}}</title>

	<style>
		body {
			background-color: #f8f8f8;
			background-image: url(../img/background.png);
			background-repeat: no-repeat;
			background-size: cover;
		}
	</style>

</head>

<body>
	<div id="app">
	<header>
		{{HEAD}}
		<a href="/" class="logo" id="up"><img src="../img/logo.png" alt="logo"></a>
		<!-- <ul class="menu">
			<li><a href="/">Главная</a></li>
			<li><a href="catalog.php">Каталог&nbsp;&nbsp;<i class="icon">&#xf0c9;</i></a>
				<ul class="menu2">
					<li><a href="phone1.html">Lumia 650</a></li>
					<li><a href="phone2.html">Xiaomi Mi8</a></li>
					<li><a href="phone3.html">iPhone X</a></li>
				</ul>
			</li>
			<li><a href="delivery.php">Доставка и оплата</a></li>
			<li><a href="contacts.php">Контакты</a></li>
		</ul> -->
		{{MENU}}
		<button class="btn-cart" type="button" @click="displayCart">Корзина</button>
		<cart ref="cart"></cart>
	</header>
	<h2 class="all_titles">{{TITLE}}</h2><br>
		{{CONTENT}}
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
	
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/vue@2.6.10/dist/vue.js"></script>
	<script type="text/javascript" src="{{LINKUPDIR}}js/GetData.js"></script>
	<script type="text/javascript" src="{{LINKUPDIR}}js/CartComp.js"></script>
    <script type="text/javascript" src="{{LINKUPDIR}}js/ProdComp.js"></script>
	<script type="text/javascript" src="{{LINKUPDIR}}js/SearchComp.js"></script>
	<script type="text/javascript" src="{{LINKUPDIR}}js/main.js"></script>
	<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script> -->
	<script type="text/javascript" src="/js/jquery-3.4.1.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
	<script type="text/javascript" src="/js/modal.js"></script>

</body>
</html>
