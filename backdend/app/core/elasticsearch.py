from elasticsearch import Elasticsearch
from typing import Optional

_es_client: Optional[Elasticsearch] = None

def get_elasticsearch() -> Elasticsearch:
    """Get Elasticsearch client instance"""
    global _es_client
    if _es_client is None:
        _es_client = Elasticsearch(["http://localhost:9200"])
    return _es_client

def init_elasticsearch():
    """Initialize Elasticsearch indices"""
    es = get_elasticsearch()
    
    # Create dish index if not exists
    if not es.indices.exists(index="dishes"):
        es.indices.create(
            index="dishes",
            body={
                "mappings": {
                    "properties": {
                        "dish_id": {"type": "keyword"},
                        "name": {"type": "text"},
                        "description": {"type": "text"},
                        "price": {"type": "float"},
                        "availability": {"type": "integer"},
                        "quantity": {"type": "integer"}
                    }
                }
            }
        )

def index_dish(dish_data: dict):
    """Index dish data to Elasticsearch"""
    es = get_elasticsearch()
    es.index(
        index="dishes",
        id=dish_data["dish_id"],
        body=dish_data
    )

def update_dish_availability(dish_id: str, availability: int):
    """Update dish availability in Elasticsearch"""
    es = get_elasticsearch()
    es.update(
        index="dishes",
        id=dish_id,
        body={
            "doc": {
                "availability": availability
            }
        }
    )

def search_dishes(query: str, min_price: float = None, max_price: float = None):
    """Search dishes by name, description and price range"""
    es = get_elasticsearch()
    
    must_conditions = [
        {
            "multi_match": {
                "query": query,
                "fields": ["name", "description"]
            }
        }
    ]

    if min_price is not None or max_price is not None:
        range_query = {"range": {"price": {}}}
        if min_price is not None:
            range_query["range"]["price"]["gte"] = min_price
        if max_price is not None:
            range_query["range"]["price"]["lte"] = max_price
        must_conditions.append(range_query)

    body = {
        "query": {
            "bool": {
                "must": must_conditions
            }
        }
    }

    return es.search(index="dishes", body=body)
