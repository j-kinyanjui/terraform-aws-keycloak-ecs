[
    {
        "memory":1024,
        "networkMode":"awsvpc",
        "cpu":512,
        "family":"keycloak",
        "portMappings": [
            {
                "hostPort": ${host_port},
                "containerPort": ${keycloak_container_port},
                "protocol": "tcp"
            }
        ],
        "essential": true,
        "name": "${keycloak_container_name}",
        "image": "jboss/keycloak:13.0.1",
        "secrets": [
            {"name": "KEYCLOAK_PASSWORD", "valueFrom": "${keycloak_admin_password}"},
            {"name": "DB_PASSWORD", "valueFrom": "${rds_password}"}
        ],
        "environment" : [
            { "name" : "KEYCLOAK_USER", "value" : "${keycloak_admin_username}" },
            { "name" : "DB_VENDOR", "value" : "postgres" },
            { "name" : "DB_ADDR", "value" : "${database_hostname}" },
            { "name" : "DB_PORT", "value" : "${database_port}" },
            { "name" : "DB_DATABASE", "value" : "${database_name}" },
            { "name" : "DB_USER", "value" : "${rds_username}" },
            { "name" : "PROXY_ADDRESS_FORWARDING", "value" : "${proxy_address_forwarding}" }
        ],
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group": "${app_log_group_name}",
                "awslogs-region": "${log_group_region}"
            }
        },
        "links": [
            "postgres:postgres"
        ],
        "dependsOn": [
            {
                "containerName": "postgres",
                "condition": "HEALTHY"
            }
        ]
    },
    {
        "memory":1024,
        "networkMode":"awsvpc",
        "cpu":512,
        "family":"keycloak",
        "portMappings": [
            {
                "hostPort": ${postgres_container_port},
                "containerPort": ${postgres_container_port},
                "protocol": "tcp"
            }
        ],
        "essential": true,
        "name": "postgres",
        "image": "postgres:12.7",
        "secrets": [
            { "name": "POSTGRES_PASSWORD", "valueFrom": "${rds_password}"}
        ],
        "environment" : [
            { "name" : "POSTGRES_USER", "value" : "${rds_username}" },
            { "name" : "POSTGRES_DB", "value" : "${database_name}" }
        ],
        "healthCheck": {
            "command": [
                "CMD-SHELL",
                "pg_isready -U rdskeycloakuser"
            ],
            "interval": 5,
            "timeout": 2,
            "retries": 3
        },
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group": "${postgres_log_group_name}",
                "awslogs-region": "${log_group_region}"
            }
        }
    }
]