---
title: Hubitat Zigbee Device Dropout Runbook
project: ops
type: runbook
updated: 2026-07-27
tags: [hubitat, zigbee, home-automation, mesh, rule-machine, runbook]
---

# Hubitat Zigbee Device Silently Stops Working (device says "on"/reachable but isn't)

## ⚡ Fastest diagnostic — run this FIRST

Go to **Settings → Zigbee Details** (`http://<hub-ip>/hub/zigbeeInfo`, this
hub: `192.168.1.213`) and read the device table's **Last message** and **Msgs**
columns. This single page shows mesh-wide health at a glance — don't check
devices one by one.

- **Mains-powered device (outlet/switch/repeater), Last message hours/days
  old** → it dropped off the mesh. Hubitat's cached attribute (e.g.
  `switch: on`) is stale/optimistic, not real. This is the fountain/Kitchenette
  cabinet lights failure mode below.
- **Battery/button device, Msgs = 0 forever** → normal *if* nobody uses it
  (e.g. seasonal Christmas Tree outlets in July — expected, ignore). **Abnormal
  and needs re-pair** if the person says they pressed it and nothing happened —
  confirm with a live physical-press test (see below).
- Banner **"Weak Zigbee channel found"** at the top → hub-wide radio problem,
  not a single-device fault. See channel section below.

## Symptom → cause → fix

| Symptom | Cause | Fix |
|---|---|---|
| Hubitat shows device "on" but physically it's off/unresponsive | Device dropped off Zigbee mesh; hub's cached attribute is the last *commanded* value, not a confirmed report | 1) Physically power-cycle the device (unplug/replug). 2) Send `configure` command (via Maker API or device page) — this re-sends Zigbee binding and often forces reconnection. `refresh` alone is usually NOT enough. Verify by checking Zigbee Details table for a fresh "Last message" timestamp, or device events for a new confirmed `switch`/`power` report. |
| Rule Machine automation fires false positives off a power-meter threshold (e.g. "out of water", "pump dry", "no load detected") | The rule's "stays that way for" duration is shorter than the device's real reporting latency (worse during mesh dropouts, when NO new report ever corrects a stale low reading) | In the rule's trigger event, increase "stays" duration to **5 minutes minimum**. A real fault (dry pump, no load) won't self-correct in 5 min; a reporting/connectivity blip usually will. |
| Battery button controller (e.g. Philips Hue Dimmer Button Controller V2) does nothing when pressed | Device shows 0 messages in Zigbee Details, confirmed via live press test that zero traffic reaches the hub | Not remotely fixable — sleepy battery end devices can't be pinged. Needs a full re-pair: factory-reset the button (hold its pairing/link button, varies by model) and re-pair to the hub while in Zigbee pairing mode. |
| Multiple *unrelated* devices dropping off around the same time | Hub-wide Zigbee channel congestion | See channel change procedure below. |

## Live test for "is this button dead or just quiet"

1. Note current Msgs count for the device in Zigbee Details.
2. Ask the person to press it once.
3. Re-check Zigbee Details — if Msgs count and Last message didn't move, the
   device produced zero radio traffic. It's disconnected, not just idle.
   (`hubitat_get_device_events` via Maker API will also show nothing new.)

## Command Retry — the standing safeguard (enable once, covers future drops)

**Settings → Command Retry** (`http://<hub-ip>/hub/edit`, click the Command
Retry card). Native Hubitat feature: if a device doesn't confirm a state
change after a command, the hub auto-resends up to 5 times. Covers Zigbee,
Z-Wave, and Matter.

- "Enable all" per protocol (Zigbee devices / Z-Wave devices / Matter devices)
  — each triggers a confirmation dialog ("Enable Command Retry for all X
  devices now?" → Yes). Click "Save" at the bottom after.
- Low-risk, additive, reversible — safe to leave on permanently. Should be
  step 1 whenever pairing a new Zigbee/Matter device going forward.
- This does NOT fix a device that's fully off the mesh (nothing to retry to)
  — it only helps borderline/intermittent connectivity.

## Zigbee channel change (bigger lever — hub-wide, disruptive)

Only do this if Hubitat itself shows the **"Weak Zigbee channel found"**
banner on the Zigbee Details page, or Command Retry + individual re-pairs
aren't holding.

1. **Settings → Zigbee Details → Scan channels** (`/hub/zigbeeChannelScan`,
   takes ~1 min). This only detects *other Zigbee coordinators/PANs* nearby —
   if it comes back all zeros, that means no competing Zigbee mesh, NOT that
   the current channel is clean of WiFi interference (this scan can't see
   that). Don't over-trust an all-zero scan as "channel is fine."
2. Pick a replacement channel. Community-standard picks that avoid the
   default WiFi channels 1/6/11 overlap: **15, 20, 25**. If 20 is already
   flagged weak, move to **25** (or 15) — this is best-effort, not
   scientifically verified against your specific RF environment.
3. Set Channel dropdown → **Update channel and power** → confirm "Yes" in the
   dialog.
4. Per Hubitat's own guidance: **reboot the hub** after (Settings → Reboot →
   Yes). Hub UI session will log out after reboot (~1 min) — that's normal,
   just log back in.
5. **Expect up to 24 hours** for all devices to find the new channel. Weak
   devices may need manual re-pair regardless.
6. **A channel change does NOT revive devices that were already fully dead on
   the mesh** — confirmed 2026-07-27: after changing 20→25 and rebooting, a
   fountain outlet that responded to `configure` came back fine, but a
   long-dead outlet (Kitchenette cabinet lights, silent 3+ days) and two dead
   button controllers stayed dead. Channel change is prevention for currently
   *healthy* devices, not a cure for already-dropped ones — those still need
   the device-level fix (power-cycle / re-pair) above.

## Browser access note

Hubitat's local admin UI only works over the local network. The in-app
`Claude_Browser` tool **blocks all private/local-network sites** ("per-action
approval" error with no way through it) — use the `claude-in-chrome` MCP tools
instead (real Chrome, same LAN as the hub) for any Hubitat local-admin work.
The `mcp__hubitat__*` Maker API tools work independently of the browser
session (separate API token) and survive hub reboots/browser logouts — prefer
them for device-level checks (`hubitat_get_device`, `hubitat_get_device_events`,
`hubitat_send_command`) over browser automation when you just need device
state, not to edit an app/rule.

## What does NOT work / wasted paths

- Sending `refresh` alone to a dropped-off mains device — often insufficient;
  `configure` (after a physical power-cycle) is what actually worked for the
  fountain.
- Expecting a Zigbee channel change to fix a device that's already shown 0
  messages / hasn't confirmed in days — it won't; that device needs a
  device-level fix regardless of channel.
- Trying to remotely "ping" or `refresh` a battery/button end device to
  diagnose it — sleepy devices don't respond to hub-initiated polls; only a
  live physical-press test is conclusive.
- Trying to read the Hubitat local admin UI via `Claude_Browser` — always
  blocked for private IPs; go straight to `claude-in-chrome`.

## Prevention

- Enable Command Retry (see above) for every new Zigbee/Matter device at
  pairing time, not just when something breaks.
- Any Rule Machine trigger built on a power-meter/sensor threshold: default
  "stays" duration to ≥3-5 minutes, never 1 minute — 1 minute is shorter than
  normal device reporting latency and will false-trigger on any mesh blip.
- Periodically (e.g. folded into a weekly review) check Settings → Zigbee
  Details for the weak-channel banner and scan the Last message column for
  mains devices that have gone stale — nothing else surfaces this
  proactively; Hubitat won't notify you that a device silently died.

Related: [[Knowledge_Base/Learnings_and_Conventions]]
