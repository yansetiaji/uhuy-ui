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
	onClickFunction: {
		type: Function,
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
		class="text-black px-2 py-1 rounded-full hover:bg-black hover:text-white"
		@click="onClickFunction"
		:target="target"
		>{{ linkText }}</NuxtLink
	>
</template>
