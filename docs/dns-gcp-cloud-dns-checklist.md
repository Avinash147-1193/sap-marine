# GCP Cloud DNS delegation checklist

Use this before enabling HTTPS, provisioning certs, or running health checks.

## 1. Confirm the Cloud DNS zone exists

1. Open Google Cloud Console.
2. Go to Network services, Cloud DNS.
3. Open your managed zone.
4. Copy the authoritative nameservers listed for the zone. They look like:
   - ns-cloud-a1.googledomains.com
   - ns-cloud-a2.googledomains.com
   - ns-cloud-a3.googledomains.com
   - ns-cloud-a4.googledomains.com

## 2. Fix registrar delegation

At your domain registrar, set the domain's authoritative nameservers to the exact ns-cloud-*.googledomains.com values shown in the Cloud DNS zone.

Do not keep old nameservers.
Do not add extra nameservers.
Do not change spelling or numbering.

Wait for DNS propagation.

## 3. Verify public NS records

From a terminal:

1. Check the domain NS records:
   - dig +short NS example.com

2. Confirm the returned values match the Cloud DNS zone nameservers.

If dig returns nothing, your domain has no public NS records. Fix delegation at the registrar first.

## 4. Verify A or CNAME records resolve

If you serve the apex:
- dig +short A example.com

If you serve a subdomain:
- dig +short CNAME www.example.com
- dig +short A www.example.com

## 5. Redeploy or rerun checks

After delegation is correct and propagated:
- Rerun your deployment.
- Rerun any HTTPS or load balancer health checks.

## Common failure modes

### Registrar nameservers do not match Cloud DNS zone
Action: change registrar nameservers to match the Cloud DNS zone values exactly. Wait for propagation.

### Domain has no public NS records
Action: set registrar nameservers to ns-cloud-*.googledomains.com for your Cloud DNS zone. Wait for propagation.

### HTTPS health checks fail while DNS is wrong
Action: fix delegation first. Then rerun cert provisioning or health checks.
