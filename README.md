# Thrillshare

Apptegy plans to offer its school users a gift delivery service. The gifts will be school-branded and
sent to members of the school community through a dedicated section on Thrillshare, our core
product. Apptegy will create the item in-house and send it out for delivery. All the user has to do
within Thrillshare is essentially choose the gift, select the recipient(s), and confirm the order.

## Requirements

Things you need installed:

* Ruby version, `2.7.2`
* Rails version, `6.0.3`
* `Postgresql` installed

## Steps to install the project:

* Clone this repo: 
`git clone git@github.com:Mildred14/thrillshare.git`
* Install dependencies 
`bundle install`
* Create and migrate the database
```
rails db:create
rails db:migrate
```
* Run server
` rails s` or `rails server`
* Then open your browser and look into this url
`http://localhost:3000/`

* Or you can visualize the application deployed in Heroku
[Thrillshare in Heroku!](https://thrillshare.herokuapp.com)

If everything works you'll see a message like this **Yay! You’re on Rails!**

## Create user
This endpoint creates a user which can access the schools, recipients and orders endpoints.

**Request**

`POST - http://localhost:3000/api/v1/signup`

**Body**

```json
{
  "user": {
    "email": "some@email.com",
    "password": "somepassword"
  }
}
```

## Log in the user
This endpoint will return an `Authorization` header which will be used to authenticate the user in the rest of endpoints.

**Request**

`POST - http://localhost:3000/api/v1/login`

**Body**

```json
{
  "user": {
    "email": "some@email.com",
    "password": "somepassword"
  }
}
```

**Note**: The response header will return the `Authorization` with a `Bearer` token. This must be set in all requests to authenticate the user by the `API`

## Schools

### List all schools

**Request**

`GET - http://localhost:3000/api/v1/schools`

### Create a school

**Request**

`POST - http://localhost:3000/api/v1/schools`

**Body**

```json
{
    "school": {
        "name": "Univesidad de Colima",
        "address": "Av Universidad 123"
    }
}
```

#### Update a school

**Request**

`PUT/PATCH - http://localhost:3000/api/v1/schools/1`

**Body**

```json
{
    "school": {
        "name": "Tecnologico de Colima"
    }
}
```

### Delete a school

**Request**

`DELETE - http://localhost:3000/api/v1/schools/1`

## Recipients

### List all recipients

**Request**

`GET - http://localhost:3000/api/v1/schools/1/recipients`

### Create a recipient

**Request**

`POST - http://localhost:3000/api/v1/schools/1/recipients`

**Body**

```json
{
    "recipient": {
        "name": "Mildred Nataly Silva",
        "address": "Av Hidalgo 345"
    }
}
```

### Update a recipient

**Request**

`PUT/PATCH - http://localhost:3000/api/v1/schools/1/recipients/1`

**Body**

```json
{
    "recipient": {
        "address": "Av Morelos"
    }
}
```

### Delete a recipient

**Request**

`DELETE - http://localhost:3000/api/v1/schools/1/recipients/1`

## Orders

### List all orders

**Request**

`GET - http://localhost:3000/api/v1/schools/1/orders`

### Create an order

**Request**

`POST - http://localhost:3000/api/v1/schools/1/orders`

**Body**
* You can only add this gift options: "mug", "t-shirt", "sticker" or "hoodie"

```json
{
    "order": {
      "recipient_ids": ["1"],
      "gifts": ["mug"],
      "notify_delivery": true,
    }
}
```

### Update an order

**Request**

`PUT/PATCH - http://localhost:3000/api/v1/schools/1/orders/1`

**Body**

```json
{
    "order": {
      "recipient_ids": ["3", "2"],
      "gifts": ["mug", "t-shirt"]
    }
}
```

### Cancel an order

An order can only transition to `cancelled` if it was previously in a `processing` status.

**Request**

`POST - http://localhost:3000/api/v1/schools/1/orders/1/cancel`

### Ship an order

An order can only transition to `shipped` if it was previously in a `processing` status.

**Request**

`POST - http://localhost:3000/api/v1/schools/1/orders/1/ship`

### Receive an order

An order can only transition to `received` if it was previously `shipped`.

**Request**

`POST - http://localhost:3000/api/v1/schools/1/orders/1/receive`
