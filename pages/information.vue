<script setup>
const isModalOpen = ref(false);
import { onClickOutside } from "@vueuse/core";
const modal = ref(null);

onClickOutside(modal, () => (isModalOpen.value = false));
</script>

<template>
	<h1>HiTest</h1>
	<button @click="isModalOpen = true">Open Modal</button>
	<Teleport to="#modal">
		<!-- Modal Background -->
		<div
			class="fixed top-0 left-0 w-full h-full bg-black opacity-30 flex justify-center items-center"
			v-if="isModalOpen"
		>
			<!-- Modal -->
			<div class="relative bg-white px-20 py-28 border-4 rounded" ref="modal">
				<button
					@click="isModalOpen = false"
					class="absolute top-1 right-1 cursor-pointer"
				>
					x
				</button>
				Clik outside this modal to close it
			</div>
		</div>
	</Teleport>
	<div id="modal"></div>
</template>
