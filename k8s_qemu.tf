provider "proxmox" {
    pm_api_url = "https://proxmox_url/api2/json"
    pm_user = "user@pam"
    pm_password = "my-secret-password"
    pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "kubernetes-master" {
    name = "kubem00.cwlab.com"
    desc = "Kubernetes master node"

    target_node = "PROMX01"

    agent = 1

    clone = "centos-template"
    full_clone = true

    os_type = "cloud-init"
    cores = "2"
    sockets = "1"
    vcpus = "0"
    cpu = "host"
    memory = "2048"

    disk {
        id = 1
        size = 10
        type = "virtio"
        storage = "local-lvm"
        storage_type = "lvm"
    }

    network {
        id = 0
        model = "virtio"
        bridge = "vmbr0"
    }

    ipconfig0 = "ip=192.168.1.177/24,gw=192.168.1.1"
    nameserver = "192.168.1.1"

    sshkeys = <<EOF
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9rhDHF7/omC1SKoTs9VDszfYQ0fRXN50+3EvHsAZ+7qfuCkLDgHMCYGgpTl27ZgYQIho+snRMsq/4MlpNXvf4oF6wJD1Pr6VsjCKXN5I8ggJv7WIB5oY7aoyhpfuCOpS8JzyppUv6WOFLlJ94h5+KzqbRtACNxBtrGJVtmvrJIlaOT6ipyBbdJ4dMaIW2Sj3Jh1bmLUIGRFAtxTanRB2mLwhWVLh53XUP9ZuVTbXvnEy+VXeo4Z5m8AcnavgZjjNbhB8uWk6Hgf4pRE08jmRKZZT/M44LiD/GSQuqT5bMAJD9gSE21h6h6nwPux+Qzlk21MAk8sZ17lQAWYAzad7d root@pve
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCq8YskujEECUS9umrQHvy7mVndUIRFrz/RUi/6OJxIwoRD1tH7NlqWoTLXujIx+etck71yVmfj9iCEtPpzzPn/05x88PFiLNLAdkXny2I/vDDN+wp0ixK//ypyzZ8u1IvKT8H1vSc1PDHlUWyQPy5cUCcC7ZGnWj4b6HhDYg0UFVBFUCwJplM76azZZ+PU6WedGFXtOJH0RS1/qUcvaOjgfZ34Vxcnc51PnVehjxqhpOcwxoszFaIGiyRhjdXBFFTjzORZyx30Vh97FwgwNIqpxeCXz4PVDvSbkZD0lhmx+L4dMtk8CsTcDY9gBFb2RMXHo0XXx3roRa7gvgJVwhIjs/zIhaPU3xbez15jSzAYBxayiHCB1EnNyIqm1SqSBUdRVt0dx2XI1jC4XnJPzruvijdOVvqV8+STNHvq8bNCJNTz5PI1IuolshYbKoI0KRwqaL8aH48bxXk3yj8a6ARcuzSulC8xSE9BA/QXqCn/tjg6BBYRNgy1x2HRSCA1NGjL2eYUxxirHfckaxkckzxDIwZIktFeTGKayzuV89yVybpd+7EV7X9Ch5OjPz3QHb668/HUX3rTZQ2KvNtOTlqbQUZbUftVzgrmjvNnf6ziK97Hn/8rZyt1ieHEGfdRG5ryffZAYpX3ES5+bmrEDs+WR94WCNIFhdEZnFqClt6Dhw== cheikhwhite@Cheikhs-MacBook-Pro.local
    EOF
}

resource "proxmox_vm_qemu" "kubernetes-node-01" {
    name = "kuben01.cwlab.com"
    desc = "Kubernetes worker node 1"

    target_node = "PROMX01"

    agent = 1

    clone = "centos-template"
    full_clone = true

    os_type = "cloud-init"
    cores = "2"
    sockets = "1"
    vcpus = "0"
    cpu = "host"
    memory = "2048"
    clone_wait = 10

    disk {
        id = 2
        size = 10
        type = "virtio"
        storage = "local-lvm"
        storage_type = "lvm"
    }

    network {
        id = 0
        model = "virtio"
        bridge = "vmbr0"
    }

    ipconfig0 = "ip=192.168.1.178/24,gw=192.168.1.1"
    nameserver = "192.168.1.1"

    sshkeys = <<EOF
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9rhDHF7/omC1SKoTs9VDszfYQ0fRXN50+3EvHsAZ+7qfuCkLDgHMCYGgpTl27ZgYQIho+snRMsq/4MlpNXvf4oF6wJD1Pr6VsjCKXN5I8ggJv7WIB5oY7aoyhpfuCOpS8JzyppUv6WOFLlJ94h5+KzqbRtACNxBtrGJVtmvrJIlaOT6ipyBbdJ4dMaIW2Sj3Jh1bmLUIGRFAtxTanRB2mLwhWVLh53XUP9ZuVTbXvnEy+VXeo4Z5m8AcnavgZjjNbhB8uWk6Hgf4pRE08jmRKZZT/M44LiD/GSQuqT5bMAJD9gSE21h6h6nwPux+Qzlk21MAk8sZ17lQAWYAzad7d root@pve
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCq8YskujEECUS9umrQHvy7mVndUIRFrz/RUi/6OJxIwoRD1tH7NlqWoTLXujIx+etck71yVmfj9iCEtPpzzPn/05x88PFiLNLAdkXny2I/vDDN+wp0ixK//ypyzZ8u1IvKT8H1vSc1PDHlUWyQPy5cUCcC7ZGnWj4b6HhDYg0UFVBFUCwJplM76azZZ+PU6WedGFXtOJH0RS1/qUcvaOjgfZ34Vxcnc51PnVehjxqhpOcwxoszFaIGiyRhjdXBFFTjzORZyx30Vh97FwgwNIqpxeCXz4PVDvSbkZD0lhmx+L4dMtk8CsTcDY9gBFb2RMXHo0XXx3roRa7gvgJVwhIjs/zIhaPU3xbez15jSzAYBxayiHCB1EnNyIqm1SqSBUdRVt0dx2XI1jC4XnJPzruvijdOVvqV8+STNHvq8bNCJNTz5PI1IuolshYbKoI0KRwqaL8aH48bxXk3yj8a6ARcuzSulC8xSE9BA/QXqCn/tjg6BBYRNgy1x2HRSCA1NGjL2eYUxxirHfckaxkckzxDIwZIktFeTGKayzuV89yVybpd+7EV7X9Ch5OjPz3QHb668/HUX3rTZQ2KvNtOTlqbQUZbUftVzgrmjvNnf6ziK97Hn/8rZyt1ieHEGfdRG5ryffZAYpX3ES5+bmrEDs+WR94WCNIFhdEZnFqClt6Dhw== cheikhwhite@Cheikhs-MacBook-Pro.local
    EOF
}

resource "proxmox_vm_qemu" "kubernetes-node-02" {
    name = "kuben02.cwlab.com"
    desc = "Kubernetes worker node 2"

    target_node = "PROMX01"

    agent = 1

    clone = "centos-template"
    full_clone = true

    os_type = "cloud-init"
    cores = "2"
    sockets = "1"
    vcpus = "0"
    cpu = "host"
    memory = "2048"
    clone_wait = 20

    disk {
        id = 3
        size = 10
        type = "virtio"
        storage = "local-lvm"
        storage_type = "lvm"
    }

    network {
        id = 0
        model = "virtio"
        bridge = "vmbr0"
    }

    ipconfig0 = "ip=192.168.1.179/24,gw=192.168.1.1"
    nameserver = "192.168.1.1"

    sshkeys = <<EOF
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9rhDHF7/omC1SKoTs9VDszfYQ0fRXN50+3EvHsAZ+7qfuCkLDgHMCYGgpTl27ZgYQIho+snRMsq/4MlpNXvf4oF6wJD1Pr6VsjCKXN5I8ggJv7WIB5oY7aoyhpfuCOpS8JzyppUv6WOFLlJ94h5+KzqbRtACNxBtrGJVtmvrJIlaOT6ipyBbdJ4dMaIW2Sj3Jh1bmLUIGRFAtxTanRB2mLwhWVLh53XUP9ZuVTbXvnEy+VXeo4Z5m8AcnavgZjjNbhB8uWk6Hgf4pRE08jmRKZZT/M44LiD/GSQuqT5bMAJD9gSE21h6h6nwPux+Qzlk21MAk8sZ17lQAWYAzad7d root@pve
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCq8YskujEECUS9umrQHvy7mVndUIRFrz/RUi/6OJxIwoRD1tH7NlqWoTLXujIx+etck71yVmfj9iCEtPpzzPn/05x88PFiLNLAdkXny2I/vDDN+wp0ixK//ypyzZ8u1IvKT8H1vSc1PDHlUWyQPy5cUCcC7ZGnWj4b6HhDYg0UFVBFUCwJplM76azZZ+PU6WedGFXtOJH0RS1/qUcvaOjgfZ34Vxcnc51PnVehjxqhpOcwxoszFaIGiyRhjdXBFFTjzORZyx30Vh97FwgwNIqpxeCXz4PVDvSbkZD0lhmx+L4dMtk8CsTcDY9gBFb2RMXHo0XXx3roRa7gvgJVwhIjs/zIhaPU3xbez15jSzAYBxayiHCB1EnNyIqm1SqSBUdRVt0dx2XI1jC4XnJPzruvijdOVvqV8+STNHvq8bNCJNTz5PI1IuolshYbKoI0KRwqaL8aH48bxXk3yj8a6ARcuzSulC8xSE9BA/QXqCn/tjg6BBYRNgy1x2HRSCA1NGjL2eYUxxirHfckaxkckzxDIwZIktFeTGKayzuV89yVybpd+7EV7X9Ch5OjPz3QHb668/HUX3rTZQ2KvNtOTlqbQUZbUftVzgrmjvNnf6ziK97Hn/8rZyt1ieHEGfdRG5ryffZAYpX3ES5+bmrEDs+WR94WCNIFhdEZnFqClt6Dhw== cheikhwhite@Cheikhs-MacBook-Pro.local
    EOF
}
