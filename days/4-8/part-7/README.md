# Part.7

## API endpoint [POST /sign-in/facebook]

You can sign in with a valid Facebook access token, and then the server will return a JSON Web Token (JWT) to you. Once you get a JWT, please store it securely. You must use JWT as the authorization method to access the other APIs.

### Request

**Headers**

| Header | Value | Required |
| --- | --- | --- |
| Content-Type | application/json | v |

**Body**

| Parameter | Description | Required |
| --- | --- | --- |
| access_token | A Facebook access token. | v |

Example

```json
{
  "access_token": "EAACEdEose0cBALXlMirnYBYqgNAMwIXyUXD0fpijkNXo3TOHZAcldfRQaM93evxd5dCcBjpSzv1dB5DoAzmk680LnucZBWW6ZBTbiKzHeekvRlwZBY7PCrq7aYGDq8dEH3hPUnFkpqaVrN2cKp7GioVqapCKtS2aGXo0h80rugZAULZCuSumYqLaIv3DZBPQQ2MZD"
}
```

### Response 200 (application/json)

**Body**

| Parameter | Type | Description |
| --- | --- | --- |
| token_type | String | The token type. |
| token | String | A token. |

Example

```json
{
  "data": {
    "token_type": "bearer",
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiI1OTQxMmMwOTg5NjM0YmJmNzQxY2MyZmIiLCJleHAiOjE1Mjg5NzkzMzguODYwNzgsImlhdCI6MTQ5NzQ0MzMzOC44NjA3OCwiaXNzIjoiNThmZWIyMTc3MmU2MmIxMGE3ZTdkMThjIiwidHlwZSI6ImFwcCIsInZlcnNpb24iOiIxLjAifQ.vAg7-nEx2B3GNzFT_I5BoB6MCq557XFh-d1wc_x1t6E"
  }
}
```

## JSON Web Token

* [JSON Web Token](https://jwt.io)

## Postman

* [Postman](https://www.getpostman.com)

## Assignment

1. Please request the `POST /sign-in/facebook` API to get a JWT token and preserve it into `UserDefaults`.

### Hint

* URLSession
* URLRequest

### Note

App Transport Security for non-HTTPs requests.