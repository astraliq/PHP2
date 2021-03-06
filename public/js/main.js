"use strict"

const app = new Vue({
	el : '#app' ,

	methods : {
		getJson(url, data) {
			return fetch(url, {
				method: 'POST',
				body: data
			})
				.then ( result => result.json())
				.catch( error => console.log('Ошибка запроса: ' + error.message + error))
		},
		postJson(url, data){
            return fetch(url, {
                method: 'POST',
                body: data
            })
                .then(result => result.json())
                .catch(error => {
                    this.$refs.error.setError(error);
                    console.log(error)
                })
        },
		putJson(url, data){
            return fetch(url, {
                method: 'POST',
                body: data
            })
                .then(result => result.json())
                .catch(error => {
                    this.$refs.error.setError(error);
                    console.log(error)
                })
        },
		deleteJson(url, data){
            return fetch(url, {
                method: 'POST',
				body: data
            })
                .then(result => result.json())
                .catch(error => {
                    this.$refs.error.setError(error);
                    console.log(error)
                })
        },
		displayCart() {
			this.$refs.cart.openCloseBusket();
		}
	}	
});

//Функция AJAX авторизации
function login() {
	//Получаем input'ы логина и пароля
	const $login_input = $('[name="login"]');
	const $password_input = $('[name="password"]');

	//Получаем значение login и password
	const login = $login_input.val();
	const password = $password_input.val();

	//Инициализируем поле для сообщений
	const message_field = $('.message');

	//Вызываем функцию jQuery AJAX с методом POST
	//Передаем туда url где будет обрабатваться API
	//И data которое будет помещена в $_POST
	//success - вызывается при успешном ответе от сервера
	$.post({
		url: '/index.php',
		data: {
			apiMethod: 'login',
			postData: {
				login: login,
				password: password
			}
		},
		success: function (data) {
			//data приходят те данные, который прислал на сервер


			//Вариант с json
			// if(data.error) {
			// 	$message_field.text(data.error_text);
			// } else {
			// 	location.reload();
			// }

			//Вариан без json
			if (data.result === 'OK') {
				if (data.referrer === '/index.php?path=user/createorder') {
					return location.href = '/index.php?path=user/createorder';
				}
				document.location.reload(true);
			} else {
				message_field.text(data['error_text']);
			}
		}
	});
}


function registration() {
	//Получаем input'ы логина и пароля
	const $login_input = $('[name="login"]');
	const $password_input = $('[name="password"]');
	const $password_repeat_input = $('[name="password_repeat"]');
	//Получаем значение login и password
	const login = $login_input.val();
	const password = $password_input.val();
	const password_repeat = $password_repeat_input.val();
	//Инициализируем поле для сообщений
	const message_field = $('.message');

	//Вызываем функцию jQuery AJAX с методом POST
	//Передаем туда url где будет обрабатваться API
	//И data которое будет помещена в $_POST
	//success - вызывается при успешном ответе от сервера
	$.post({
		url: '/index.php',
		data: {
			apiMethod: 'reg',
			postData: {
				login: login,
				password: password,
				password_repeat: password_repeat
			}
		},
		success: function (data) {
			//data приходят те данные, который прислал на сервер
			//Вариант с json
			// if(data.error) {
			// 	$message_field.text(data.error_text);
			// } else {
			// 	location.reload();
			// }

			//Вариан без json
			if (data === 'OK') {
				message_field.text('');
				document.location.reload(true);
			} else {
				message_field.text(data['error_text']);
			}
		}
	});
}

function resetForm() {
	//Получаем input'ы логина и пароля
	let $login_input = $('[name="login"]');
	let $password_input = $('[name="password"]');
	let $password_repeat_input = $('[name="password_repeat"]');
	//Обнуляем значения
	$login_input.val('');
	$password_input.val('');
	if ($password_repeat_input) {
		$password_repeat_input.val('');
	}
}

function setOrderStatus(orderId) {
	const $newStatus = $(`#select_status_${orderId}`);
	const newStatus = $newStatus.val();
	console.log($newStatus);
	if (confirm(`Подтвердите изменение статуса заказа на "${$newStatus.find("option:selected").text()}"`)) {
		$.post({
			url: '/index.php',
			data: {
				apiMethod: 'changeOrderStatus',
				postData: {
					orderId: orderId,
					newStatus: newStatus
				}
			},
			success: function (data) {
				if (data === 'OK') {
					location.reload();
				} else {
					alert(data);
				}
			}
		});
	}
}

function changeOrderStatus(orderId, newStatus) {
	if (confirm("Подтвердите отмену заказа")) {
		$.post({
			url: '/index.php',
			data: {
				apiMethod: 'changeOrderStatus',
				postData: {
					orderId: orderId,
					newStatus: newStatus
				}
			},
			success: function (data) {
				if (data === 'OK') {
					location.reload();
				} else {
					alert(data);
				}
			}
		});
	}
}

function createOrder() {
	const $address = $('[name="address"]');
	const address = $address.val();
	const message_field = $('.message');
	
	$.post({
		url: '/index.php',
		data: {
			apiMethod: 'createOrder',
			postData: {
				address: address,
			}
		},
		success: function (data) {
			//data приходят те данные, который прислал на сервер
			if (data === 'OK') {
				message_field.text('');
				window.location.replace("/index.php?path=user/userprofile");
			} else {
				message_field.text(data['error_text']);
			}
		}
	});
}

function deleteOrder(orderId) {
	if (confirm("Подтвердите удаление заказа")) {
		$.post({
			url: '/index.php',
			data: {
				apiMethod: 'deleteOrder',
				postData: {
					orderId: orderId,
				}
			},
			success: function (data) {
				if (data === 'OK') {
					location.reload();
				} else {
					alert(data);
				}
			}
		});
	}
}

function addProduct() {
	const $title = $('[name="title"]');
	const $description = $('[name="description"]');
	const $price = $('[name="price"]');
	const $image = $('[name="image"]');
	//Получаем значение login и password
	const title = $title.val();
	const description = $description.val();
	const price = $price.val();
//	const image = $image.val();
	let image = document.getElementById("product_image").files[0];
	//Инициализируем поле для сообщений
	const message_field = $('.message');
	
	let formData = new FormData();
	formData.append('apiMethod', 'addProduct');
	formData.append('title', title);
	formData.append('description', description);
	formData.append('price', price);
	formData.append('image', image);
	
	$.ajax({
        url: '/index.php',
        type: 'POST',
        data: formData,
        cache: false,
        dataType: 'json',
        processData: false, // Не обрабатываем файлы (Don't process the files)
        contentType: false, // Так jQuery скажет серверу что это строковой запрос
		success: function (data) {
			if (data === 'OK') {
				message_field.text('');
				document.location.reload(true);
			} else {
				message_field.text(data['error_text']);
			}
		}
	});
}

function deleteProduct(productId) {
	if (confirm("Подтвердите удаление товара")) {
		$.post({
			url: '/index.php',
			data: {
				apiMethod: 'deleteProduct',
				postData: {
					productId: productId,
				}
			},
			success: function (data) {
				if (data === 'OK') {
					window.location.replace("/index.php?path=catalog");
				} else {
					alert(data);
				}
			}
		});
	}
}

function changeProduct(productId) {
	const $title = $('[name="title"]');
	const $description = $('[name="description"]');
	const $price = $('[name="price"]');
	const $image = $('[name="image"]');
	//Получаем значение login и password
	const title = $title.val();
	const description = $description.val();
	const price = $price.val();
//	const image = $image.val();
	let image = document.getElementById("product_image").files[0];
	//Инициализируем поле для сообщений
	const message_field = $('.message');
	
	let formData = new FormData();
	formData.append('apiMethod', 'changeProduct');
	formData.append('title', title);
	formData.append('description', description);
	formData.append('price', price);
	formData.append('image', image);
	formData.append('productId', productId);
	
	$.ajax({
        url: '/index.php',
        type: 'POST',
        data: formData,
        cache: false,
        dataType: 'json',
        processData: false, // Не обрабатываем файлы (Don't process the files)
        contentType: false, // Так jQuery скажет серверу что это строковой запрос
		success: function (data) {
			if (data === 'OK') {
				message_field.text('');
				document.location.reload(true);
			} else {
				message_field.text(data['error_text']);
			}
		}
	});
}

function changeUserMenu(currentBlock) {
	const blockOrders = $('.user_profile_block_orders');
	const blockHistory = $('.user_profile_block_history');
	const orderControl = $('.user_order_control');
	const historyControl = $('.user_history_control');
	if (currentBlock === 'orders') {
		orderControl.css("background-color", "rgba(154,206,222,0.4)");
		historyControl.css("background-color", "rgba(154,206,222,0)");
		blockOrders.show();
		blockHistory.hide();
	} else {
		historyControl.css("background-color", "rgba(154,206,222,0.4)");
		orderControl.css("background-color", "rgba(154,206,222,0)");
		blockHistory.css("border-radius", "20px");
		blockHistory.show();
		blockOrders.hide();
	}
}


