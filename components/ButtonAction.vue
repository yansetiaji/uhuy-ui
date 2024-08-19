<template>
	<button
		:class="`${bgColorVariants[bgColor]} ${textColorVariants[textColor]} px-5 py-2 rounded-full`"
		@click="handleClick"
	>
		{{ text }}
	</button>
</template>

<script setup>
const props = defineProps({
	bgColor: {
		type: String,
		default: "blue",
	},
	textColor: {
		type: String,
		default: "blue",
	},
	text: {
		type: String,
		default: "Default Placeholder",
	},
	action: {
		type: Function,
		default: null,
	},
});
const bgColorVariants = {
	red: "bg-red-500 hover:bg-red-600",
	white: "bg-white hover:bg-black border-gray-200 hover:border-black border-2",
};

const textColorVariants = {
	white: "text-white hover:text-white",
	black: "text-black hover:text-white",
};
const emit = defineEmits(["click"]);

const handleClick = () => {
	if (props.action) {
		props.action();
	}
	emit("click");
};
</script>
