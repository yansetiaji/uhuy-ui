<template>
	<Teleport to="body">
		<div v-if="visible" class="modal-overlay" @click="close">
			<div class="modal-content" @click.stop>
				<slot></slot>
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

<style scoped>
.modal-overlay {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	display: flex;
	justify-content: center;
	align-items: center;
	z-index: 9999;
}

.modal-content {
	background: white;
	padding: 20px;
	border-radius: 8px;
	z-index: 10000;
}
</style>
