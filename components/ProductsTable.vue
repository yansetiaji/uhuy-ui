<script setup>
const props = defineProps({
	productsData: {
		type: Object,
		default: null,
	},
});
const openDropdown = useState("openDropdown", () => null);
const toggleDropdown = (index) => {
	if (openDropdown.value === index) {
		openDropdown.value = null;
	} else {
		openDropdown.value = index;
	}
};
</script>

<template>
	<div class="overflow-x-auto w-full">
		<table class="table-fixed mx-10 border-collapse">
			<thead class="border-b-2">
				<tr class="justify-between">
					<th class="text-left w-3/12 p-4">Name</th>
					<th class="text-left w-6/12 p-4">Desciption</th>
					<th class="text-left w-3/12 p-4">Price</th>
					<th class="text-left w-1/12 p-4"></th>
				</tr>
			</thead>
			<tbody>
				<tr v-for="(product, index) in productsData" :key="product.id">
					<td class="px-4 py-2">{{ product.name }}</td>
					<td class="px-4 py-2">{{ product.description }}</td>
					<td class="px-4 py-2">{{ product.price.toFixed(2) }}</td>
					<td class="px-4 py-2 relative">
						<button @click="toggleDropdown(index)">
							<i class="pi pi-ellipsis-v"></i>
						</button>
						<ul
							v-if="openDropdown === index"
							class="absolute top-10 right-1 bg-white border-2 p-3 z-[1000] flex-col rounded-lg"
						>
							<li>
								<button class="flex px-4 py-2">
									<i class="pi pi-pencil pr-5"></i>Edit
								</button>
							</li>
							<li>
								<button class="flex px-4 py-2">
									<i class="pi pi-trash pr-5" style="color: red"></i>
									<div class="text-red-500">Delete</div>
								</button>
							</li>
						</ul>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</template>
