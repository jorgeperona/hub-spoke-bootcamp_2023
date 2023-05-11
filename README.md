# Introduction 
This project deploy a Hub and Spoke Vnet with Azure Firewall and VPN Gateway 

# Getting Started
1.	In Azure DevOps create a new project
2.	Create in Azure an Service Principal (SPN) in Azure Active Directory "App Registration" and copy ApplicationID and Password
3.	Add Owner permission in the Azure Subscription where we want to deploy
4.	In our DevOps project create  in Project Settings an "Azure Service Manager Service Connection" and use our Azure SPN
5.  In Azure DevOps Pipeline Library create two "Variable Groups" terraform-variables-pre and terraform-variables-pro with followings variables (the value depend on the target tenant/subscription:
![image](https://github.com/jorgeperona/hub-spoke-bootcamp_2023/assets/25883484/8392011a-dea0-42e5-b81b-107cd0275cbe)
6. Import this Git in Azure Repos and create one branch for pre and another one for pro environment
7. Import Release Pipelines and verify in Terraform Init and Terraform Apply Task that the Azure Subscription is the Service Manager Connection created in step 4
8. Create Two Pipelines with the "deploy-vnets.yaml" and verify in the Terraform Init and Terraform Apply Task the Azure Subscription.

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
