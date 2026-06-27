---
title: Stock Agent — Go-Live Plan
project: stock-agent
type: plan
updated: 2026-06-26
tags: [stock, trading, go-live, risk]
---

# Stock Agent — Go-Live Plan

Path from validated paper strategy → real money. **Claude never flips `paper_mode` and
never trades real money — every money step below is Ryan's to execute.** See
[[Projects/Stock_Agent/State]] for the strategy and validation evidence.

## Where we are (2026-06-26)
- Strategy: momentum-only, `top_n=3`, + absolute-momentum trend filter (cash when SPY down).
- Backtest: +44.5% / Sharpe 2.64 (recent 150d) and significant OOS (4y p=0.011); 4 of 5
  multi-year windows pass the full gate. Deployed live to the NAS bot today.
- Caveat: params are still **in-sample**. The +numbers are what the strategy *would have*
  done historically — not yet proven on fresh forward data.

## Gate (all four must pass — already in `config.yaml`)
`min_closed_trades 30` · `min_sharpe 1.0` · `max_drawdown 20%` · `max_p_value 0.10`

## Step 1 — Forward-test on live paper (do NOT skip)
The whole point of paper mode is an out-of-sample test on data the params never saw.
- Let the NAS bot run the new strategy daily (14:00 PDT) and accumulate **~30 fresh closed
  trades** from 2026-06-26 onward (not the 23 legacy trades under the old 4-strategy config).
- Weekly: on the NAS run `run-agent.sh stock agent.py --checkpoint` (or check the dashboard)
  and read Sharpe / drawdown / p-value on the **forward** trades only.
- Pass bar: forward Sharpe ≥ 1.0 and max drawdown < 20% over those ~30 trades. If forward
  results are much worse than backtest, the edge was overfit — stop, do not go live.

## Step 2 — Sanity checks before risking money
- Confirm the trend filter actually fired during any down days (check `regime=down` lines in
  `logs/stock.log` → no new momentum entries on those days).
- Decide real starting capital. The strategy is %-based; $100 was a paper figure. Position
  sizing (`max_position_pct 0.15`, `min_trade_usd 1.00`) and **real broker fees + spread**
  must be modeled — at small capital, fees can erase the edge. Pick a starting size where
  per-trade friction is < ~0.1% (this likely means starting with more than $100).
- Pick the broker/API and confirm it supports the universe + fractional shares the bot assumes.

## Step 3 — Go live (Ryan executes)
- Wire the bot to the real broker API (new code — currently paper-only simulation).
- Flip `config.yaml` `paper_mode: true → false` **only after Steps 1–2 pass.**
- Start small (a fraction of intended capital) for the first 2–4 weeks; compare live fills
  vs the bot's assumed prices to measure real slippage.
- Keep the 8% hard stop and the daily 5% loss limit on from day one.

## Known residual risks
- 4.75-year backtest still hit 23.9% drawdown — a binary SPY filter can't fully tame a
  2021-top-into-2022-bear sequence. Tracked: graded regime exposure / per-position trend
  filter (see [[Projects/Stock_Agent/Tasks]]).
- Momentum is regime-dependent by nature: expect flat/negative stretches in choppy markets.
- The 3 disabled strategies are net-negative as written — leave off until repaired.

## Related
- [[Projects/Stock_Agent/State]] · [[Projects/Stock_Agent/Tasks]] · [[project-stock-agent-strategy]]
