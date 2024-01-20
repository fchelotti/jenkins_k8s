pipeline {
    agent {
        label "sp-terraform"
    }

    parameters {
        choice(
            choices: ['show', 'plan', 'apply', 'preview-destroy', 'destroy'],
            description: 'Terraform action to apply',
            name: 'action')
        choice(
            choices: ['dev', 'test', 'prod'],
            description: 'deployment environment',
            name: 'ENVIRONMENT')
        string(defaultValue: "test", description: 'test variable1', name: 'test1')
        string(defaultValue: "test2", description: 'test variable2', name: 'test2')
    }

    stages {
        stage('Terraform Clone Repo') {

            steps {
                git credentialsId: 'bitbucket_token', url: 'https://github.com/fchelotti/terraform.git'
            }   
        }

        stage('Terraform Validate') {
            environment {
                TF_TOKEN_app_terraform_io = credentials('terraform_cloud')
            }

            steps {
                container('terraform') {
                    sh 'export TF_TOKEN_app_terraform_io=${TF_TOKEN_app_terraform_io}'
                    dir('sul_vmware/countries/Brasil/') {
                        sh 'terraform init'
                        sh 'terraform validate'
                    }
                }
            }
        }

        stage('Terraform View Files') {
            steps {
                container('terraform') {
                    sh 'env'
                    sh 'ls -l'
                }
            }
        }

        stage('Terraform Show') {
            when {
                expression { params.action == 'show' }
            }
            environment {
                TF_TOKEN_app_terraform_io = credentials('terraform_cloud')
            }

            steps {
                container('terraform') {
                    sh 'export TF_TOKEN_app_terraform_io=${TF_TOKEN_app_terraform_io}'
                    sh 'terraform show'
                }
            }
        }

        stage('Terraform Plan') {
            when {
                expression { params.action == 'plan' }
            }
            environment {
                TF_TOKEN_app_terraform_io = credentials('terraform_cloud')
            }

            steps {
                container('terraform') {
                    sh 'export TF_TOKEN_app_terraform_io=${TF_TOKEN_app_terraform_io}'
                    sh 'terraform plan -input=false -out=tfplan -var test_var1=${ENVIRONMENT} -var test_var2=${test2}'
                    sh 'terraform show tfplan > tfplan.txt'
                }
            }
        }
        
        stage('Ansible Clone Repo') {

            steps {
                container('ansible') {
                    git credentialsId: 'bitbucket_token', url: 'https://github.com/fchelotti/ansible.git'
                }
            }
        }

        stage('Ansible Validate') {
            steps {
                container('ansible') {
                    sh 'ansible --version'
                }
            }
        }

        stage('Ansible View Files') {
            steps {
                container('ansible') {
                    sh 'env'
                    sh 'ls -l'
                }
            }
        }
        
        stage('Test ansible') {
            steps {
                container('ansible') {
                    sh 'ansible-playbook ping.yaml -i hosts'
                }
            }
        }
    }
}
