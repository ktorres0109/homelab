# Architecture

## Stack Overview

```
Internet
    │
    ▼
Cloudflare (DNS + Tunnel)
    │
    ▼
Arch Linux Server (home network)
    │
    ├── Cloudflare Tunnel (cloudflared systemd service)
    │       Routes public traffic to internal services
    │
    ├── Nginx Proxy Manager
    │       Handles SSL termination and reverse proxying
    │
    ├── Vaultwarden        → vault.yourdomain.com
    ├── Immich             → photos.yourdomain.com
    ├── Pi-hole + Unbound  → local DNS + recursive resolver
    ├── Minecraft Server   → direct TCP (port 25565)
    └── Beszel             → server monitoring
```

## Key Design Decisions

**Cloudflare Tunnel instead of port forwarding**
- No open ports on the router
- Works on restricted networks (school/work wifi)
- Free SSL via Cloudflare

**Docker Compose for everything**
- Each service is isolated in its own directory
- Easy to update, restart, or remove individual services
- Volumes keep data persistent across container updates

**Backups**
- Vaultwarden data synced to Google Drive daily via rclone
- Immich photo library backed up to local NAS (2TB)

## Networking

| Service | Internal Port | Public URL |
|---|---|---|
| Vaultwarden | 8082 | vault.yourdomain.com |
| Immich | 2283 | photos.yourdomain.com |
| NPM Admin | 81 | internal only |
| Minecraft | 25565 | direct TCP |
| Pi-hole | 8085 | internal only |
| Beszel | 8090 | internal only |
