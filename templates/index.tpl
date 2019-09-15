<!DOCTYPE html>
<html lang="ru">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<link rel="stylesheet" href="../css/bootstrap.min.css">


	<link rel="stylesheet" href="../css/style.css" type="text/css">
	<!-- <link rel="stylesheet" href="../css/forms.css" type="text/css"> -->
	<title>{{ mainTitle }}</title>

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
		{%if userCheck %}			
			{% include 'head_login.tpl' %}				
		{% else %}						
			{% include 'head.tpl' %}						
		{% endif %}	

		<a href="/" class="logo" id="up"><img src="../img/logo.png" alt="logo"></a>
		{{ menu|raw }}
		<button class="btn-cart" type="button" @click="displayCart">Корзина</button>
		<cart ref="cart"></cart>
	</header>
	<h2 class="all_titles">{{ title }}</h2><br>
	{% include pagename~'.tpl' %}
	</div>
	{% include 'footer.tpl' %}
	
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
