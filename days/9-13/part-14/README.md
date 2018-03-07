# Part.14

## API endpoint [GET /products/:id]

You can request a product information with its id.

### Request

**Headers**

| Header | Value | Required |
| --- | --- | --- |
| Authorization | Bearer < jwt token > | v |

### Response 200 (application/json)

**Body**

| Parameter | Description |
| --- | --- |
| id | The product id. |
| name | The product name. |
| price | The product price. |

Example

```json
{
  "data": {
    "id": "591f03ad623394fae007fbf8",
    "name": "Chocolate Cake",
    "price": 120
  }
}
```

## API endpoint [GET /products/:id/comments?{offset,count}]

You can retrieve the data of comments of a product using this endpoint.

### Request

**Headers**

| Header | Value | Required |
| --- | --- | --- |
| Authorization | Bearer < jwt token > | v |

**Query**

| Parameter | Description | Required |
| --- | --- | --- |
| offset | The offset of retrieving  comments. |  |
| count | The number of retrieving comments. | |

Example

```
// For the first page of comments.
GET /products/591f03ad623394fae007fbf8/comments
```
Example

```
// For the certain offset and count of comments.
GET /products/591f03ad623394fae007fbf8/comments?offset=3&count=5
```

### Response 200 (application/json)

**Body**

| Parameter | Description |
| --- | --- |
| comment.id | The comment id. |
| comment.text | The comment text. |
| comment.user | The comment's owner. |

Example

```json
{
  "data": [
    {
      "id": "593b8e6473a7f08ded3e8266",
      "text": "Awesome!",
      "user": {
        "id": "59412c0989634bbf741cc2fb",
        "name": "Roy Hsu"
      }
    }
  ]
}
```

## Assignment

1. Please implement the `GET /products/:id` and `GET /products/:id/comments?{offset,count}` APIs.
