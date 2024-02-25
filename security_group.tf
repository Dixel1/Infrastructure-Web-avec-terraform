resource "aws_default_vpc" "default" { # Déclare une ressource de type 'aws_default_vpc' avec le nom 'default'
  tags = {                             # Définit les métadonnées pour la ressource sous forme de paires clé-valeur
    Name = "Default VPC"               # Attribue le nom 'Default VPC' à cette ressource
  }
}

resource "aws_security_group" "sg_lb_to_app_schaffnerkelian" { # Déclare une ressource de type 'aws_security_group' avec le nom 'sg_lb_to_app_schaffnerkelian'
  name   = "schaffnerkelian-lb-to-app"                         # Attribue le nom 'schaffnerkelian-lb-to-app' à cette ressource
  vpc_id = aws_default_vpc.default.id                          # Associe cette ressource au VPC par défaut
  #vpc_id = "vpc-0049682c1b010a070"                             # Une autre façon d'associer cette ressource à un VPC spécifique en utilisant son ID
}

resource "aws_security_group_rule" "sgr_lb_to_app_in_schaffnerkelian" {  # Déclare une ressource de type 'aws_security_group_rule' avec le nom 'sgr_lb_to_app_in_schaffnerkelian'
  type              = "ingress"                                          # Définit le type de la règle comme 'ingress' (entrante)
  from_port         = 80                                                 # Définit le port de départ de la règle comme '80'
  to_port           = 80                                                 # Définit le port d'arrivée de la règle comme '80'
  protocol          = "tcp"                                              # Définit le protocole de la règle comme 'tcp'
  cidr_blocks       = ["0.0.0.0/0"]                                      # Définit les blocs CIDR pour la règle, ici il autorise tout le trafic entrant
  security_group_id = aws_security_group.sg_lb_to_app_schaffnerkelian.id # Associe cette règle au groupe de sécurité 'sg_lb_to_app_schaffnerkelian'
}

resource "aws_security_group_rule" "sgr_lb_to_app_out_schaffnerkelian" { # Déclare une ressource de type 'aws_security_group_rule' avec le nom 'sgr_lb_to_app_out_schaffnerkelian'
  type              = "egress"                                           # Définit le type de la règle comme 'egress' (sortante)
  from_port         = 0                                                  # Définit le port de départ de la règle comme '0'
  to_port           = 0                                                  # Définit le port d'arrivée de la règle comme '0'
  protocol          = -1                                                 # Définit le protocole de la règle comme '-1', ce qui signifie tous les protocoles
  cidr_blocks       = ["0.0.0.0/0"]                                      # Définit les blocs CIDR pour la règle, ici il autorise tout le trafic sortant
  security_group_id = aws_security_group.sg_lb_to_app_schaffnerkelian.id # Associe cette règle au groupe de sécurité 'sg_lb_to_app_schaffnerkelian'
}

resource "aws_security_group" "sg_app_to_lb_schaffnerkelian" { # Déclare une ressource de type 'aws_security_group' avec le nom 'sg_app_to_lb_schaffnerkelian'
  name   = "schaffnerkelian-app-to-lb"                         # Attribue le nom 'schaffnerkelian-app-to-lb' à cette ressource
  vpc_id = aws_default_vpc.default.id                          # Associe cette ressource au VPC par défaut
  #vpc_id = "vpc-0049682c1b010a070"                             # Une autre façon d'associer cette ressource à un VPC spécifique en utilisant son ID
}


resource "aws_security_group_rule" "sgr_app_to_lb_in_schaffnerkelian" {  # Déclare une ressource de type 'aws_security_group_rule' avec le nom 'sgr_app_to_lb_in_schaffnerkelian'
  type              = "ingress"                                          # Définit le type de la règle comme 'ingress' (entrante)
  from_port         = 80                                                 # Définit le port de départ de la règle comme '80'
  to_port           = 80                                                 # Définit le port d'arrivée de la règle comme '80'
  protocol          = "tcp"                                              # Définit le protocole de la règle comme 'tcp'
  cidr_blocks       = ["0.0.0.0/0"]                                      # Définit les blocs CIDR pour la règle, ici il autorise tout le trafic entrant
  security_group_id = aws_security_group.sg_app_to_lb_schaffnerkelian.id # Associe cette règle au groupe de sécurité 'sg_app_to_lb_schaffnerkelian'
}

resource "aws_security_group_rule" "sgr_app_to_lb_out_schaffnerkelian" { # Déclare une ressource de type 'aws_security_group_rule' avec le nom 'sgr_app_to_lb_out_schaffnerkelian'
  type              = "egress"                                           # Définit le type de la règle comme 'egress' (sortante)
  from_port         = 0                                                  # Définit le port de départ de la règle comme '0'
  to_port           = 0                                                  # Définit le port d'arrivée de la règle comme '0'
  protocol          = -1                                                 # Définit le protocole de la règle comme '-1', ce qui signifie tous les protocoles
  cidr_blocks       = ["0.0.0.0/0"]                                      # Définit les blocs CIDR pour la règle, ici il autorise tout le trafic sortant
  security_group_id = aws_security_group.sg_app_to_lb_schaffnerkelian.id # Associe cette règle au groupe de sécurité 'sg_app_to_lb_schaffnerkelian'
}

resource "aws_security_group" "sgssh-schaffnerkelian" {      # Déclare une ressource de type 'aws_security_group' avec le nom 'sgssh-schaffnerkelian'
  name        = "sgssh-schaffnerkelian"                      # Attribue le nom 'sgssh-schaffnerkelian' à cette ressource
  description = "Allow inbound SSH access from the internet" # Définit la description de cette ressource
  ingress {                                                  # Définit les règles d'entrée pour ce groupe de sécurité
    from_port   = 22                                         # Définit le port de départ de la règle comme '22'
    to_port     = 22                                         # Définit le port d'arrivée de la règle comme '22'
    protocol    = "tcp"                                      # Définit le protocole de la règle comme 'tcp'
    cidr_blocks = ["0.0.0.0/0"]                              # Définit les blocs CIDR pour la règle, ici il autorise tout le trafic entrant
  }
  egress {                      # Définit les règles de sortie pour ce groupe de sécurité
    from_port   = 0             # Définit le port de départ de la règle comme '0'
    to_port     = 0             # Définit le port d'arrivée de la règle comme '0'
    protocol    = -1            # Définit le protocole de la règle comme '-1', ce qui signifie tous les protocoles
    cidr_blocks = ["0.0.0.0/0"] # Définit les blocs CIDR pour la règle, ici il autorise tout le trafic sortant
  }
}


#FIRST ATTEMPT TO CREATE SECURITY_GROUP_RULES, ONLY FOR TESTING

# create a a security group rule that gives inbound access to the loadbalancer
#resource "aws_security_group" "sglb-schaffnerkelian" {
#  name        = "sglb-schaffnerkelian"
#  description = "Allow inbound access to the loadbalancer"
#  ingress {
#    from_port   = 80
#    to_port     = 80
#    protocol    = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]
#security_groups = [aws_security_group.sghttp-schaffnerkelian.id]
#  }
# egress {
#   from_port   = 0
#  to_port     = 0
# protocol    = "-1"
#cidr_blocks = ["0.0.0.0/0"]
#}
#}

# create a security group rule that provides inbound ssh access from the internet
#resource "aws_security_group" "sgssh-schaffnerkelian" {
#  name        = "sgssh-schaffnerkelian"
#  description = "Allow inbound SSH access from the internet"
#  ingress {
#   from_port   = 22
#   to_port     = 22
#   protocol    = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = -1
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#}

# create a security group from the internet to EC2 port 80 
#resource "aws_security_group" "sghttp-schaffnerkelian" {
# name        = "sghttp-schaffnerkelian"
# description = "Allow inbound HTTP access from the internet"
# ingress {
#  from_port   = 80
#  to_port     = 80
#  protocol    = "tcp"
#  cidr_blocks = ["0.0.0.0/0"]
#security_groups = [aws_security_group.sglb-schaffnerkelian.id]
# }
# egress {
#  from_port   = 0
#  to_port     = 0
#  protocol    = -1
#  cidr_blocks = ["0.0.0.0/0"]
# }
#}