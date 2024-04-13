# Infrastructure-Web-avec-terraform


Ce projet utilise Terraform pour déployer une infrastructure AWS. Il comprend un groupe d'auto-scaling, un équilibreur de charge d'application, des groupes de sécurité, un bucket S3 et bien d'autres ressources.
Il comprend les éléments suivants :

- Modèle de lancement (Launch Template) : Il sert de modèle pour le lancement d’instances EC2. Il spécifie l’image AMI, le type d’instance, la paire de clés et les interfaces réseau pour les instances.
- Groupe d’auto-scaling (Auto Scaling Group) : Il gère le nombre d’instances EC2 en fonction de la demande. Il peut augmenter ou diminuer le nombre d’instances en fonction de la charge de travail.
- Équilibreur de charge d’application (Application Load Balancer) : Il distribue le trafic entrant entre plusieurs instances EC2 dans plusieurs zones de disponibilité. Il assure également la santé de ses instances enregistrées et ne transfère le trafic qu’aux instances saines.
- Auditeur (Listener) : Il écoute sur le port 80 et transfère le trafic vers un groupe cible.
Groupe cible (Target Group) : Il reçoit le trafic sur le port 80 dans le VPC spécifié.
- Bucket S3 : Il sert de stockage pour les objets. Vous pouvez stocker n’importe quel nombre d’objets dans un bucket.
Objet S3 : Il est stocké dans le bucket S3. Un objet S3 est essentiellement un fichier et toutes ses métadonnées associées.
- Groupes de sécurité (Security Groups) : Ils contrôlent le trafic vers et depuis les instances EC2. Vous pouvez ajouter des règles à chaque groupe de sécurité qui permettent le trafic vers ou depuis ses instances associées.
- Paire de clés (Key Pair) : Elle est utilisée pour prouver votre identité lors de la connexion à une instance EC2. Elle se compose d’une clé publique qui est utilisée pour chiffrer les données de connexion et d’une clé privée que vous utilisez pour déchiffrer les données de connexion.

#### NOTE : Le code est commenté pour faciliter son explication, son éventuelle modification, et son cheminement de pensée.

Description globale des fichiers Terraform et de leur utilité :
- **[application_lb.tf](https://github.com/Dixel1/Infrastructure-Web-avec-terraform_K-lianSCHAFFNER/blob/main/application_lb.tf)** : Ce fichier configure un équilibreur de charge d’application qui écoute sur le port 80 et transfère le trafic vers un groupe cible spécifique dans un VPC spécifique. Les groupes de sécurité appropriés sont associés à l’équilibreur de charge pour assurer la sécurité du trafic.
- **[auto_scaling.tf](https://github.com/Dixel1/Infrastructure-Web-avec-terraform_K-lianSCHAFFNER/blob/main/auto_scaling.tf)** : Ce fichier configure un groupe d’auto-scaling qui peut automatiquement ajuster le nombre d’instances en fonction de la charge de travail. Il est associé à un groupe cible spécifique et utilise un modèle de lancement pour créer de nouvelles instances. Les instances sont déployées dans une zone de disponibilité spécifique pour assurer la haute disponibilité.
- **[launch_template](https://github.com/Dixel1/Infrastructure-Web-avec-terraform_K-lianSCHAFFNER/blob/main/launch_template.tf)** : Configure un modèle de lancement qui spécifie comment les nouvelles instances doivent être lancées, et une paire de clés qui est utilisée pour l’authentification SSH. Ces configurations sont essentielles pour le déploiement et la gestion des instances AWS.
- **[main.tf](https://github.com/Dixel1/Infrastructure-Web-avec-terraform_K-lianSCHAFFNER/blob/main/main.tf)** : Configure le fournisseur AWS et sa version pour être utilisé avec ce code Terraform. Il spécifie également la région AWS à utiliser pour ce fournisseur. Ces configurations sont essentielles pour le déploiement et la gestion des ressources AWS avec Terraform.
- **[s3.tf](https://github.com/Dixel1/Infrastructure-Web-avec-terraform_K-lianSCHAFFNER/blob/main/s3.tf)** : Configure un bucket S3 pour stocker des objets, un objet S3 pour stocker des données, un bloc d’accès public pour contrôler l’accès public au bucket, et une politique de bucket pour définir les autorisations d’accès au bucket et à ses objets. Ces configurations sont essentielles pour le stockage et la gestion des données sur AWS S3.
- **[security_group](https://github.com/Dixel1/Infrastructure-Web-avec-terraform_K-lianSCHAFFNER/blob/main/security_group.tf)** : Configure un VPC par défaut, trois groupes de sécurité et leurs règles associées pour contrôler le trafic entrant et sortant ainsi que la connexion par SSH. Ces configurations sont essentielles pour la gestion de la sécurité du réseau sur AWS.


## Prérequis

- Terraform v0.14.0 ou supérieur
- Un compte AWS avec les permissions appropriées
- AWS CLI configuré avec vos identifiants AWS

## Utilisation

1. Clonez ce dépôt sur votre machine locale.
2. Naviguez jusqu'au répertoire du projet.
3. Initialisez votre environnement Terraform avec `terraform init`.
4. Vérifiez le plan d'exécution avec `terraform plan`.
5. Appliquez le plan avec `terraform apply`.

## Ressources AWS créées

- **aws_launch_template.launchtemplate-schaffnerkelian** : Modèle de lancement pour les instances EC2.
- **aws_autoscaling_group.asg-schaffnerkelian** : Groupe d'auto-scaling pour gérer le nombre d'instances EC2.
- **aws_lb.alb-schaffnerkelian** : Équilibreur de charge d'application pour distribuer le trafic entre les instances EC2.
- **aws_lb_listener.listener-schaffnerkelian** : Auditeur pour l'équilibreur de charge d'application.
- **aws_lb_target_group.tg-schaffnerkelian** : Groupe cible pour l'équilibreur de charge d'application.
- **aws_s3_bucket.ynov-infracloud-schaffnerkelian** : Bucket S3 pour le stockage des objets.
- **aws_s3_object.puppy** : Objet S3 stocké dans le bucket.
- **aws_security_group** : Groupes de sécurité pour contrôler le trafic vers et depuis les instances EC2.

## Difficultés rencontrées et méthode de résolution :

- La gestion des groupes de sécurité a été un peu délicate, il est simple de se perdre dans les groupes de sécurité à associer aux services :
    - Correspondance des règles de sécurité : S'assurer que les règles de sécurité des groupes de sécurité associés à l'équilibreur de charge autorisent le trafic entrant sur le port que l'équilibreur de charge écoute (dans notre cas, le port 80).
    - Communication entre l’équilibreur de charge et les instances : Les groupes de sécurité associés aux instances doivent autoriser le trafic entrant depuis l’équilibreur de charge. Il est possible de le faire en autorisant le trafic entrant depuis le groupe de sécurité de l’équilibreur de charge.
    - Vérification des sous-réseaux et des VPC : S'assurer que les groupes de sécurité utilisés sont dans le même VPC que l'équilibreur de charge et les instances.

- L’accès à l’application depuis le navigateur peut parfois poser problème :
    - Configuration de l’équilibreur de charge : S'assurer que l'équilibreur de charge est correctement configuré pour acheminer le trafic vers vos instances.
    - Règles de sécurité : Vérifiez que les règles de sécurité autorisent le trafic entrant sur le port que l'application utilise (généralement le port 80 pour HTTP et le port 443 pour HTTPS).
    - Application en cours d’exécution : Vérifiez que l'application est en cours d’exécution sur les instances et qu’elle écoute sur le bon port.

- La génération de la clé SSH depuis Windows a été problématique :
    - Executer la commande ```ssh-keygen``` dans le terminal de Windows.
        - Vérifier la présence de la fonctionnalité facultative "Client OpenSSH".
        - Réinstaller la fonctionnalité facultative.
        - Vérifier que Windows connaisse bien la commande "ssh" avec ```ssh -help``` dans le terminal de Windows.
        - Executer la réparation du système avec ```sfc /scannow```.
        - Générer la clé SSH par une solution alternative comme "PuTTYgen" ou un autre ordinateur.

## Auteur

- Kélian SCHAFFNER
