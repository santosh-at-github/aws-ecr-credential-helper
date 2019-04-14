# aws-ecr-credential-helper
This script installs and configures "amazon-ecr-credential-helper" on EC2 instance
so that docker can pull images from ECR without executing "docker login" command.
It also provides ability to pull docker images directly from ECR when a service is
created in swarm mode and deployed on different instances.

- Works on RHEL7. Haven't tested on any-other OS yet.
- Execute the script as ec2-user
- After executing this script, run docker service with "--with-registry-auth", it should work fine.
- Eg: docker service create -d --name test123 --with-registry-auth <AWS_Account_ID>.dkr.ecr.<region>.amazonaws.com/my_first_repo/web_apps:v1
- References:
  - https://github.com/awslabs/amazon-ecr-credential-helper
  - https://gist.github.com/tegansnyder/a2e36d09c13cc49b452dcc641981bc27
  - https://github.com/moby/moby/issues/25619
