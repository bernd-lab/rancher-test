# Docker-Altlasten-Report

## Gestoppte/Redundante Container (Clean-up-Kandidaten)
- grafana, prometheus, promtail, node-exporter (Monitoring, jetzt in K8s)
- whisperx-container, big-bear-home-assistant, syncthing, big-bear-btop, big-bear-dozzle, big-bear-komga, linuxserver-grocy-app-1, video-duplicate-finder (alle exited)

## Überflüssige Images/Volumes/Netzwerke
- Diverse alte Tags (z. B. grafana:latest, promtail:2.8.2, prom/node-exporter:latest)
- monitoring_grafana_data, monitoring_prometheus_data, monitoring_monitoring

## Empfehlung
- Monitoring-Dienste nur noch im Kubernetes-Cluster betreiben!
- Clean-up: Stop und Remove aller Altlasten (siehe ToDo)

---

### ToDo
- docker stop/remove grafana prometheus promtail node-exporter
- docker rm ... (alle exited/gestoppten unwichtigen Container)
- docker rmi ... (alle nicht mehr benötigten Images)
- docker volume rm ... (ungenutzte Volumes)
- docker network rm ... (ungenutzte Netzwerke)
- docker system prune (vorsichtig, erst nach Backup!)

