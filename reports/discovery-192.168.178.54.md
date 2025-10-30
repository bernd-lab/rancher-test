## Discovery-Report: 192.168.178.54 (Debian/KVM + Docker, Single-Node-K8s unbekannt)

### Zusammenfassung
- Betriebssystem: Debian 12 (bookworm), Kernel 6.1.0-37-amd64
- Hardware: 4 vCPU, 31GiB RAM, mehrere Datenträger (inkl. große NTFS-Medien)
- Netzwerk: Host-IP 192.168.178.54/24 (br0), diverse Docker-Netzwerke aktiv
- Virtualisierung: KVM installiert; `default`-Netz aktiv; aktuell keine laufenden VMs sichtbar in `virsh list`
- Docker: Engine 28.5.1, 9/19 Container laufen, Compose v2.40.0
- Wichtige Container: gitlab, jenkins, pihole, cadvisor, node-exporter, promtail, nginx-reverse-proxy, jellyfin
- Kubernetes: Kein `kubectl`-Kontext auf dem Host gefunden (Abschnitt leer)
- Git/GitOps: git v2.39.5; Repo-Verzeichnis gefunden: `/home/bernd/k8s-cluster-test`
- IaC: Terraform/Ansible-Versionen nicht erkennbar, aber Terraform-Dateien vorhanden
- YAML/JSON: `jq-1.6`; `yq` nicht gefunden
- Secrets: sops/age/vault nicht gefunden
- K8s-Secrets: 0 (kein Clusterzugriff verfügbar)

### Rohdaten (Auszug)

```text
=== SYSTEM ===
Distributor ID: Debian
Description: Debian GNU/Linux 12 (bookworm)
Linux zuhause 6.1.0-37-amd64 ... x86_64 GNU/Linux

=== DOCKER ===
Client/Server Version: 28.5.1, Compose v2.40.0
Containers (Running/Total): 9/19, Images: 31
Wichtige Container: gitlab, jenkins, pihole, cadvisor, node-exporter, promtail, nginx-reverse-proxy, jellyfin

=== SEARCH REPOS ===
/home/bernd/k8s-cluster-test

=== TERRAFORM / ANSIBLE ===
/home/bernd/k8s-cluster-test/... (*.tf, ansible.cfg)

=== YAML/JSON TOOLS ===
jq-1.6
```

### Hinweise / nächste Schritte
- Prüfen, ob Single-Node-K8s in einer VM läuft (Port 5900 VNC für `machine-qemu-...k8s-single-node.scope` sichtbar). Zugang zur VM nötig, um `kubectl` auszuführen.
- Optional: `yq` installieren für YAML-Patching; `sops+age` für GitOps-Secrets etablieren.
- `k8s-cluster-test` als primäre GitOps/IaC-Quelle heranziehen.


