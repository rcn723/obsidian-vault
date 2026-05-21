---
title: Stock Agent State
project: stock-agent
type: state
updated: 2026-05-21
tags: [stock, trading, python, automation]
---

# Stock Agent (Edge-Finder)

Paper trading live. Daily cron active at 2pm Mon–Fri.
Path: `~/Claude/Projects/Stock/`

See [[Projects/Stock_Agent/Tasks]] for open items.

## Status Summary
- Paper trading: ✅ Live (started 2026-05-21)
- Scheduling: ✅ Cron active — `0 14 * * 1-5`
- Closed trades: 3/30 (need 30 before going live)
- Live portfolio: $101.74, 6 positions (TSLA, GOOGL, BTC, ETH, SPY, QQQ)
- CoinGecko: ⚠️ AVAX and LINK returning 429 errors — free tier limit

## Cron Entry
```
0 14 * * 1-5  /usr/bin/python3 ~/Claude/Projects/Stock/agent.py >> ~/Claude/Projects/Stock/agent.log 2>&1
```

## Strategy Config (current)
| Strategy | Key Setting | Value |
|---|---|---|
| trend_following | logic | fires on fast>slow (not crossover only) |
| trend_following | pyramiding | guard prevents daily re-accumulation |
| mean_reversion | sell_above | 60 (lowered from 70 for faster cycling) |
| vol_breakout | breakout_multiplier | 1.2× ATR (lowered from 1.5) |
| general | max_concurrent_positions | 6 (raised from 4 to allow crypto) |
| general | exited_today guard | prevents same-day re-entry |

## Related
- [[Projects/Stock_Agent/Tasks]]
- [[Knowledge_Base/Learnings_and_Conventions]]
