# Part.15

## User Picture Image

You can get the picture image of a user with his / her id.

```
// The image URL of a user.
http://< website host >/users/< user id >/picture.jpg
```

## Assignment

![Controller/Product List/Normal/Products Without Tab Bar](../../../resources/images/controller/product-list/normal/products-without-tab-bar.png)
![Controller/Product/Normal/Information](../../../resources/images/controller/product/normal/information.gif)

1. Please implement the UI. See details on the [Zeplin](https://zpl.io/bzYXEeG).
2. Please show the product information when selecting a product cell in the product list.
3. Please use the `GET /products/:id` and `GET products/:id/comments?{paging}` APIs from the previous assignment. **DO NOT** forget the load-more functionality for comments.
4. Please use `GCD` to download user pictures.

### Note

The height of cells are dynamic and based on the content.

### Hint

* UITableViewAutomaticDimension
* The push method of UINavigationController