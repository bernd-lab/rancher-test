# K8s-Landscape/Altlasten-Report

## Aktive Monitoring-Komponenten/Empfehlung
- Prometheus, Grafana, Alertmanager, node-exporter, promtail, Loki: im Cluster, _Produktivinstanz_.
- Docker-Host-Versionen redundant, sollten gelöscht werden!

## Problematische/unnötige Pods/Deployments
- sealed-secrets-controller: CrashLoopBackOff (Policy prüfen/löschen)
- fluentd: ImagePullBackOff (Deployment prüfen oder löschen)
- Test/Dev Pods: nginx-test, plantuml, test-cleanup (auf Notwendigkeit prüfen, ggf. entfernen)

## Doppelte Dienste (Host vs. K8s)
- Heimdall, Komga, Syncthing, Jenkins, Pihole, Jellyfin: NUR im Cluster betreiben, Host-Deployments entfernen falls doppelt!

---

### ToDo
- Altlasten entfernen (Monitoring, Test/Dev)
- Fehlerhafte/unnötige Deployments zurückbauen
- Policy dokumentieren: Alle produktiven Standarddienste gehören künftig _nur_ ins Cluster!


