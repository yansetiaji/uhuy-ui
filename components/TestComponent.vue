<template>
	<button @click="handleClick">xxxx</button>
</template>

<script setup>
const props = defineProps(["onHalooo"]);

const emit = defineEmits("halooo");
const handleClick = () => {
	emit("halooo");
};
</script>
