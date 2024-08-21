# Uhuy UI

## Public Endpoint

- Via IngressController: [http://uhuy-ui.cicicuit.tech](http://uhuy-ui.cicicuit.tech)
- Via NodePort: [http://uhuy-ui.cicicuit.tech:30000](http://uhuy-ui.cicicuit.tech:30001)

## Direct Dependencies/Packages/Modules

- [Nuxt](https://www.npmjs.com/package/nuxt) : Main Frontend Library
- [Vue](https://www.npmjs.com/package/vue) : Used by Nuxt
- [Tailwind CSS](https://www.npmjs.com/package/@nuxtjs/tailwindcss) : Tailwind CSS integration for Nuxt
- [PrimeIcons](https://www.npmjs.com/package/primeicons) : Icons Library
- [VueUse](https://vueuse.org/) : Used for [onClickOutside](https://vueuse.org/core/onClickOutside/) functionality
  - [Core](@vueuse/core)
  - [Nuxt](https://www.npmjs.com/package/@vueuse/nuxt)

## Using the repo

Clone the repository

```bash
git clone https://github.com/yansetiaji/uhuy-ui
cd uhuy-ui
```

For example I use [`bun.js`](https://bun.sh/)

Run instantly at local development server:

```bash
bun install
bun run dev
```

Build as a binary and run:

```bash
bun run build
bun .output/server/index.mjs
```

Build docker image:

```bash
docker build -t <username>/uhuy-ui:<tag> .
```

![Build uhuy-ui](./docs-assets/build_uhuy-ui.png)

Run containerized version on localhost:

```bash
docker run -p 8080:8080 <username>/uhuy-service:<tag>
```

## Kubernetes (K3S) Deployment Visualized

![K3S Go](./docs-assets/k3s_go.png)

## Step by Step to Kubernetes

### Create image repository at [Docker Hub Repository](https://hub.docker.com)

![Create yansetiaji/uhuy-service repo](./docs-assets/create_docker_repo_uhuy-service.png)

### Push builded local image to the [Docker Hub Repository](https://hub.docker.com)

Note: login required

```bash
docker push <username>/uhuy-service:<tag>
```

![Docker push uhuy-service](./docs-assets/push_uhuy-service.png)

### Let's go to kubernetes

```bash
cd ./kubernetes
```

Create `uhuy` `namespace`. (Optional, you can use `default` `namespace` instead)

```bash
kubectl create -f Namespace.yaml
```

![kubectl get namespace](./docs-assets/ss_namespace.png)

Change `contexts.context.namespace` in `KUBECONFIG`. (No need to do this if you're using `default` `namespace`)

```yaml
contexts:
- context:
    cluster: default
    user: default
    namespace: uhuy
  name: default
```

### Create Deployment

```bash
kubectl create -f Deployment.yaml
```

![kube deployment](./docs-assets/kube_deployment.png)

### Create Service

```bash
kubectl create -f Service-np.yaml
kubectl create -f Service-ci.yaml
```

![kube svc](./docs-assets/kube_svc.png)

### Create Ingress

```bash
kubectl create -f Ingress.yaml
```

![kube svc](./docs-assets/kube_ingress.png)

Access via [Public Endpoint](#public-endpoint)

## Something may interest you

Since the format of `price` defined on the assignments looks like this

```json
{
  "name": "test-product",
    "description": "random-description",
    "price": 100.00
}
```

But on the frontend example is not using decimal places
![Table Example](./docs-assets/Simple%20Table.JPG)
I just follow the complex one, applied both for backend and frontend. And for the safety financial calculations record (in case further processing / calculations needed) the price data is saved with `int64` file type intead of `float64`

So I made a custom data type Decimal and different data model for API communications (price using `numerical`/`decimal`/`float64` with 2 digits precision) and (dummy) database purpose (price is using `int64`). [Check it here](https://github.com/yansetiaji/uhuy-service/blob/d57c744df458b48f01bcc9ca33956ec22ccaeb32/server.go#L15-L54)

I made 2 version of get all products (paginated and non paginated), because it was no clear instruction on backend assignment (paginated or not), so I just followed the complex one (Paginated in example table).

```go
// Healthcheck endpoint
e.GET("/health", func(c echo.Context) error {
  return c.String(http.StatusOK, "")
})

// Create Product
e.POST("/api/products", createProductHandler)

// Get Product by ID
e.GET("/api/products/:id", getProductByIdHandler)

// Get All Products Non Paginated
e.GET("/api/products-all", getAllProductsHandler)

// Get All Products Pagination
e.GET("/api/products", getAllProductsPaginationHandler)

// Update Prodcut by ID
e.PUT("/api/products/:id", updateProductHandler)

// Delete Product by ID
e.DELETE("/api/products/:id", deleteProductHandler)
```

And because I used different data model, we should convert it every user-server/server-user interaction

```go
// Data conversion model from ProductAPI to ProductDB
func APItoDB(p *ProductAPI) ProductDB {
  return ProductDB{
    Id:          lastId,
    Name:        p.Name,
    Description: p.Description,
    Price:       int64(p.Price * 100),
  }
}

// Data conversion model from ProductDB to ProductAPI
func DBtoAPI(p *ProductDB) ProductAPI {
  return ProductAPI{
    Id:          &p.Id,
    Name:        p.Name,
    Description: p.Description,
    Price:       Decimal(float64(p.Price) / 100),  
  }
}
```



    # Uhuy UI
    
    
    
    
    
    # Step By Step
    
    1. Create Docker Registry
    2. Build Docker image
    3. docker build -t yansetiaji/uhuy-ui:v0 .
    4. docker build -t yansetiaji/uhuy-service:v0 .
    5. docker push yansetiaji/uhuy-service:v0
    6. docker push yansetiaji/uhuy-ui:v0
    
    ![img](./public/create_docker_repo_uhuy-ui.png)
