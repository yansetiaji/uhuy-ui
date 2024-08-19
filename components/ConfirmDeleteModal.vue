<template>
	<div id="app">
		<div class="flex flex-col items-center justify-center p-3 min-h-full">
			<button
				@click="onToggle"
				class="bg-purple-500 border border-purple-500 px-5 py-2 text-sm shadow-sm font-medium tracking-wider text-white rounded-md hover:shadow-lg hover:bg-purple-600"
			>
				Open
			</button>
		</div>
		<transition name="fade">
			<div v-if="isModalVisible">
				<div
					@click="onToggle"
					class="absolute bg-black opacity-70 inset-0 z-0"
				></div>
				<div
					class="w-full max-w-lg p-3 relative mx-auto my-auto rounded-xl shadow-lg bg-white"
				>
					<div>
						<h2 class="text-2xl font-bold py-2 pl-2 border-b-2">
							Delete Product
						</h2>
						<div class="flex-col items-center justify-center text-center">
							<i
								class="pi pi-exclamation-triangle text-7xl p-5"
								style="color: red"
							></i>
							<p class="text-xl text-gray-500 px-8">
								Are you sure you want to delete this product?
							</p>
						</div>
						<div class="flex justify-end mt-5">
							<ButtonAction
								:action="onToggle"
								text="No"
								class="m-2"
								bgColor="white"
								textColor="black"
							/>
							<ButtonAction
								text="Yes"
								bgColor="red"
								textColor="white"
								class="m-2"
								:action="onToggle"
							></ButtonAction>
						</div>
					</div>
				</div>
			</div>
		</transition>
	</div>
</template>

<script>
export default {
	data() {
		return {
			isModalOpen: false,
		};
	},

	computed: {
		isModalVisible() {
			return this.isModalOpen;
		},
	},

	methods: {
		onToggle() {
			this.isModalOpen = !this.isModalOpen;
		},
		deleteProduct() {
			$fetch("/api/contact", {
				method: "POST",
				body: { hello: "world " },
			});
		},
	},
};
</script>
<style>
.fade-enter,
.fade-leave-to {
	opacity: 0;
}

.fade-enter-active,
.fade-leave-active {
	transition: opacity 100ms ease-out;
}
</style>
