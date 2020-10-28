# API

All endpoints follow the [JSend](https://github.com/omniti-labs/jsend) specification. All parameters must be passed
as JSON in the request body.

## DDPO Information

### The DDPO object
DDPOs have two attributes:
- *id*: Used to uniquely identify organisations
- *name*: The human-readable name of the organisation

### /api/getDDPOs
Retrieves all registered DDPOs.

**Allowed methods:** *GET*

**Request JSON example:** N/A

**Response JSON example:**
``` json
{
    "status": "success",
    "data": [
        {
            "id": 1,
            "name": "Foo DDPO"
        },
        {
            "id": 2,
            "name": "Bar DDPO"
        }  
    ]
}
```

**Notes:** *status* will never be `"fail"`.


### /api/addDDPO
Register a new DDPO.

**Allowed methods:** *POST*

**Request JSON example:**
``` json
{
    "name": "Baz DDPO"
}
```

**Response JSON example:**
``` json
{
    "status": "success",
    "data": {
            "id": 3,
            "name": "Baz DDPO"
    }
}
```

**Notes:** status will be `"fail"` if *name* is absent or of the wrong type.


### /api/updateDDPO
Update an existing DDPO.

**Allowed methods:** *PUT*

**Request JSON example:**
``` json
{   
    "id": 3,
    "name": "Bosh DDPO"
}
```

**Response JSON example:**
``` json
{
    "status": "success",
    "data": {
            "id": 3,
            "name": "Bosh DDPO"
    }
}
```

**Notes:** status will be `"fail"` if *name* or *id* are absent or of the wrong type,
or if no existing DDPO has the given *id*.


### /api/deleteDDPO
Delete an existing DDPO.

**Allowed methods:** *DELETE*

**Request JSON example:**
``` json
{   
    "id": 3
}
```

**Response JSON example:**
``` json
{
    "status": "success",
    "data": null
}
```

**Notes:** status will be `"fail"` if *id* is absent or of the wrong type,
or if no existing DDPO has the given *id*.
