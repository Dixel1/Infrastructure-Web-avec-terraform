resource "aws_autoscaling_group" "asg-schaffnerkelian" {            # Déclare une ressource de type 'aws_autoscaling_group' avec le nom 'asg-schaffnerkelian'
  name              = "asgschaffnerkelian"                          # Attribue le nom 'asgschaffnerkelian' à ce groupe d'auto-scaling
  max_size          = 2                                             # Spécifie la taille maximale du groupe d'auto-scaling
  min_size          = 1                                             # Spécifie la taille minimale du groupe d'auto-scaling
  desired_capacity  = 2                                             # Spécifie la capacité désirée du groupe d'auto-scaling
  target_group_arns = [aws_lb_target_group.tg-schaffnerkelian.arn]  # Spécifie les ARN des groupes cibles pour le groupe d'auto-scaling
  launch_template {                                                 # Définit le modèle de lancement pour le groupe d'auto-scaling
    id      = aws_launch_template.launchtemplate-schaffnerkelian.id # Spécifie l'ID du modèle de lancement
    version = "$Latest"                                             # Spécifie la version du modèle de lancement, ici la dernière version
  }
  availability_zones = ["eu-west-1a"] # Spécifie les zones de disponibilité pour le groupe d'auto-scaling
}
