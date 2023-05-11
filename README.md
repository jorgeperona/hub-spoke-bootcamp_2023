# Introduction 
This project deploy a Hub and Spoke Vnet with Azure Firewall and VPN Gateway 

# Getting Started
For using with Cloud Gur
1.	Start CloudGuru Sandbox
2.  Get User, User Password, Service ID and Password ID and login with private explorer in Azure Portal
3.	Get SubscriptionID, TenantID, Resource Group Name and Region from Cloud Guru Sandbox
4.  In Azure Devops, go to project Settings and create an Azure Resource Manager Service Connection using Manual SPN. Call it cloudguru-spn(if exists, remove it)
5.  In Azure Devops, Pipelines, edit releases and update task with just created Service Connection
6.	In Azure Devops, Pipelines, Library, update variables with the values of the point 1 and 2
7.  Run CI Pipeline for deploying

# Build and Test
Don't work never in the main branch.
For update, create a new branch based on main branch. Work in the new branch.
Test CI proccess and when you are ready to work, pull the lab branch to main branch.
When request a pull request, CI Pipeline and CD Pipeline will start automatically.


# Contribute
TODO: Explain how other users and developers can contribute to make your code better. 

If you want to learn more about creating good readme files then refer the following [guidelines](https://docs.microsoft.com/en-us/azure/devops/repos/git/create-a-readme?view=azure-devops). You can also seek inspiration from the below readme files:
- [ASP.NET Core](https://github.com/aspnet/Home)
- [Visual Studio Code](https://github.com/Microsoft/vscode)
- [Chakra Core](https://github.com/Microsoft/ChakraCore)