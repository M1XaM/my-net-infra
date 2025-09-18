from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from router import router


app = FastAPI()

app.include_router(router)

origins = [
    "http://localhost:3000",  # frontend dev server
    "http://127.0.0.1:3000",  # sometimes different loopback
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

##run code:  uvicorn main:app --reload

OAUTH_GOOGLE_CLIENT_ID_2 = '93516826929-7l14n8p9tsb8h40afho38mjm3qua881q.apps.googleusercontent.com'
OAUTH_GOOGLE_CLIENT_SECRET_2 = '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'
