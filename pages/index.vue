<template>
	<!-- Homepage -->
	<div
		class="flex flex-col justify-center items-center min-h-screen bg-gray-100"
	>
		<!-- Welcome -->
		<div class="text-center text-black text-6xl font-bold mb-6">
			Welcome to Uhuy Products<br />Spontan? Uhuy!!! 🎉
		</div>
		<!-- SubTitle -->
		<div class="text-center text-gray-500 text-xl mb-6">
			Secret assignment from a secret organization
		</div>
		<!-- Navigation Button -->
		<div class="flex flex-row space-x-5 py-10">
			<ButtonLink linkTo="/products/" linkText="Go to products" />
			<ButtonLink linkTo="/information/" linkText="Go to information" />
		</div>
	</div>
</template>
