Vue.component('search', {
	data() {
		return {
			searchLine: '',
		}
	},
    template: `<form action="#" class="search_div" @submit.prevent="$parent.$refs.products.filterGoods(searchLine,'submit')">
				<input type="text" class="searchline" placeholder="Искать..." v-model="searchLine" @keyup="$parent.$refs.products.filterGoods(searchLine)">
				<button class="searchline_btn" type="submit">Найти</button>
			</form>`

});			


