## Mystorekeeper azure infrastructure (MSK)
MSK is an online Point Of Sales (POS) which comes with many other features such as creating of warehouses, shops, guest and permanent users and many other advanced features. The application was built with four(4) different programing languages and was deployed on `Microsoft Azure`.

## Project Documentation
Click on the link bellow to get access to the Entire Project Documentation: [docs.mystorekeeper.com]()

## Setps to setup mystorekeeper
Mystorekeeper was built using `micro services` architecture. Each functionality of the application runs on its own server. Eg. the signup functionality of the app runs as a stand alone application in `Container App`. To setup the application, do the following:

**Note:** It is recommended to setup your dev and stage environment first then test everything to make sure that everything is working perfectly before setting up the `Production Environment`.

#### Proccess 1:
* Signup For Microsoft Azure.
* Install Azure CLI.
* Install terraform.
* Install Docker
* Setup Dockerhub account.

#### Proccess 2:
* Authenticate to azure using azure cli. 
* authenticate to Dockerhub using cli.


#### Proccess 3:
Deploy the application in the following order:
* az-api-manager
* az-application-insight
* az-content-delivery-network
* az-cosmosdb-database
* az-key-vault
* az-managed-identity
* az-storage-account
* deploy function apps
* deploy container apps