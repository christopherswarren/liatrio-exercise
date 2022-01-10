
# liatrio-exercise
This repo contains a simple demo api, along with code to run it in a container and deploy that as a workload to a Kubernetes cluster. It will also create the required resources in the Azure cloud on which to run.

# Demo Prerequisites

## 1. Azure Subscription

You'll need an Azure Subscription to use the `azurerm` terraform provider included in this demo. Please see [this link](https://docs.microsoft.com/en-us/azure/cost-management-billing/manage/create-subscription) for more details.

You must then retrieve your azure subscription ID, and generate a service principal.

```
az login

az account list

az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/SUBSCRIPTION_ID"
```

The SPN create command will output a list of values similar to this:

```json
{
  "appId": "00000000-0000-0000-0000-000000000000",
  "displayName": "azure-cli-2017-06-05-10-41-15",
  "name": "http://azure-cli-2017-06-05-10-41-15",
  "password": "0000-0000-0000-0000-000000000000",
  "tenant": "00000000-0000-0000-0000-000000000000"
}
```

You must then store the appId in your GitHub Secrets as `AZ_CLIENT_ID` and the password as `AZ_CLIENT_SECRET`

![GitHub Secrets](https://github.com/whoha4242/liatrio-exercise/raw/main/attachments/githubsecrets.png)

## 2. Terraform Cloud Org and Workspace (optional)

You may choose to simply run the terraform locally, or set up cloud storage to manage state files from cloud hosted CICD agents/runners, but I chose to solve that by using [Terraform Cloud](https://app.terraform.io/).

To do so, you simply need an account, and a workspace configured for API triggers. You then need to generate a **Team API Token** and store it in a secret in GitHub Actions as `TF_API_TOKEN` as shown above.

![TF Cloud Team Token](https://github.com/whoha4242/liatrio-exercise/raw/main/attachments/TFCloudTeamToken.png)

Using Terraform Cloud you'll also need to configure your variables in TF Cloud as documented in the included [Terraform README](https://github.com/whoha4242/liatrio-exercise/tree/main/terraform#readme)

## 3. Docker Hub Account

You'll need a [Docker Hub]() account to run the demo pipeline as configured. You could of course use your own public or private container registry, but that would entail many other changes. Just store your docker user in the pipeline.yml file as `dockeruser` and your docker password in the GitHub Actions Secret as `DOCKERPASSWORD` as shown above.

# Demo Usage

Once you've met the above prerequisites, you should be able to simply run the GitHub workflow defined in the `pipeline.yml` file. You may do this by committing code to the main branch, or simply by manually kicking off the workflow.

Once the pipeline run is complete, it will let you know whether it was able to validate the deployment. If successful, you can manually validate by following the generated link in the validate content step

![Follow this link](https://github.com/whoha4242/liatrio-exercise/raw/main/attachments/validation.png)

## Cleanup

Run the provided GitHub Actions Terraform Destroy pipeline. This kicks off a destroy plan via Terraform Cloud

![Terraform Destroy Pipeline](https://github.com/whoha4242/liatrio-exercise/raw/main/attachments/tfdestroy.png)

Alternatively, if you are using terraform locally, simply run

`terraform destroy`

# Components

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

## Terraform Infrastructure as Code

The included `/terraform/aks-cluster.tf` file (and its several associated terraform config files) is used to create an AKS cluster in Azure as well as remove it when finished.

You must have terraform cli installed on your system to use locally

**Usage**

Local:
```
cd terraform
terraform init
terraform plan
terraform apply
```

Then to remove resources when finished:
```
terraform destroy
```

Terraform Cloud

1. Fork this repo to your github account
1. Create an organization at app.terraform.io
1. Within Terraform cloud, link to your new fork of this repo using the GitHub selection
1. Select the `/terraform` folder as the working folder for Terraform cloud
1. Create variables in your TF Cloud Org for each of the variables included in the `variables.tf` and `terraform.tfvars` files
1. Start a plan from TF Cloud

<demo2>
<demo3>
<demo4>