
# NodeBB Tenant Helm Chart

This Helm chart allows you to deploy a per-tenant NodeBB instance with MongoDB and Redis.  
You can use this chart either via **Rancher Web UI** or using the **Helm CLI**.

---

## 🚀 Option 1: Install via Rancher Web UI

1. Go to **Apps > Charts > Upload** in Rancher
2. Upload the packaged chart file: `nodebb-tenant-chart-<version>.tgz`
3. Click **Install**
4. Scroll to the **YAML values** section
5. Paste your tenant-specific configuration:

```yaml
tenant: tenant20

mongo:
  username: root
  password: example
  dbUser: nodebbuser
  dbPass: nodebbpass

redis:
  password: redispass123

nodebb:
  domain: nodebb.tenant20.local
  adminUser: admin
  adminEmail: admin@tenant20.local
  adminPassword: adminpass
```

6. Complete the installation

---

## 🧪 Option 2: Install via Helm CLI

1. Ensure you have `kubectl` access to the target cluster
2. Run the install command with a custom values file:

```bash
helm install tenant20 ./nodebb-tenant-chart -f values-tenant20.yaml
```

Or if using the `.tgz` package:

```bash
helm install tenant20 nodebb-tenant-chart-0.1.0.tgz -f values-tenant20.yaml
```

---

## 🧹 To Uninstall

```bash
helm uninstall tenant20
```

This will remove all related Kubernetes resources for the tenant.

---

Let your DevOps team know if you'd like a sample `values.yaml` or to automate tenant provisioning.
