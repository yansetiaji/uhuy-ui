<script setup>
// Burger menu state when mobile screen used
const isBurgerOpen = useState("isBurgerOpen", () => false);

// Toggle the state when the button or link is clicked
const toggleBurger = () => {
	isBurgerOpen.value = !isBurgerOpen.value;
};
</script>

<template>
	<!-- Main template layout -->
	<div class="flex-col flex min-h-screen">
		<header class="text-black">
			<nav class="mx-auto flex items-center justify-between px-6 py-4">
				<!-- Homepage NuxtLink -->
				<div class="text-2xl font-bold">
					<NuxtLink to="/">Uhuy!</NuxtLink>
				</div>

				<!-- Burger button to toggle menu in mobile views -->
				<button class="block md:hidden text-2xl" @click="toggleBurger">
					☰
				</button>

				<!-- Desktop Menu -->
				<div class="hidden md:flex space-x-4">
					<NuxtLink
						to="/products"
						class="text-black px-2 py-1 rounded-full hover:bg-black hover:text-white"
						>Products</NuxtLink
					>
					<NuxtLink
						to="/information"
						class="text-black px-2 py-1 rounded-full hover:bg-black hover:text-white"
						>Information</NuxtLink
					>
					<NuxtLink
						to="/about"
						class="text-black px-2 py-1 rounded-full hover:bg-black hover:text-white"
						>About</NuxtLink
					>
				</div>

				<!-- Mobile Menu -->
				<!-- Hidden when the screen is large -->
				<div
					class="md:hidden fixed inset-0 bg-white z-50 transform transition-transform"
					:class="{
						'translate-x-0': isBurgerOpen,
						'-translate-x-full': !isBurgerOpen,
					}"
				>
					<div class="flex flex-col items-center p-4 space-y-4">
						<div class="text-2xl font-bold pb-2" @click="toggleBurger">
							<NuxtLink to="/">Uhuy!</NuxtLink>
						</div>
						<NuxtLink
							to="/products"
							class="text-black px-2 py-1 rounded-full hover:bg-black hover:text-white"
							@click="toggleBurger"
							>Products</NuxtLink
						>
						<NuxtLink
							to="/information"
							class="text-black px-2 py-1 rounded-full hover:bg-black hover:text-white"
							@click="toggleBurger"
							>Information</NuxtLink
						>
						<NuxtLink
							to="/about"
							class="text-black px-2 py-1 rounded-full hover:bg-black hover:text-white"
							@click="toggleBurger"
							>About</NuxtLink
						>
						<!-- Add back functional -->
						<button
							class="text-black px-2 py-1 rounded-full hover:bg-black hover:text-white"
							@click="toggleBurger"
						>
							Back
						</button>
					</div>
				</div>
			</nav>
		</header>
		<main class="flex-grow">
			<!-- slot for pages -->
			<slot />
		</main>
		<footer
			class="bg-white text-slate-500 pt-2 border-t-2 border-gray-300 mb-2"
		>
			<div class="container mx-auto flex justify-center p-1">
				<div class="text-sm">
					<p>&copy; 2024 Uhuy Products. All rights reserved.</p>
				</div>
			</div>
		</footer>
	</div>
</template>
