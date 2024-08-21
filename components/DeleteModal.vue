<template>
	<Teleport to="#deletemodal">
		<!-- Modal Background / Overlay -->
		<div
			class="fixed top-0 left-0 w-full h-full bg-black bg-opacity-50 flex justify-center items-center"
		>
			<div>
				<div class="absolute bg-black w-full opacity-70 inset-0"></div>
				<!-- Modal content -->
				<div
					ref="deleteModal"
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
							<button
								class="bg-white hover:bg-black border-gray-200 hover:border-black border-2 text-black hover:text-white px-5 py-2 rounded-full m-2"
								@click="toggleModal"
							>
								No
							</button>
							<button
								class="bg-red-500 hover:bg-red-600 text-white hover:text-white px-5 py-2 rounded-full m-2"
								@click="handleDelete(toBeDeletedId)"
							>
								Yes
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</Teleport>
</template>

<script setup>
import { onClickOutside } from "@vueuse/core";
const props = defineProps({
	toBeDeletedId: Number,
	toBeDeletedName: String,
});

// Click outside modal to delete
const deleteModal = useState("deleteModal", () => null);
onClickOutside(deleteModal, () => {
	toggleModal();
	// openDeleteModal.value = false;
	// toBeDeletedId.value = null;
});

const { toBeDeletedId, onUpdate } = props;

const backendHost = useRuntimeConfig().public.backendHost;
const isModalOpen = ref(null);

const toggleModal = () => {
	emit("close");
};

// const deletionStatus = ref("");
const deletionMessage = ref("");
const isDeleting = ref(false);

const emit = defineEmits(["update", "close"]);

const handleDelete = async (id) => {
	// isDeleting.value = true;
	const { error, data, status } = await useFetch(
		`${backendHost}/api/products/${id}`,
		{
			method: "DELETE",
		}
	);
	// deletionStatus.value = status.value;
	if (status.value === "success") {
		deletionMessage.value = data.value.message;
	} else {
		deletionMessage.value = error.value.data.message;
	}
	emit("update");
	emit("close");
	// isDeleting.value = false;
};
</script>
