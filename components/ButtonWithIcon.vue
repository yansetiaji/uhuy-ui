<script setup>
const props = defineProps({
	iconClass: {
		type: String,
		default: null,
	},
	buttonText: {
		type: String,
		default: null,
	},
});
</script>

<template>
	<button
		class="justify-end items-start m-4 bg-black text-white px-5 py-1 rounded-full hover:bg-black hover:text-white"
	>
		<i :class="iconClass"></i>
		{{ buttonText }}
	</button>
</template>
