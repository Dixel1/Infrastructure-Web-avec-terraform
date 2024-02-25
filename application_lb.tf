resource "aws_lb" "alb-schaffnerkelian" {                                                                                               # Déclare une ressource de type 'aws_lb' avec le nom 'alb-schaffnerkelian'
  name                       = "alb-schaffnerkelian"                                                                                    # Attribue le nom 'alb-schaffnerkelian' à cet équilibreur de charge
  internal                   = false                                                                                                    # Spécifie que cet équilibreur de charge n'est pas interne
  load_balancer_type         = "application"                                                                                            # Spécifie le type de l'équilibreur de charge comme 'application'
  security_groups            = [aws_security_group.sg_lb_to_app_schaffnerkelian.id, aws_security_group.sg_app_to_lb_schaffnerkelian.id] # Spécifie les groupes de sécurité à associer à l'équilibreur de charge
  subnets                    = ["subnet-0e3b5a73eb879dbe8", "subnet-03818601518f096d0"]                                                 # Spécifie les sous-réseaux dans lesquels l'équilibreur de charge doit être déployé
  enable_deletion_protection = false                                                                                                    # Spécifie si la protection contre la suppression doit être activée pour l'équilibreur de charge
  tags = {                                                                                                                              # Définit les métadonnées pour l'équilibreur de charge sous forme de paires clé-valeur
    Name = "alb-schaffnerkelian"                                                                                                        # Attribue le nom 'alb-schaffnerkelian' à cet équilibreur de charge
  }
}

resource "aws_lb_listener" "listener-schaffnerkelian" {           # Déclare une ressource de type 'aws_lb_listener' avec le nom 'listener-schaffnerkelian'
  load_balancer_arn = aws_lb.alb-schaffnerkelian.arn              # Spécifie l'ARN de l'équilibreur de charge auquel cet auditeur est associé
  port              = "80"                                        # Spécifie le port sur lequel l'auditeur doit écouter
  protocol          = "HTTP"                                      # Spécifie le protocole que l'auditeur doit utiliser
  default_action {                                                # Définit l'action par défaut que l'auditeur doit prendre
    type             = "forward"                                  # Spécifie le type d'action comme 'forward' (transfert)
    target_group_arn = aws_lb_target_group.tg-schaffnerkelian.arn # Spécifie l'ARN du groupe cible vers lequel le trafic doit être transféré
  }
}

resource "aws_lb_target_group" "tg-schaffnerkelian" { # Déclare une ressource de type 'aws_lb_target_group' avec le nom 'tg-schaffnerkelian'
  name     = "tg-schaffnerkelian"                     # Attribue le nom 'tg-schaffnerkelian' à ce groupe cible
  port     = 80                                       # Spécifie le port sur lequel le groupe cible doit recevoir le trafic
  protocol = "HTTP"                                   # Spécifie le protocole que le groupe cible doit utiliser
  vpc_id   = "vpc-0049682c1b010a070"                  # Spécifie l'ID du VPC dans lequel le groupe cible doit être déployé
}
