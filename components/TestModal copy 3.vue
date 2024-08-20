<template>
	<Teleport to="body">
		<!-- Modal Background / Overlay -->
		<div
			v-if="visible"
			class="fixed top-0 left-0 w-full h-full bg-black bg-opacity-50 flex justify-center items-center z-[10000]"
			@click="close"
		>
			<div v-if="visible">
				<div
					@click="onToggle"
					class="absolute bg-black w-full opacity-70 inset-0 z-0"
				></div>
				<div
					class="z-[1000] w-full max-w-lg p-3 relative mx-auto my-auto rounded-xl shadow-lg bg-white"
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
								:action="toggleModal"
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
								:action="toggleModal"
							></ButtonAction>
						</div>
					</div>
				</div>
			</div>
		</div>
	</Teleport>
</template>

<script setup>
const props = defineProps({
	visible: Boolean,
});

const emit = defineEmits(["close"]);

const close = () => {
	emit("close");
};
</script>
