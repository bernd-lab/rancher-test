# Muster-Backup-Policies & Scripte (Docker, Jenkins, Jellyfin)

## 1. Docker Compose Volumes (Backup via tar)
```bash
sudo tar czf /home/bernd/backups/docker/docker-volumes-$(date +%Y%m%d).tar.gz /var/lib/docker/volumes
```

## 2. Jenkins (Job + Config Backup)
```bash
sudo tar czf /home/bernd/backups/jenkins/jenkins-data-$(date +%Y%m%d).tar.gz /var/jenkins_home
```

## 3. Jellyfin (Metadata/Config Backup)
```bash
sudo tar czf /home/bernd/backups/jellyfin/jellyfin-data-$(date +%Y%m%d).tar.gz /var/lib/jellyfin /etc/jellyfin
```

## CRON Beispiel für root (täglich, 2 Uhr)
0 2 * * * /bin/bash /home/bernd/infra-toolbox/scripts/backup-docker.sh
0 3 * * * /bin/bash /home/bernd/infra-toolbox/scripts/backup-jenkins.sh
0 4 * * * /bin/bash /home/bernd/infra-toolbox/scripts/backup-jellyfin.sh

---
Hinweis: Zielpfade ggf. an Environment anpassen, "restore" analog mit `tar xzf ...`.
