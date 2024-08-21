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
	target: {
		type: String,
		default: null,
	},
});
</script>

<template>
	<NuxtLink
		:to="linkTo"
		:target="target"
		class="flex items-center text-center px-5 py-2 rounded-full bg-black text-white hover:bg-gray-400 hover:text-black"
		>{{ linkText }}</NuxtLink
	>
</template>
