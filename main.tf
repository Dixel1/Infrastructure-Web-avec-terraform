terraform {                     # Bloc de configuration de Terraform
  required_providers {          # Définit les fournisseurs nécessaires pour ce code Terraform
    aws = {                     # Définit le fournisseur AWS
      source  = "hashicorp/aws" # Spécifie la source du fournisseur, ici 'hashicorp/aws'
      version = "~> 5.0"        # Spécifie la version du fournisseur, ici une version compatible avec la version 5.0
    }
  }
}

provider "aws" {       # Déclare un fournisseur de type 'aws'
  region = "eu-west-1" # Spécifie la région AWS pour ce fournisseur, ici 'eu-west-1'
}
