# E2 MyMembership NodeBB Tenant Helm Chart

This Helm chart deploys a **per-tenant instance of NodeBB** bundled with **MongoDB** and **Redis**. It includes embedded MongoDB bootstrap logic for first-time setup and persistent configuration across restarts. Customised for k3s so as to sync config.json and ensure persisten.

## 🧰 Features

- Custom K3s Compatible helm chart developed for E2
- NodeBB forum with admin user bootstrap
- MongoDB and Redis sidecars
- Persistent volumes for uploads and config
- Per-tenant customizable settings
- Compatible with Rancher GitOps installation

---

## 📦 Chart Info

| Property         | Value                              |
|------------------|-------------------------------------|
| Chart Name       | `nodebb-tenant-chart`              |
| Chart Version(s) | `0.6.1`, `0.6.0`                    |
| App Version      | `1.19.0`                            |
| Repo URL         | [GitHub](https://github.com/pjanprinsloo/nodebb-helm.git) |

---

## Installation

### Option 1: Install via Rancher UI (Git-based)

1. Go to **Apps > Repositories > Create**.
2. Name the repo select Git as the repo method.
3. Under *Repository URL*, enter:

   ```
   https://github.com/pjanprinsloo/nodebb-helm.git
   ```

3. Set **Branch** to:

   ```
   main
   ```

4. Go to **Apps > Charts** and search for `nodebb-tenant-chart`. Click on the chart and proceed to install.

5. The values.yaml will be prepopulated with sample data. Complete as is needed - pay attention to tenant name, sizes and network method.

6. Click **Install**.

---

### Option 2: Install via Helm CLI

```bash
helm repo add nodebb-tenant https://pjanprinsloo.github.io/nodebb-helm/
helm repo update

helm install my-forum nodebb-tenant/nodebb-tenant-chart \
  --version 0.6.1 \
  -f my-values.yaml
```

> 💡 You can also point directly to a local or Git `.tgz` file if hosting manually:
>
> ```bash
> helm install my-forum ./nodebb-tenant-chart-0.6.1.tgz -f my-values.yaml
> ```

---

## 🧾 Example `values.yaml`

```yaml
tenant: tenant-name

mongo:
  username: root
  password: example
  dbUser: nodebbuser
  dbPass: nodebbpass

redis:
  password: redispass123

nodebb:
  domain: forum.tenant.example.com
  adminUser: admin
  adminEmail: admin@example.com
  adminPassword: adminpass

service:
  type: NodePort  # Or LoadBalancer

persistence:
  nodebb:
    uploadSize: 2Gi
    configSize: 2Mi
  mongo:
    size: 2Gi
```

---

## 📂 Directory Structure (Repo Layout)

```
nodebb-helm/
├── charts/
│   └── nodebb-tenant-chart/
│       ├── templates/
│       ├── values.yaml
│       ├── Chart.yaml
│       └── ...
├── index.yaml
└── README.md
```

---

## 🔧 Post-Deployment

- Access NodeBB at the domain or NodePort IP configured.
- Use the admin credentials defined in `values.yaml` to complete initial setup.
- MongoDB config is backed up and restored using a sidecar mechanism.

---

## 🧪 Testing

To test locally using Helm:

```bash
helm install test-deploy ./nodebb-tenant-chart -f my-values.yaml --dry-run
```

---

## 🛡️ Notes

- Ensure your Kubernetes cluster supports persistent volumes.
- NodeBB config is copied from the running container to persistent storage once setup is complete.
- Sidecar container monitors `/usr/src/app/config.json` and backs it up to ensure reboots retain settings.

---

## 🧑‍💻 Maintainer
For E2
**Peter-Jan Prinsloo**  
GitHub: [@pjanprinsloo](https://github.com/pjanprinsloo)
