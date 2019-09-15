Vue.component('getdatalist', {
	data() {
		return {
			products: [],
		}
	},
	mounted() {
		this.$parent.getJson(`/api/products`)
			.then(data => {
				for (let elem of data) {
					this.products.push(elem);
				}
			});
	},
	methods: {
		getProduct(id) {
			console.log(this.products[id]);
			return this.products[id];
		},
	},
    template: ` `
});

//export default getdatalist