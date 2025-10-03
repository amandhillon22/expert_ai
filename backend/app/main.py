from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session
from passlib.context import CryptContext

# Import the new modules we created
from . import models, schemas
from .database import SessionLocal, engine

# This line creates the database tables if they don't exist
models.Base.metadata.create_all(bind=engine)

app = FastAPI()

# Password Hashing Setup
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# Dependency to get a DB session
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.get("/")
def read_root():
    return {"message": "Welcome to the API!"}

@app.post("/register/")
def create_user(user: schemas.UserCreate, db: Session = Depends(get_db)):
    # Check if user with that email already exists
    db_user = db.query(models.User).filter(models.User.email == user.email).first()
    if db_user:
        raise HTTPException(status_code=400, detail="Email already registered")

    # Hash the password before storing
    hashed_password = pwd_context.hash(user.password)

    # Create a new User database object
    new_user = models.User(
        email=user.email,
        full_name=user.full_name,
        hashed_password=hashed_password
    )

    # Add to the database and save
    db.add(new_user)
    db.commit()
    db.refresh(new_user)

    # Return the new user's info (without the password)
    return {"id": new_user.id, "email": new_user.email, "full_name": new_user.full_name}