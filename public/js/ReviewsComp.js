Vue.component('reviews', {
	data() {
		return {
			reviews: [],
			filteredReviews: [],
//			catalogURL: '/catalog.json',
			searchKeys: 0,
			numberOfLoadReviews: 10,
			admin: false,
			changingReviewId: null
		}
	},
	mounted() {
		let formData = new FormData();
		formData.append('apiMethod', 'readReviews');
		formData.append('numberOfLoadReviews', this.numberOfLoadReviews);
		this.$parent.getJson(`/index.php`, formData)
			.then(data => {
				for (let elem of data.reviews) {
					this.reviews.push(elem);
					this.filteredReviews.push(elem);
				}
				this.admin = data.admin;
			});
	},
	methods: {
		filterReviews(value, type) {
			const regexp = new RegExp (value, 'i' );
			if(type == 'submit') {
				this.filteredReviews = this.reviews.filter(review =>
				regexp.test(review.title));
			} else if (value.length < 1){
				this.filteredReviews = this.reviews;
			}
			this.searchKeys = value.length;
		},
		loadMore(lastNumberOfRev) {
			let formData = new FormData();
				formData.append('apiMethod', 'loadMoreReviews');
				formData.append('lastNumberOfRev', lastNumberOfRev);
				formData.append('numberOfLoadReviews', this.numberOfLoadReviews);
				this.$parent.getJson(`/index.php`, formData)
                    .then(data => {
						for (let elem of data.reviews) {
							this.reviews.push(elem);
							this.filteredReviews.push(elem);
						}
						this.admin = data.admin;
                    })
		},
		
		saveReviewChanges(review) {
			let formData = new FormData();
				formData.append('apiMethod', 'changeReview');
				console.log(review);
				formData.append('reviewId', review.id);
				formData.append('reviewAuthor', review.name);
				formData.append('changedComment', review.changedComment);
				this.$parent.getJson(`/index.php`, formData)
                    .then(data => {
						if(data.result === 'OK') {
							let currentReviewIndex = this.filteredReviews.findIndex(rev => rev.id === review.id);
							this.filteredReviews[currentReviewIndex].comment = review.changedComment;
							this.admin = data.admin;
							this.changingReviewId = null;
						} else {
							alert('Ошибка!');
						}
                    })
		},
		
		changeReview(review) {
			let currentReviewIndex = this.filteredReviews.findIndex(rev => rev.id === review.id);
			this.changingReviewId = this.filteredReviews[currentReviewIndex].id;
			this.filteredReviews[currentReviewIndex]['changedComment'] = this.filteredReviews[currentReviewIndex].comment;
		},
		
		cancelChangingReview(review) {
			this.changingReviewId = null;
		},
		
		deleteReview(review) {
			if (confirm(`Подтвердите удаление отзыва пользователя "${review.name}"`)) {
				let formData = new FormData();
				formData.append('apiMethod', 'deleteReview');
				formData.append('reviewId', review.id);
				this.$parent.getJson(`/index.php`, formData)
                    .then(data => {
						if(data.result === 'OK'){
							let currentReviewIndex = this.filteredReviews.findIndex(rev => rev.id === review.id);
							this.filteredReviews.splice(currentReviewIndex, 1);
							this.admin = data.admin;
						} else {
							alert('Ошибка!');
						}
                    })
			}
			this.changingReviewId = null;
		}
	},
    template: `<div class="reviews">
				<stub v-if="!reviews.length"></stub>
				<review v-for="(review, index) of filteredReviews" :key="index" :review="review"></review>
			</div>`
});

Vue.component('review', {
    props: ['review'],
    template:	`<div class="review">
					<span class="review_titles review_name">{{ review.name }}</span>
					<span class="review_titles review_rate">Оценка: {{ review.rate }}</span>
					<p><b>Комментарий:</b></p><p class="review_comment" :id="'review_comment_' + review.id" v-show="review.id !== $parent.changingReviewId"> {{ review.comment }}</p>
					<textarea v-model="review.changedComment" name="comment" class="review_titles review_change" :id="'review_comment_change_' + review.id"  v-if="$parent.admin && review.id === $parent.changingReviewId">{{ review.comment }}</textarea>
					<span class="review_titles review_date">Дата: {{ review.date }}</span>
					<div class="review_controls">
						<button class="review_action" @click="$parent.saveReviewChanges(review)" v-if="review.id === $parent.changingReviewId">сохранить</button>
						<button class="review_action" @click="$parent.cancelChangingReview(review)" v-if="review.id === $parent.changingReviewId">отменить</button>
						<button class="review_action" @click="$parent.changeReview(review)" v-if="$parent.admin && review.id !== $parent.changingReviewId">изменить</button>
						<button class="review_action" @click="$parent.deleteReview(review)" v-if="$parent.admin">удалить</button>
					</div>
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
