﻿from fastapi import FastAPI
from enum import Enum

from pydantic import BaseModel


class ModelName(str, Enum):
    alexnet = "alexnet"
    resnet = "resnet"
    lenet = "lenet"


class Item(BaseModel):
    name: str
    description: str | None = None
    price: float
    tax: float | None = None



fake_items_db = [{"item_name": "Foo"}, {"item_name": "Bar"}, {"item_name": "Baz"}]

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/items/")
async def read_item(skip: int = 0, limit: int = 10):
    return fake_items_db[skip : skip + limit]


@app.post("/items/")
async def create_item(item: Item):
    return item


@app.get("/items/{item_id}")
async def read_item(item_id: str, q: str | None = None, short: bool = False):
    item = {"item_id": item_id}
    if q:
        item.update({"q": q})
    if not short:
        item.update(
            {"description": "This is an amazing item that has a long description"}
        )
    return item


@app.get("/models/{model_name}")
async def get_model(model_name: ModelName):
    if model_name is ModelName.alexnet:
        return {"model_name": model_name, "message": "Deep Learning FTW!"}

    if model_name.value == "lenet":
        return {"model_name": model_name, "message": "LeCNN all the images"}

    return {"model_name": model_name, "message": "Have some residuals"}


@app.get("/files/{file_path:path}")
async def read_file(file_path: str):
    return {"file_path": file_path}


