from pydantic import BaseModel
from typing import List, Optional

class NavigationItem(BaseModel):
    id: str
    title: str
    path: str
    icon: Optional[str] = None
    children: Optional[List['NavigationItem']] = None

class Navigation(BaseModel):
    main_nav: List[NavigationItem]
    user_nav: List[NavigationItem]
    admin_nav: List[NavigationItem]

NavigationItem.update_forward_refs()
