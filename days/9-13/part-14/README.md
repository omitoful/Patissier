# Part.14

## API endpoint [GET /products/:id]

You can request a product information with its id.

### Request

**Headers**

| Parameter | Description | Required |
| --- | --- | --- |
| Authorization | Bearer \< jwt token \> | v |

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

## API endpoint [GET /products/:id/comments?{paging}]

You can retrieve the data of comments of a product using this endpoint. If there comes more than one page of data, please use the returned page token to keep requesting more data.

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

```json
// For the first page of comments.
GET /products/591f03ad623394fae007fbf8/comments
```
Example

```json
// For the certain page of comments.
GET /products/591f03ad623394fae007fbf8/comments?paging=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI1OGZlYjIxNzcyZTYyYjEwYTdlN2QxOGMiLCJsaW1pdCI6MTAsIm9mZnNldCI6MTAsInR5cGUiOiJwYWdlIiwidmVyc2lvbiI6IjEuMCJ9.jBzB-49t8e0t0irN0KBoXg-pjqBrlIixqnydLxsB9qc
```

### Response 200 (application/json)

**Body**

| Parameter | Description |
| --- | --- |
| data | The array of comments. |
| comment.id | The comment id. |
| comment.text | The comment text. |
| comment.user | The comment's owner. |
| paging.next | The next page token. |

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
  ],
  "paging": {
    "next": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI1OGZlYjIxNzcyZTYyYjEwYTdlN2QxOGMiLCJsaW1pdCI6MTAsIm9mZnNldCI6MTAsInR5cGUiOiJwYWdlIiwidmVyc2lvbiI6IjEuMCJ9.jBzB-49t8e0t0irN0KBoXg-pjqBrlIixqnydLxsB9qc"
  }
}
```

## Assignment

1. Please implement the `GET /products/:id` and `GET /products/:id/comments?{paging}` APIs.