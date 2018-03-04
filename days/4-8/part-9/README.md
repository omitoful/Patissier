# Part.9

## API endpoint [GET /products?{paging}]

You can retrieve the data of products using this endpoint. If there comes more than one page of data, please use the returned page token to keep requesting more data.

### Request

**Headers**

| Parameter | Description | Required |
| --- | --- | --- |
| Authorization | Bearer \< jwt token \> | v |

**Query**

| Parameter | Description | Required |
| --- | --- | --- |
| paging | A page token. |  |


Example

```
// For the first page of products.
GET /products
```

Example 

```
// For the certain page of products.
GET /products?paging=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI1OGZlYjIxNzcyZTYyYjEwYTdlN2QxOGMiLCJsaW1pdCI6MTAsIm9mZnNldCI6MTAsInR5cGUiOiJwYWdlIiwidmVyc2lvbiI6IjEuMCJ9.jBzB-49t8e0t0irN0KBoXg-pjqBrlIixqnydLxsB9qc
```

### Response 200 (application/json)

**Body**

| Parameter | Description |
| --- | --- |
| data | The array of products. |
| product.id | The product id. |
| product.name | The product name. |
| product.price | The product price. |
| paging.next | The next page token. |

Example

```json
{
  "data": [
    {
      "id": "591f03ad623394fae007fbf8",
      "name": "Chocolate Cake",
      "price": 120
    },
    {
      "id": "591f03c1623394fae007fbf9",
      "name": "Puff",
      "price": 45
    }
  ],
  "paging": {
    "next": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI1OGZlYjIxNzcyZTYyYjEwYTdlN2QxOGMiLCJsaW1pdCI6MTAsIm9mZnNldCI6MTAsInR5cGUiOiJwYWdlIiwidmVyc2lvbiI6IjEuMCJ9.jBzB-49t8e0t0irN0KBoXg-pjqBrlIixqnydLxsB9qc"
  }
}
```

## Assignment

```swift
protocol ProductManagerDelegate {

    func manager(_ manager: ProductManager, didFetch products: [Product])

    func manager(_ manager: ProductManager, didFailWith error: Error)

}

class ProductManager {

    // Add a singleton property here 

    func fetchProducts() { /* Implementation */ }

}
```

1. Please implement the `ProductManagerDelegate` and `ProductManager` listing above.
2. Please add a **singleton** property named `shared` for `ProductManager`.
3. Please implement the function `fetchProducts()`. This function should request the `GET /products` API and parse the returned data into an array of products. If any error occurs, pass it via  `manager(:didFailWith:)` function; otherwise, you do get an array of products, please use `manager(:didFetch:)` instead.

### Note

You should understand what the **delegate** is and how it works. It's a typical pattern we use in iOS development. Google it for more information.