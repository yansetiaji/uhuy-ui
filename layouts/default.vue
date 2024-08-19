<script setup>
import BurgerMenu from "~/components/BurgerMenu.vue";

// Burger menu state when mobile screen used
const isBurgerOpen = useState("isBurgerOpen", () => false);

// Toggle the state when the button or link is clicked
const toggleBurger = () => {
	isBurgerOpen.value = !isBurgerOpen.value;
};
</script>

<template>
	<!-- Main template layout -->
	<div class="flex flex-col min-h-screen">
		<header>
			<!-- Main Navbar -->
			<nav class="flex mx-auto justify-between px-6 py-4">
				<!-- Homepage NuxtLink -->
				<h1 class="text-2xl font-bold">
					<NuxtLink to="/">Uhuy!</NuxtLink>
				</h1>

				<!-- Burger button to toggle menu in small screen, hidden in medium to large scren -->
				<button class="md:hidden block text-2xl" @click="toggleBurger">
					☰
				</button>

				<!-- Medium to large screen menu link, hidden on small screen -->
				<div class="hidden md:flex space-x-4">
					<NavbarDesktopLink linkTo="/products" linkText="Products" />
					<NavbarDesktopLink linkTo="/information" linkText="Information" />
					<NavbarDesktopLink linkTo="/about" linkText="About" />
				</div>

				<!-- Small sreen menu link, hidden on medium to large screen -->
				<div
					class="md:hidden fixed inset-0 bg-white z-[1000] transform transition-transform"
					:class="{
						'translate-x-0': isBurgerOpen,
						'-translate-x-full': !isBurgerOpen,
					}"
				>
					<div class="flex flex-col items-center p-4 space-y-4">
						<!-- Homepage NuxtLink -->
						<div class="text-2xl font-bold pb-2" @click="toggleBurger">
							<NuxtLink to="/">Uhuy!</NuxtLink>
						</div>
						<BurgerMenu
							to="/products"
							linkText="Products"
							:onClickFunction="toggleBurger"
						/>
						<BurgerMenu
							to="/information"
							linkText="Information"
							:onClickFunction="toggleBurger"
						/>
						<BurgerMenu
							to="/about"
							linkText="About"
							:onClickFunction="toggleBurger"
						/>
						<BurgerMenu linkText="Back" :onClickFunction="toggleBurger" />
					</div>
				</div>
			</nav>
		</header>
		<main class="flex-grow">
			<!-- slot for pages -->
			<!-- Page Background -->
			<div class="bg-gray-100 min-h-screen">
				<!-- Page Content -->
				<div class="px-6 pb-6">
					<slot />
				</div>
			</div>
		</main>
		<footer
			class="bg-white text-slate-500 pt-2 border-t-2 border-gray-300 mb-2"
		>
			<div class="flex mx-auto justify-center p-1">
				<div class="text-sm">
					<p>&copy; 2024 Uhuy! All rights reserved.</p>
				</div>
			</div>
		</footer>
	</div>
</template>
