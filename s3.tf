resource "aws_s3_bucket" "ynov-infracloud-schaffnerkelian" { # Déclare une ressource de type 'aws_s3_bucket' avec le nom 'ynov-infracloud-schaffnerkelian'
  bucket = "ynov-infracloud-schaffnerkelian"                 # Attribue le nom 'ynov-infracloud-schaffnerkelian' à ce bucket
}

resource "aws_s3_object" "puppy" {                          # Déclare une ressource de type 'aws_s3_object' avec le nom 'puppy'
  bucket = aws_s3_bucket.ynov-infracloud-schaffnerkelian.id # Spécifie le bucket dans lequel l'objet sera stocké
  key    = "assets/puppy.jpg"                               # Définit la clé de l'objet, qui est essentiellement son nom dans le bucket
  source = "assets/puppy.jpg"                               # Spécifie le chemin du fichier local qui sera téléchargé dans le bucket S3
}

resource "aws_s3_bucket_public_access_block" "ynov-infracloud-schaffnerkelian" { # Déclare une ressource de type 'aws_s3_bucket_public_access_block' avec le nom 'ynov-infracloud-schaffnerkelian'
  bucket                  = aws_s3_bucket.ynov-infracloud-schaffnerkelian.id     # Spécifie le bucket auquel ce bloc d'accès public est associé
  block_public_acls       = false                                                # Détermine si Amazon S3 devrait bloquer les ACL publics pour ce bucket
  block_public_policy     = false                                                # Détermine si Amazon S3 devrait bloquer les politiques publiques pour ce bucket
  ignore_public_acls      = false                                                # Détermine si Amazon S3 devrait ignorer les ACL publics pour ce bucket
  restrict_public_buckets = false                                                # Détermine si Amazon S3 devrait restreindre l'accès public à ce bucket
}

resource "aws_s3_bucket_policy" "ynov-infracloud-schaffnerkelian" {                # Déclare une ressource de type 'aws_s3_bucket_policy' avec le nom 'ynov-infracloud-schaffnerkelian'
  bucket     = aws_s3_bucket.ynov-infracloud-schaffnerkelian.id                    # Spécifie le bucket auquel cette politique est associée
  depends_on = [aws_s3_bucket_public_access_block.ynov-infracloud-schaffnerkelian] # Spécifie que cette ressource dépend du bloc d'accès public 'ynov-infracloud-schaffnerkelian'
  policy = jsonencode({                                                            # Définit la politique du bucket en utilisant la fonction 'jsonencode' pour convertir un objet HCL en une chaîne JSON
    Version = "2012-10-17",                                                        # Spécifie la version de la politique
    Statement = [                                                                  # Définit une ou plusieurs déclarations de politique
      {
        Effect    = "Allow",                                                  # Spécifie l'effet de la déclaration, ici 'Allow' pour autoriser l'accès
        Principal = "*",                                                      # Spécifie le principal qui est autorisé à accéder aux ressources, ici '*' pour tout le monde
        Action    = "s3:GetObject",                                           # Spécifie l'action qui est autorisée, ici 's3:GetObject' pour permettre de récupérer des objets
        Resource  = "${aws_s3_bucket.ynov-infracloud-schaffnerkelian.arn}/*", # Spécifie la ressource sur laquelle l'action est autorisée, ici tous les objets du bucket 'ynov-infracloud-schaffnerkelian'
      },
    ],
  })
}

