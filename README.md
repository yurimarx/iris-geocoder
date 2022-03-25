# iris-geocoder
Geocoding using IRIS and Python geocoder library

## Installation
1. Clone/git pull the repo into any local directory

```
$ git clone https://github.com/yurimarx/iris-geocoder.git
```

2. Open a Docker terminal in this directory and run:

```
$ docker-compose build
```

3. Run the IRIS container:

```
$ docker-compose up -d 
```

4. **For Geocoding your current IP:** Go to your Postman (or other similar REST client) and config the request like this and click send to see the results:

![Geocoding your current IP](https://github.com/yurimarx/iris-geocoder/raw/main/myip.png "Geocoding your current IP")

- Method: GET
- URL: http://localhost:52773/iris-geocoder/myip 

5. **For Geocoding a particular IP:** Go to your Postman (or other similar REST client) and config the request like this and click send to see the results:

![Geocoding a particular IP](https://github.com/yurimarx/iris-geocoder/raw/main/ip.png "Geocoding a particular IP")

- Method: GET
- URL: http://localhost:52773/iris-geocoder/ip?IP=23.73.233.140 (this IP for InterSystems Site. You can choose another if you want) 

6. **For Geocoding an address:** Go to your Postman (or other similar REST client) and config the request like this and click send to see the results:

![Geocoding an Address](https://github.com/yurimarx/iris-geocoder/raw/main/forward.png "Geocoding an address")

- Method: POST
- URL: http://localhost:52773/iris-geocoder/forward  
- Body: raw
- Body text: One Memorial Drive, Cambridge, MA (or any another address you want)

7. **For Geocoding a Lat/Long point:** Go to your Postman (or other similar REST client) and config the request like this and click send to see the results:

![Geocoding a Lat/Long point](https://github.com/yurimarx/iris-geocoder/raw/main/reverse.png "Geocoding a Lat/Long point")

- Method: GET
- URL: http://localhost:52773/iris-geocoder/reverse?Lat=42.36261323029149&Long=-71.08003151970848  


# Configure your Google account to use google functions
To use http://localhost:52773/iris-geocoder/forward or http://localhost:52773/iris-geocoder/reverse you must have a Google account and have a payment plan active and configured. So you can generate your Google API Key and put it inside Dockerfile line 31:

ENV GOOGLE_API_KEY=YOUR-API-KEY-HERE

See detailed instructions on: https://developers.google.com/maps/get-started

# Credits
This application used geocoder project

