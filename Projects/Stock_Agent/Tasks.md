---
title: Stock Agent Tasks
project: stock-agent
type: tasks
updated: 2026-06-25
tags: [stock, trading, python]
---

# Stock Agent Tasks

See [[Projects/Stock_Agent/State]] for portfolio and strategy details.
Log: NAS `logs/stock.log`; local backtests: `~/Claude/Projects/Stock/checkpoints/`.

## Action Required (Ryan)

- [ ] **Deploy the forward-test self-reporter** (1 more `./deploy.sh stock`). Staged + validated on the Mac (config `forward_test.start_date` + `_report_forward_test` in agent.py; smoke tests green) but NOT on the NAS yet — the one-time deploy auth was consumed by the strategy deploy. Once deployed, every 14:00 PDT run logs `[forward-test] since 2026-06-26: trades=N/30 … → GATE PASS/not yet` to `logs/stock.log`, so the go-live milestone is visible without `--checkpoint`. NOTE: until then, Mac canonical source is 1 commit ahead of the live NAS bot (NAS has the strategy, not the reporter). [owner:: ryan] [priority:: medium] [status:: open]

## In Progress

- [ ] **Forward-test the new strategy on the live paper account** — deployed to NAS 2026-06-26; first live run with momentum-only + trend filter is today 14:00 PDT. Watch the next ~30 trades; re-run `--checkpoint` and confirm the gate holds on fresh live data before any go-live. See [[Projects/Stock_Agent/Go_Live_Plan]]. [owner:: auto] [priority:: high] [status:: in-progress]
- [ ] Reach 30 closed trades for go-live — live paper at 23/30; `top_n=3` should accelerate this [owner:: auto] [priority:: high] [status:: in-progress]

## Open

- [ ] Tighten the trend filter so the 4.75y window also clears 20% DD (currently 23.9%). The regime classifier (MA10/50 ±1%) lags at turns — try a faster MA, a 2-of-N confirmation, or scaling exposure by regime instead of binary on/off. [owner:: claude] [priority:: medium] [status:: open]
- [ ] **Repair or retire the 3 disabled strategies.** vol_breakout had 0% win over 10 trades (logic likely broken — inspect `strategies/vol_breakout.py`). mean_reversion wins 67% but loses money = winners cut short / losers run (sizing or exit bug). trend_following near-breakeven. [owner:: claude] [priority:: medium] [status:: open]
- [ ] Fix CoinGecko 429 errors — free tier rate-limits, so crypto universe is intermittently dropped from both live runs and backtests (undermines backtest reproducibility). Options: add backoff + on-disk cache, get a free CoinGecko demo API key, or drop crypto from the universe. [owner:: claude] [priority:: medium] [status:: open]
- [ ] Add per-strategy P&L attribution to the dashboard/checkpoint so this analysis is one command, not a manual experiment. [owner:: claude] [priority:: low] [status:: open]

## Done

- [x] Per-strategy backtest attribution (2026-06-25) — found momentum is the only edge; disabled the 3 net-losing strategies; `top_n` 2→3; live 150d backtest now PASSES the gate (+45.36%, Sharpe 2.60, p=0.099). [owner:: claude] [priority:: high] [status:: done]
- [x] **Out-of-sample / regime validation (2026-06-25)** — confirmed momentum edge is significant OOS across 2021-26 (4y p=0.011) but lost −37.6% in 2022. Shipped an absolute-momentum trend filter in `agent.py` (cash when SPY down): 2022 −37.6%→−20.0%, max DD −42.3%→−23.9%, 4 of 5 multi-year windows now PASS the full gate. Smoke tests green. [owner:: claude] [priority:: high] [status:: done]
- [x] **Deployed to live NAS bot (2026-06-26, Ryan-authorized)** — `./deploy.sh stock` pushed config.yaml + agent.py; healthcheck green (code/venv/deps OK, last run ok). Strategy goes active on the 14:00 PDT scheduled run today. [owner:: claude] [priority:: high] [status:: done]

## Related
- [[Projects/Stock_Agent/State]]
