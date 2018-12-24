# Part.9

## API endpoint [GET /products?{offset,count}]

You can retrieve the data of products using this endpoint.

### Request

**Headers**

| Header | Value | Required |
| --- | --- | --- |
| Authorization | Bearer < jwt token > | v |

**Query**

| Parameter | Description | Required |
| --- | --- | --- |
| offset | The offset of retrieving products. |  |
| count | The number of retrieving products. | |


Example

```
// For the first page of products.
GET /products
```

Example 

```
// For the certain offset and count of products.
GET /products?offset=3&count=5
```

### Response 200 (application/json)

**Body**

| Parameter | Description |
| --- | --- |
| product.id | The product id. |
| product.name | The product name. |
| product.price | The product price. |

Example

```json
{
  "data": [
    {
      "id": "A1269A6F-DB44-44C5-AF98-8628EC099868",
      "name": "Chocolate Cake",
      "price": 120
    },
    {
      "id": "BFC07003-22E8-4C55-A57F-A5064FA6F2BE",
      "name": "Lollipop",
      "price": 75
    }
  ]
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