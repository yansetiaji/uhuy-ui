<script setup>
const props = defineProps({
	linkTo: {
		type: String,
		default: null,
	},
	linkText: {
		type: String,
		default: null,
	},
});
</script>

<template>
	<NuxtLink
		:to="linkTo"
		class="text-white px-5 py-2 rounded-full bg-black hover:bg-gray-400 hover:text-black"
		>{{ linkText }}</NuxtLink
	>
</template>
