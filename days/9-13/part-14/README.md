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
    "id": "A1269A6F-DB44-44C5-AF98-8628EC099868",
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
GET /products/A1269A6F-DB44-44C5-AF98-8628EC099868/comments
```
Example

```
// For the certain offset and count of comments.
GET /products/A1269A6F-DB44-44C5-AF98-8628EC099868/comments?offset=3&count=5
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
      "id": "BEF48842-0EA1-4B42-9014-E523225C6684",
      "text": "Awesome!",
      "user": {
        "id": "6D280BEB-6413-49B4-80D1-7028B6CC3823",
        "name": "Carolyn Simmons"
      }
    }
  ]
}
```

## Assignment

1. Please implement the `GET /products/:id` and `GET /products/:id/comments?{offset,count}` APIs.
