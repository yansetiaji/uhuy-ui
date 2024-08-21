# Uhuy UI

## Direct Dependencies/Packages/Modules
- [Nuxt](https://www.npmjs.com/package/nuxt) : Main Frontend Library
- [Vue](https://www.npmjs.com/package/vue) : Used by Nuxt
- [Tailwind CSS](https://www.npmjs.com/package/@nuxtjs/tailwindcss) : Tailwind CSS integration for Nuxt
- [PrimeIcons](https://www.npmjs.com/package/primeicons) : Icons Library
- [VueUse](https://vueuse.org/) : Used for [onClickOutside](https://vueuse.org/core/onClickOutside/) functionality
  - [Core](@vueuse/core)
  - [Nuxt](https://www.npmjs.com/package/@vueuse/nuxt)



# Step By Step

1. Create Docker Registry
1. Build Docker image
1. docker build -t yansetiaji/uhuy-ui:v0 .
1. docker build -t yansetiaji/uhuy-service:v0 .
1. docker push yansetiaji/uhuy-service:v0
1. docker push yansetiaji/uhuy-ui:v0

![img](./public/create_docker_repo_uhuy-ui.png)

