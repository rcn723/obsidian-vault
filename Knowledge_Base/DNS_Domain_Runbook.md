---
title: DNS & Domain Troubleshooting Runbook
type: runbook
updated: 2026-06-13
tags: [dns, domain, namecheap, vercel, ssl, tls, runbook, ops]
---

# DNS & Domain Troubleshooting Runbook

Cross-project. Born from the welra.io apex-SSL incident (2026-06-13) that took ~2 hours of back-and-forth — this runbook should make the next one ~5 minutes. See also [[Knowledge_Base/Learnings_and_Conventions]].

## The one rule: query the authoritative nameserver, never a cache

Every DNS diagnosis starts here. Public resolvers (`1.1.1.1`, `8.8.8.8`) and your laptop/phone **cache results**, including **NXDOMAIN for up to the SOA negative-TTL (~1 hour)** — so they will lie to you for an hour after a fix lands. The registrar's own nameserver is the source of truth.

```bash
# Who is authoritative?
dig +short NS welra.io                       # e.g. dns1/dns2.registrar-servers.com (Namecheap)

# Ask the authoritative NS directly — bypasses ALL caches:
dig +short @dns1.registrar-servers.com welra.io A
dig +short @dns1.registrar-servers.com www.welra.io
dig @dns1.registrar-servers.com www.welra.io +noall +comments | grep -i status   # NXDOMAIN vs NOERROR

# Compare BOTH nameservers + the SOA serial (the desync tell):
dig +short @dns1.registrar-servers.com welra.io SOA   # field 3 = serial
dig +short @dns2.registrar-servers.com welra.io SOA
```

## The SOA serial is the health tell

The third field of the SOA record is the zone serial. On a healthy zone it **only increases**, and **both nameservers agree**. Use it to distinguish the three failure classes:

| Symptom | Meaning | Action |
|---|---|---|
| Serial bumped, record present, public resolvers stale | Normal propagation + negative-cache | Wait; verify on authoritative NS, not public |
| Serial **frozen** across your edits (record saved in UI but not served) | Registrar isn't republishing the zone | Registrar support: "force a zone rebuild" |
| Serial **differs between dns1 and dns2** / goes **backwards** | Nameserver fleet **desynced** | Registrar support: "your fleet is out of sync, resync the zone" |

If the serial doesn't move after you save a record, **stop editing** — more edits won't help. It's a registrar-side publish failure.

## Namecheap-specific traps (all hit in the welra.io incident)

1. **Parking Page re-injects the parking IP.** With Parking ON, Namecheap forces an `A @ → 162.255.119.x` (their parking IP) and **re-creates it every time you delete the row**. Domain page → Other Domain Settings → Parking Page → OFF.
2. **"Redirect Domain" ALSO injects the parking IP.** A URL redirect (e.g. `welra.io → http://www.welra.io/`) points the apex at Namecheap's redirect server (same `162.255.119.x`) and regenerates the A record. Domain page → Redirect Domain → Remove. **You don't need it** — the host (Vercel/Netlify) does apex→www itself.
3. **A saved record can still be missing from the published zone.** It shows in Advanced DNS, survives a hard refresh, but returns NXDOMAIN on the nameservers and the serial doesn't bump → stuck zone → support forces a rebuild.
4. **Records can flap** (resolve on one query, NXDOMAIN the next) when the fleet is desynced — this is the conflicting-serial case above.
5. **Namecheap propagation can genuinely take ~30 min** to its own NS after a rebuild — but only trust that explanation once the serial has actually bumped and both NS agree.

## Vercel-specific: ONE cert covers apex + www

Vercel issues a **single certificate covering both `domain.com` and `www.domain.com`**. If **either** name fails DNS validation (e.g. `www` is NXDOMAIN), the **whole cert stalls** — so a broken `www` also blocks the apex cert, and vice-versa. Get **both** names resolving before expecting any cert.

- Apex record Vercel wants: `A @ → 76.76.21.21`.
- `www`: CNAME → `cname.vercel-dns.com` **or** (if the CNAME won't save — see below) `A www → 76.76.21.21`. Vercel routes by hostname (SNI), not IP, so an A record at the apex IP works for subdomains too, as long as the domain is attached to the project (`vercel domains inspect <domain>`).
- The Vercel side is usually already correct; the fix is almost always at the registrar. Don't reconfigure Vercel to "fix" a DNS problem.

## CNAME-won't-save fallback

If a `www` CNAME repeatedly fails to publish but A records on the same zone publish fine: switch `www` to an **A record at the host's apex IP** (`76.76.21.21` for Vercel). Same destination, avoids whatever the registrar is choking on with the CNAME.

## Don't break what works while fixing what doesn't

Editing the apex can accidentally delete the working `www` record (it happened — `www` went NXDOMAIN mid-fix and the site went fully down). **Before editing, write down the complete intended record set** and make the zone match it, rather than incremental whack-a-mole. Target end state for a Vercel site on Namecheap:

```
A      @     76.76.21.21
A      www   76.76.21.21            (or CNAME www → cname.vercel-dns.com)
+ untouched: MX, DKIM, SPF, DMARC, TXT verification records
```

Never switch nameservers away from the registrar to "force" a fix — that drops MX/DKIM and kills email.

## Verify a real fix (not a flap)

```bash
# Both NS agree, same serial, www present:
dig +short @dns1.registrar-servers.com www.welra.io ; dig +short @dns2.registrar-servers.com www.welra.io
# curl completing HTTPS WITHOUT -k proves the cert is valid (openssl can false-negative on timeout):
curl -s -o /dev/null -w "%{http_code}\n" -L https://welra.io/       # expect 200 (redirects to www)
curl -s -o /dev/null -w "%{http_code}\n" -L https://www.welra.io/   # expect 200
```

## Escalating to registrar support (the script that skips tier-1)

Lead with evidence, not symptoms: *"Your nameservers return a **frozen/conflicting SOA serial** for `<domain>` (seen X and Y within the same minute) and `www` returns NXDOMAIN intermittently — the zone isn't synchronized across your fleet. Please **force a full zone rebuild/resync** from my current Advanced DNS records. Do not reset to defaults or change my nameservers (protects my email)."* Ask them to confirm the serial now matches on dns1 and dns2.

## Don't trust "it works for me"

A user reporting "my phone loads fine" often means they hit `www` (cached/valid) while the bare apex is still broken — or their device cached an old good result. Verify the **specific** failing hostname against the **authoritative** NS before believing it's fixed.
