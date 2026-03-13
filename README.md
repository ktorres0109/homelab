# homelab

Personal self-hosted infrastructure running on an Arch Linux home server. All services run in Docker, exposed publicly via Cloudflare Tunnel — no open router ports required.

## Services

| Service | Description |
|---|---|
| [Vaultwarden](./vaultwarden/) | Self-hosted password manager (Bitwarden-compatible) |
| [Immich](./immich/) | Self-hosted Google Photos alternative |
| [Nginx Proxy Manager](./nginx-proxy-manager/) | Reverse proxy + SSL termination |
| [Pi-hole + Unbound](./pihole/) | Network-wide ad blocking + recursive DNS |
| [Minecraft](./minecraft/) | PaperMC server |

## Stack

- **OS:** Arch Linux
- **Containers:** Docker + Docker Compose
- **Networking:** Cloudflare Tunnel (zero open ports)
- **Monitoring:** Beszel
- **Remote access:** Tailscale
- **Storage:** 2TB NAS for media, Google Drive for encrypted backups

## How it works

All services run as Docker Compose stacks. Public traffic flows through a Cloudflare Tunnel (cloudflared running as a systemd service) to Nginx Proxy Manager, which routes to the appropriate container. No ports are forwarded on the router — this works even on restricted networks.

```
Internet → Cloudflare Tunnel → Nginx Proxy Manager → Docker containers
```

See [docs/architecture.md](./docs/architecture.md) for a full breakdown.

## Backups

Vaultwarden data is synced to Google Drive daily at 2am via [rclone](./scripts/vaultwarden-backup.sh). Immich photo library is backed up locally to a 2TB NAS.

## Setup

Each service has its own directory with a `docker-compose.yml`. To deploy any service:

```bash
cd <service>
cp .env.example .env   # fill in your values
docker compose up -d
```

> **Note:** Sensitive values (tokens, passwords, domain names) are excluded from this repo. Use `.env` files for secrets — never commit them.

## Security Notes

- Signups disabled on Vaultwarden (invite-only via admin panel)
- All traffic encrypted via Cloudflare + SSL
- Admin interfaces not exposed publicly
- `.env` files in `.gitignore`
