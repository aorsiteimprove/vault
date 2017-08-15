storage "file" {
    path = "/home/ubuntu/vault/data"
}

listener "tcp" {
    tls_disable = 1
}