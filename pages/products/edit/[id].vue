<template>
	<!-- Page Title -->
	<h2 class="text-black text-2xl bg-gray-100 py-6">
		Edit Product {{ inputName }}
	</h2>
	<!-- Overall Form Background -->
	<div class="bg-white rounded-lg w-full">
		<!-- All Form Component -->
		<div class="bg-white mx-10 py-4">
			<!-- Main Form (Input and Submit) Component -->
			<form class="" @submit.prevent="handleSubmit" method="POST">
				<div>
					<label for="description">Name:</label>
					<input
						type="text"
						id="name"
						name="name"
						required
						v-model="inputName"
						@input="filterInput"
						class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-black"
					/>
					<p v-if="inputNameWarning">{{ inputNameWarning }}</p>
				</div>

				<!-- Product Description -->
				<div>
					<label for="description">Desciption:</label>
					<textarea
						type="text"
						id="description"
						name="description"
						required
						v-model="inputDescription"
						@input="filterInput"
						class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-black"
					/>
					<p v-if="inputDescriptionWarning">{{ inputDescriptionWarning }}</p>
				</div>

				<!-- Product Price -->
				<div>
					<label for="price">Price:</label>
					<input
						type="number"
						id="price"
						name="price"
						step="0.01"
						min="0"
						required
						v-model="inputPrice"
						class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-black"
					/>
				</div>
				<div class="justify-end flex flex-col items-center">
					<p v-if="submissionStatus === 'success'" class="mt-4 text-green-600">
						{{ submissionMessage }}
					</p>
					<p v-if="submissionStatus === 'error'" class="mt-4 text-red-600">
						{{ submissionMessage }}
					</p>
					<button
						type="submit"
						class="my-4 px-5 py-2 rounded-full bg-black text-white hover:bg-gray-400 hover:text-black disabled:opacity-75"
						:disabled="isSubmitting"
						@submit="handleSubmit"
					>
						Submit
					</button>
				</div>
			</form>
		</div>
	</div>
</template>
<script setup>
const route = useRoute();
const backendHost = useRuntimeConfig().public.backendHost;
const inputNameWarning = useState("inputNameWarning", () => null);
const inputDescriptionWarning = useState("inputDescriptionWarning", () => null);

const submissionStatus = ref("");
const submissionMessage = ref("");
const isSubmitting = ref(false);

// Get current value before editing
const { error, data, status } = await useFetch(
	`${backendHost}/api/products/${route.params.id}`,
	{
		method: "GET",
	}
);

const inputName = ref(data.value.Name);
const inputDescription = ref(data.value.Description);
const inputPrice = ref(data.value.Price);

// // Banned input chars
var bannedCharsDict = {};

// prettier-ignore
{
  bannedCharsDict = {
    name : ["<", ">", "\"", "'", "\\","%", "&", "*", ":", ";", "?", "@", "^", "{", "}", "[", "]", "~", "$", "=", "!", "|", ","],
    description : ["<", ">", "\"", "'", "\\", "*", ";", "?", "@", "^", "{", "}", "[", "]", "~", "$", "=", "!", "|",]
  }
}

// Filter input character logic
const filterInput = (event) => {
	const inputId = event.target.id;
	const inputValue = event.target.value;

	const bannedChars = bannedCharsDict[inputId];
	// split and check
	var bannedCharsContained = inputValue.split("");

	// .filter((char) => bannedChars.includes(char));
	// Filter to unique only
	bannedCharsContained = Array.from(new Set(bannedCharsContained)).filter(
		(char) => bannedChars.includes(char)
	);

	// Input warning template
	var inputWarning = "";
	if (bannedCharsContained.length > 0) {
		inputWarning = `The following characters are not allowed: ${bannedCharsContained.join(
			", "
		)}`;
	} else {
		inputWarning = "";
	}

	// Update the warning
	if (inputId === "name") {
		inputNameWarning.value = inputWarning;
	} else if (inputId === "description") {
		inputDescriptionWarning.value = inputWarning;
	}
};

const handleSubmit = async () => {
	isSubmitting.value = true;
	const { error, data, status } = await useFetch(
		`${backendHost}/api/products/${route.params.id}`,
		{
			method: "PUT",
			body: {
				name: inputName,
				description: inputDescription,
				price: inputPrice,
			},
		}
	);
	submissionStatus.value = status.value;
	if (status.value === "success") {
		submissionMessage.value = data.value.message;
	} else {
		submissionMessage.value = error.value.data.message;
	}
	isSubmitting.value = false;
};
</script>
