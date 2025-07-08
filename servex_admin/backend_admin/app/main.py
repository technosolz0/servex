from fastapi import FastAPI
from fastapi.openapi.utils import get_openapi
from app.api.routes import category_routes, user_routes  # ✅ import your combined users router here
from app.database import Base, engine
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles

app = FastAPI()

app.mount("/static", StaticFiles(directory="static"), name="static")
Base.metadata.create_all(bind=engine)

# CORS config
origins = [
    "http://localhost:3000",
    # Add production origins here
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ✅ Include routers
app.include_router(user_routes.router, prefix="/api")         # combined user management + auth routes
app.include_router(category_routes.router, prefix="/api")

# ✅ Swagger Bearer Token config
def custom_openapi():
    if app.openapi_schema:
        return app.openapi_schema
    openapi_schema = get_openapi(
        title="Servex API",
        version="1.0.0",
        description="Custom FastAPI with JWT Auth",
        routes=app.routes,
    )
    openapi_schema["components"]["securitySchemes"] = {
        "BearerAuth": {
            "type": "http",
            "scheme": "bearer",
            "bearerFormat": "JWT"
        }
    }
    for path in openapi_schema["paths"]:
        for method in openapi_schema["paths"][path]:
            if method in ["get", "post", "put", "delete", "patch"]:
                openapi_schema["paths"][path][method]["security"] = [{"BearerAuth": []}]
    app.openapi_schema = openapi_schema
    return app.openapi_schema

app.openapi = custom_openapi

@app.get("/")
def root():
    return {"message": "Servex API is running ✅"}
