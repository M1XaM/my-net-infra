MyNet Infrastructure

To run use `docker-compose up --build`  
To stop use `docker-compose down [-v]` (where `-v` would erase the db data also)  

For the time run make sure to create certifications for TSL connection to DB, using 
```
cd db
mkdir certs

openssl req -new -x509 -days 365 \
  -nodes -text \
  -out certs/server.crt \
  -keyout certs/server.key \
  -subj "/CN=localhost"

chmod 600 certs/server.key
```  
