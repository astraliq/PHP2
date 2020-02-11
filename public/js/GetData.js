Vue.component('getdatalist', {
	props: ['productid'],
	data() {
		return {
			products: [],
		}
	},
	mounted() {
		let formData = new FormData();
			formData.append('apiMethod', 'getProduct');
			formData.append('productId', this.productid);
			this.$parent.getJson(`/index.php`, formData)
				.then(data => {
					this.products.push(data);
				});
	},
	methods: {
		getProduct(id) {
			let formData = new FormData();
			formData.append('apiMethod', 'getProduct');
			formData.append('productId', id);
			this.$parent.getJson(`/index.php`, formData)
				.then(data => {
					this.products.push(data);
					return data;
				});
		},
	},
    template: ` `
});

//export default getdatalist