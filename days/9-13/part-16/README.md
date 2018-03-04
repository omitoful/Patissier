# Part.16

## API endpoint [GET /me]

You can request your personal profile data with this endpoint.

### Request

**Headers**

| Header | Value | Required |
| --- | --- | --- |
| Authorization | Bearer < jwt token > | v |

### Response 200 (application/json)

**Body**

| Parameter | Description |
| --- | --- |
| id | The user id. |
| first_name | The user's first name. |
| last_name | The user's last name. |
| name | The user's name. |

Example

```json
{
  "data": {
    "id": "59412c0989634bbf741cc2fb",
    "first_name": "Roy",
    "last_name": "Hsu",
    "name": "Roy Hsu"
  }
}
```

## API endpoint [GET /me/orders?{paging}]

You can retrieve the data of your orders using this endpoint. If there comes more than one page of data, please use the returned page token to keep requesting more data.

### Request

**Headers**

| Header | Value | Required |
| --- | --- | --- |
| Authorization | Bearer < jwt token > | v |

**Query**

| Parameter | Description | Required |
| --- | --- | --- |
| paging | A page token. |  |

Example

```
// For the first page of orders.
GET /orders
```

Example

```
// For the certain page of orders.
GET /orders?paging=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI1OGZlYjIxNzcyZTYyYjEwYTdlN2QxOGMiLCJsaW1pdCI6MTAsIm9mZnNldCI6MTAsInR5cGUiOiJwYWdlIiwidmVyc2lvbiI6IjEuMCJ9.jBzB-49t8e0t0irN0KBoXg-pjqBrlIixqnydLxsB9qc
```

### Response 200 (application/json)

**Body**

| Parameter | Description |
| --- | --- |
| data | The array of orders. |
| order.id | The order id. |
| order.items | The items in the order. |
| order.buyer | The buyer of the order. |
| order.recipient | The recipient of the order. |
| order.shipping | The shipping for the order. |
| order.total_amount | The total amount of the order. |
| order.transaction | The transaction for the order. |
| order.created | The created date of the order. |
| paging.next | The next page token. |

Example

```json
{
  "data": [
    {
      "id": "593805e6907b4e44fe9467f8",
      "items": [
        {
          "id": "591f03ad623394fae007fbf8",
          "type": "product",
          "quantity": 2
        }
      ],
      "buyer": {
        "id": "59412c0989634bbf741cc2fb"
      },
      "recipient": {
        "phone_number": "0987654321",
        "first_name": "Roy",
        "last_name": "Hsu",
        "title": "mister"
      },
      "shipping": {
        "service": "post-office",
        "postal_code": "110",
        "city": "Taipei",
        "address": "No.7, Sec. 5, Xinyi Rd., Xinyi Dist."
      },
      "total_amount": 20,
      "transaction": {
        "id": "59380600907b4e44ff9467f8",
        "payment_method": "credit-card"
      },
      "created": "2017-06-10T06:05:40.000Z"
    }
  ],
  "paging": {
    "next": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI1OGZlYjIxNzcyZTYyYjEwYTdlN2QxOGMiLCJsaW1pdCI6MTAsIm9mZnNldCI6MTAsInR5cGUiOiJwYWdlIiwidmVyc2lvbiI6IjEuMCJ9.jBzB-49t8e0t0irN0KBoXg-pjqBrlIixqnydLxsB9qc"
  }
}
```

## Assignment

![Controller/Profile/Normal/Purchased Without Tab Bar](../../../resources/images/controller/profile/normal/purchased-without-tab-bar.png)

1. Please implement the UI. See details on the [Zeplin](https://zpl.io/bzYXEeG).
2. Please implement the `GET /me` and `GET /me/orders?{paging}` APIs. **DO NOT** forget the load-more functionality.

### Note

You haven't created any order yet so orders will be an empty array from the server for this assignment.

The ability to create an order will appear in the later assignments.

### Hint

You can create some fake orders from code to help develop features.