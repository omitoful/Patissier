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
    "id": "967EECD7-2FF9-4355-AF3F-39E96AFFACEB",
    "first_name": "Roy",
    "last_name": "Hsu",
    "name": "Roy Hsu"
  }
}
```

## API endpoint [GET /me/orders?{offset,count}]

You can retrieve the data of your orders using this endpoint.

### Request

**Headers**

| Header | Value | Required |
| --- | --- | --- |
| Authorization | Bearer < jwt token > | v |

**Query**

| Parameter | Description | Required |
| --- | --- | --- |
| offset | The offset of retrieving orders. | |
| count | The number of retrieving orders. | |

Example

```
// For the first page of orders.
GET /orders
```

Example

```
// For the certain offset and count of orders.
GET /orders?offset=3&count=5
```

### Response 200 (application/json)

**Body**

| Parameter | Description |
| --- | --- |
| order.id | The order id. |
| order.items | The items in the order. |
| order.total_amount | The total amount of the order. |
| order.created | The created date of the order. |
| paging.next | The next page token. |

Example

```json
{
  "data": [
    {
      "id": "57ED2EB3-01CD-4149-A5C1-02F99994B091",
      "items": [
        {
          "id": "FC2E838E-9372-4760-BD89-101D5A8064B9",
          "type": "PRODUCT",
          "quantity": 2
        }
      ]
      "total_amount": 200,
      "created": "2018-11-26T11:04:06.134Z"
    }
  ]
}
```

## Assignment

![Controller/Profile/Normal/Purchased Without Tab Bar](../../../resources/images/controller/profile/normal/purchased-without-tab-bar.png)

1. Please implement the UI. See details on the [Zeplin](https://zpl.io/bzYXEeG).
2. Please implement the `GET /me` and `GET /me/orders?{offset,count}` APIs. **DO NOT** forget the load-more functionality.

### Note

You haven't created any order yet so orders will be an empty array from the server for this assignment.

The ability to create an order will appear in the later assignments.

### Hint

You can create some fake orders from code to help develop features.
