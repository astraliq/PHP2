Vue.component('products', {
	data() {
		return {
			products: [],
			filteredProducts: [],
//			catalogURL: '/catalog.json',
			searchKeys: 0,
			numberOfLoadProducts: 25
		}
	},
	mounted() {
		let formData = new FormData();
		formData.append('apiMethod', 'readCatalog');
		formData.append('numberOfLoadProducts', this.numberOfLoadProducts);
		this.$parent.getJson(`/index.php`, formData)
			.then(data => {
				for (let elem of data) {
					this.products.push(elem);
					this.filteredProducts.push(elem);
				}
			});
	},
	methods: {
		filterGoods(value, type) {
			const regexp = new RegExp (value, 'i' );
			if(type == 'submit') {
				this.filteredProducts = this.products.filter(product =>
				regexp.test(product.title));
			} else if (value.length < 1){
				this.filteredProducts = this.products;
			}
			this.searchKeys = value.length;
		},
		loadMore (lastNumberOfProd) {
			let formData = new FormData();
				formData.append('apiMethod', 'loadMore');
				formData.append('lastNumberOfProd', lastNumberOfProd);
				formData.append('numberOfLoadProducts', this.numberOfLoadProducts);
				this.$parent.getJson(`/index.php`, formData)
                    .then(data => {
						for (let elem of data) {
							this.products.push(elem);
							this.filteredProducts.push(elem);
						}
                    })
		}
	},
    template: `<div class="products">
				<stub v-if="!products.length"></stub>
				<product v-for="(product, index) of filteredProducts" :key="index" :product="product"></product>
				<load_more :products="products" :numberOfLoadProducts="numberOfLoadProducts"></load_more>
			</div>`
});

Vue.component('product', {
    props: ['product'],
    template: `<div class="product-item">
					<h3 class="product-item-h3"> <a :href="'index.php?path=catalog/show/' + product.id">{{ product.title }}</a> </h3>
					<img class="basket_img" :src="'/img/img_phones/' + product.img" :alt="product.title" :title="product.title">
					<span class="product-item-price">  {{ product.price }}  руб.</span>
					<button class="in_basket" :id="product.id" :data-title="product.title" :data-price="product.price" @click="$root.$refs.cart.addProduct(product)">В корзину</button>
				</div>`
})

Vue.component('stub', {
    props: [],
    template: `<div class="stub">
					<div id="fountainG">
					<div id="fountainG_1" class="fountainG"></div>
					<div id="fountainG_2" class="fountainG"></div>
					<div id="fountainG_3" class="fountainG"></div>
					<div id="fountainG_4" class="fountainG"></div>
					<div id="fountainG_5" class="fountainG"></div>
					<div id="fountainG_6" class="fountainG"></div>
					<div id="fountainG_7" class="fountainG"></div>
					<div id="fountainG_8" class="fountainG"></div>
				</div>
				</div>`
})

Vue.component('load_more', {
    props: ['products', 'numberOfLoadProducts'],
    template: `<div class="load_block">
					<button class="load_more" :data-length="products.length" @click="$root.$refs.products.loadMore(products.length)">загрузить еще {{ numberOfLoadProducts }}</button>
				</div>`
})