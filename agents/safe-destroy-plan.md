# Safe-Destroy-Plan & Abhängigkeitsgraph (MVP Automation)

## Kritische Schlüsselkomponenten (diese werden NIE vor gesichertem Recovery entfernt):
- **GitLab/Runner/Agent:** Source, Pipeline, Secrets, IaC-State und Deployment-Steuerung
- **NFS-Server/StorageClass/PV:** Persistenz für Cluster-Apps, Backups, alle produktiven Daten
- **K8s-Core (Node + ControlPlane):** API, Recovery & Networking wären bei Komplettabriss nicht mehr ausrollbar
- **MetalLB/Ingress/DNS (Pi-hole):** Loadbalancer, Service-IP & DNS-Auflösung Cluster/extern
- **ArgoCD/GitOps-Agenten:** Automatischer Rollout, Health & Undo; Triggert alles Weitere

## Abhängigkeitsgraph für sicheres Down/Up
1. **Storage (PVs, NFS-Basis, Snapshots, CI/CD-Backups)**
2. ⇒ **K8s Core (API, Node, ControlPlane, Netzwerk-Ebene stabil)**
3. ⇒ **GitLab + Agent, ArgoCD, Runner (CI/CD, State/Bootstrap-Pipeline)**
4. ⇒ **Netzwerk (MetalLB, Ingress, Pi-hole)**
5. ⇒ **Basis-Apps (Monitoring, Registry, Health, Policy, QA-Agenten)**
6. ⇒ **Produktiv-Apps, User-Services, alle eigentlichen Businessstacks**
7. **QA & Orchestrator-Agenten für Dry-Run/Restore testen jede Stufe explizit:**
   - Erlaubt Zerstörung immer erst nach erfolgreichem automatisierten Recovery-Test aus Repos/IaC/Backup

---
**Jedes Down/Destroy erfolgt immer erst nach bestandenem Auto-Restore.**
Erkenntnisse, Blocker & Recovery-Issues werden transparent in den Session-Logs dokumentiert.
