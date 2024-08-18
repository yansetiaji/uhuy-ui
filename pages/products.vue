<script setup>
const { status, data: products } = await useLazyFetch(
	"http://localhost:8080/api/products"
);
</script>

<template>
	<div class="bg-gray-100 min-h-screen">
		<div class="px-6">
			<div class="text-black text-2xl bg-gray-100 py-6">Products</div>
			<div class="bg-white rounded-lg">
				<!-- Create Product Button section -->
				<div class="flex justify-end">
					<ButtonWithIcon iconClass="pi pi-plus" buttonText="Create Product" />
				</div>
				<!-- Table Content section -->
				<div v-if="status === 'pending'">
					<div class="flex items-center justify-center min-h-screen">
						<i
							class="pi pi-spin pi-spinner"
							style="font-size: 2rem; font-size: 10rem"
						></i>
					</div>
				</div>
				<div v-else>
					<ProductsTable :productsData="products" />
				</div>
			</div>
		</div>
	</div>
</template>
