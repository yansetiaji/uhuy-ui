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
			<ButtonLink linkTo="/products/" linkText="Go to Products" />
			<ButtonLink
				linkTo="https://github.com/yansetiaji/uhuy-service"
				target="_blank"
				linkText="Go to Backend Repo"
			/>
			<ButtonLink
				linkTo="https://github.com/yansetiaji/uhuy-ui"
				target="_blank"
				linkText="Go to Frontend Repo"
			/>
		</div>
	</div>
</template>
