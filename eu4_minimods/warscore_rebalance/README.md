# Warscore Rebalance

This mod applies one of the following permanent province modifiers to every
owned province, based on its owner:

- Owned by a great power: `local_warscore_cost_modifier = -0.5`.
- Owned by an independent, non-great power: `local_warscore_cost_modifier = 0.5`.

Subjects that are not great powers intentionally receive neither modifier.

`local_warscore_cost_modifier` is province-scoped, so the definitions live in
`common/event_modifiers`. A scripted effect removes either rebalance modifier
from each owned province, then applies the appropriate one with an indefinite
duration. It runs for every country on `on_startup` and `on_monthly_pulse`, so
it also catches newly acquired provinces and changes in country status.
