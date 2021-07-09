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
        "environment" : [
            { "name" : "KEYCLOAK_USER", "value" : "${keycloak_admin_username}" },
            { "name" : "KEYCLOAK_PASSWORD", "value" : "${keycloak_admin_password}" },
            { "name" : "DB_VENDOR", "value" : "postgres" },
            { "name" : "DB_ADDR", "value" : "${database_hostname}" },
            { "name" : "DB_PORT", "value" : "${database_port}" },
            { "name" : "DB_DATABASE", "value" : "${database_name}" },
            { "name" : "DB_USER", "value" : "${rds_username}" },
            { "name" : "DB_PASSWORD", "value" : "${rds_password}" },
            { "name" : "PROXY_ADDRESS_FORWARDING", "value" : "${proxy_address_forwarding}" }
        ],
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group": "${log_group_name}",
                "awslogs-region": "${log_group_region}"
            }
        },
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
        "environment" : [
            { "name" : "POSTGRES_USER", "value" : "${rds_username}" },
            { "name" : "POSTGRES_PASSWORD", "value" : "${rds_password}" }
            { "name" : "POSTGRES_DB", "value" : "${rds_name}" }
        ],
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group": "${log_group_name}",
                "awslogs-region": "${log_group_region}"
            }
        }
    }
]