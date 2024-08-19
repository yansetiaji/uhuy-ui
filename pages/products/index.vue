<script setup>
import { onClickOutside } from "@vueuse/core";

// Backend API (initial fetch)
const backendHost = useRuntimeConfig().public.backendHost;

const pageNumber = ref(1);
const rowsPerPage = ref(5);
const sort = ref("");
const sortBy = ref("");
const { status, data: products } = await useLazyFetch(
	`${backendHost}/api/products?page=${pageNumber}&limit=${rowsPerPage.value}&sort=${sort.value}&sortBy=${sortBy.value}`
);

// Handle row per page selection
watch(rowsPerPage, async () => {
	pageNumber.value = 1;
	const newProducts = await $fetch(
		`${backendHost}/api/products?page=${pageNumber.value}&limit=${rowsPerPage.value}&sort=${sort.value}&sortBy=${sortBy.value}`
	);
	products.value = newProducts;
});

// Handle pageNumber change
const changePageNum = (num) => {
	if (
		(pageNumber.value + num < 0) |
		(pageNumber.value + num > products.value.totalPages)
	) {
		return;
	}

	pageNumber.value += num;
};

// Watch if pageNumber value updated to reload the new data
watch(pageNumber, async () => {
	try {
		const newProducts = await $fetch(
			`${backendHost}/api/products?page=${pageNumber.value}&limit=${rowsPerPage.value}&sort=${sort.value}&sortBy=${sortBy.value}`
		);
		products.value = newProducts;
	} catch (error) {
		console.log(error, newProducts);
	}
});

// Row data dropdown
const openDropdown = useState("openDropdown", () => null);
const toggleDropdown = (index) => {
	if (openDropdown.value === index) {
		openDropdown.value = null;
	} else {
		openDropdown.value = index;
	}
};

// Toggle sort by

// Pagination Bar Dropdown
const openPaginationDropdown = useState("openPaginationDropdown", () => null);
const togglePaginationDropdown = () => {
	openPaginationDropdown.value = !openPaginationDropdown.value;
};

// Row dropdown removal using vueUse onClickOutside
// This will help to remove row dropdown if we click outside the row dropdown
// https://vueuse.org/core/onClickOutside/
const rowDropdown = useState("rowDropdown", () => null);
const paginationDropdown = useState("paginationDropdown", () => null);
onClickOutside(rowDropdown, () => (openDropdown.value = false));
onClickOutside(paginationDropdown, () => (paginationDropdown.value = false));
// console.log(products.value.totalLength);
</script>

<template>
	<!-- Page Title -->
	<h2 class="text-black text-2xl bg-gray-100 py-6">Products</h2>
	<!-- Table Background -->
	<div class="bg-white rounded-lg justify-center">
		<!-- Create Product Button -->
		<div class="flex justify-end">
			<NuxtLink to="/products/create">
				<ButtonWithIcon iconClass="pi pi-plus" buttonText="Create Product" />
			</NuxtLink>
		</div>
		<!-- Table Main Component -->
		<div class="flex flex-cols justify-center">
			<table class="table-fixed mx-10 border-collapse w-11/12">
				<!-- Table Header -->
				<thead class="border-b-4">
					<tr class="justify-between">
						<th class="flex justify-between text-center w-3/12 p-4">
							<p>Name</p>
							<button><i class="pi pi-angle-up"></i></button>
						</th>
						<th class="text-center w-6/12 p-4"><p>Desciption</p></th>
						<th class="text-center w-3/12 p-4"><p>Price</p></th>
						<th class="text-left w-1/12 p-4"></th>
					</tr>
				</thead>
				<!-- Table Body -->
				<tbody>
					<tr
						v-for="(product, index) in products.values"
						:key="product.id"
						class="border-b-2"
					>
						<td class="px-4 py-2">{{ product.name }}</td>
						<td class="px-4 py-2">{{ product.description }}</td>
						<td class="px-4 py-2 text-right">
							{{ product.price.toFixed(2) }}
						</td>
						<td class="px-4 py-2 relative">
							<!-- Row Dropdown activation button -->
							<button @click="toggleDropdown(index)">
								<i class="pi pi-ellipsis-v"></i>
							</button>
							<!-- Row Dropdown (Edit/Delete menu) -->
							<ul
								v-if="openDropdown === index"
								ref="rowDropdown"
								class="absolute top-3/4 right-1/2 bg-white border-2 p-3 z-[1000] flex-col rounded-lg"
							>
								<li>
									<NuxtLink
										:to="`/products/edit/${product.id}`"
										class="flex items-center px-4 py-2"
									>
										<i class="pi pi-pencil pr-3"></i>
										<p class="text-l">Edit</p>
									</NuxtLink>
								</li>
								<li>
									<button class="flex items-center px-4 py-2">
										<i class="pi pi-trash pr-3" style="color: red"></i>
										<div class="text-red-500">Delete</div>
									</button>
								</li>
							</ul>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- Pagination menu/navigation -->
		<div>
			<div class="flex items-center justify-end mt-6 mr-10 pb-6">
				<!-- Rows per page options -->
				<div class="flex items-center border-2 rounded-md py-1 px-2 m-3">
					<p class="pr-2">Rows per page:</p>
					<form class="pl-1">
						<label for="rows-per-page"></label>
						<select
							id="rows-per-page"
							v-model="rowsPerPage"
							@change="handleRowsPerPageSelection"
						>
							<option selected>5</option>
							<option value="10">10</option>
							<option value="20">20</option>
							<option value="50">50</option>
							<option value="100">100</option>
						</select>
					</form>
				</div>
				<!-- Current product "index" location -->
				<p class="m-3 border-2 rounded-md py-1 px-2">
					{{ products.page * rowsPerPage - rowsPerPage + 1 }}-{{
						(products.page - 1) * rowsPerPage + products.totalReturnedData
					}}
					of
					{{ products.totalLength }}
				</p>
				<!-- Page navigation -->
				<div class="border-2 rounded-md py-1 mx-3">
					<button @click="changePageNum(-1)">
						<i class="pi pi-angle-double-left px-3"></i>
					</button>
					<button @click="changePageNum(1)">
						<i class="pi pi-angle-double-right px-3"></i>
					</button>
				</div>
			</div>
		</div>
	</div>
</template>
