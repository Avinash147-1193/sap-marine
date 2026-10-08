# Static site

This repo contains a static site. The entry point is `index.html`.

## Local preview

Option 1. Python.

```bash
python3 -m http.server 8080
```

Open http://localhost:8080

Option 2. Node.

```bash
npx serve -l 8080 .
```

## Docker

Build:

```bash
docker build -t site:local .
```

Run:

```bash
docker run --rm -p 8080:80 site:local
```

Open http://localhost:8080

## Deployment notes

### DNS delegation for Google Cloud DNS

If you use Google Cloud DNS for the domain, the domain registrar must delegate to the exact `ns-cloud-*.googledomains.com` nameservers shown in the Cloud DNS zone.

Action at the registrar:
1. Set the domain authoritative nameservers to the Cloud DNS `ns-cloud-*.googledomains.com` values.
2. Wait for DNS propagation.
3. Re-run deployment, or re-run HTTPS and health checks.

If the registrar NS does not match the Cloud DNS zone NS, the domain and subdomains will not resolve. HTTPS checks will fail.

### SSH timed out during deploy

If your deploy tool connects over SSH to a host, confirm the target public IP is correct.

Action:
- Update the deploy target IP to the instance current public IP.
- If you expect a stable IP, attach an Elastic IP to the instance and ensure routing is correct.
