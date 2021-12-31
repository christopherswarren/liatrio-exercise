
# liatrio-exercise
This repo contains (or should soon contain) a simple demo api, along with code to run it in a container and deploy that as a workload to a Kubernetes cluster. It will also create the required resources in the cloud on which to run.

## API app
This app, written in node.js, simply listens on a specified port (8080) and provides a simply JSON response from the /time endpoint. It also logs a simple message to the console each time a request is made.

### Usage

Using Docker<br>
- `docker run -p 80:8080 whoha4242/liatrio-exercise`

OR

- `docker compose up`

Using node.js<br>
- `npm install`<br>
- `npm test`<br>
- `npm start`<br>

Then to test

- `curl localhost/time`

Or use your favorite api testing tool such as Postman

```
Method: GET
endpoint: localhost/time
parameters: none
```

You should expect the following response (with the current timestamp)
```json
{"message":"Automate all the things!","timestamp":1640866671}
```

## Unit tests
This repo contains a very simply testing framework using mocha and chai to validate the API

It validates against the <font style="color:teal">/time</font> endpoint that

- The message element of the JSON response says, **"Automate all the things!"**
- The timestamp element of the JSON response actually provides the current UNIX timestamp given as seconds since Jan 1, 1970 (e.g. 1640866671)

## Dockerfile
The included Dockerfile demonstrates a multi stage image build process

The <font style="color:teal">build</font> stage uses a larger node sdk image and performs a few steps

1. Pull in required config, app code, and test code
1. Perform a clean npm install for prod only dependencies
1. Copy those files to a staging folder for later use
1. Perform a full npm install including dev dependencies
1. Run unit tests
1. Run webpack for prod deployment of app code

The <font style="color:teal">release</font> stage uses a small alpine image as its base, and simply adds
- The required node.js runtime package
- The pre-installed node_modules
- The minified server.js file from the webpack process