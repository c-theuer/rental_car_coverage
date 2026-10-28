# Rental Car Coverage — a Claude Skill

A [Claude skill](https://docs.claude.com/en/docs/agents-and-tools/agent-skills/overview) that helps **US residents** work out whether a rental car is fully covered, and how to fix it if it isn't.

**Personal rentals only.** For a rental that's for work or business, contact your employer about business rental coverage.

Give Claude your rental situation, for example:

> I'm renting a car in Fort Lauderdale, Florida with several friends, and I plan to charge it to my Chase Sapphire Reserve.

The skill then:

1. Asks for the missing details: who drives, who rents, which card pays, the vehicle, and where you're going.
2. Asks for your **actual documents**: auto policy declarations and policy form, your card's Guide to Benefits (or looks it up and flags it), umbrella policy, and other drivers' liability limits.
3. Checks **damage** (collision/comprehensive, loss of use, admin fees), **liability**, and **PIP** for **every driver**. This includes spouses, authorized users on cards, and friends.
4. Handles Mexico, Canada, US territories, and overseas rentals. It asks where the car is rented **and** everywhere it will be driven, and flags countries cards commonly exclude and cross-border problems, such as renting in France and driving into Italy. It also checks whether you have a true umbrella or a follow-form excess policy.
5. Answers **"Are you fully covered?"** and gives **short-term** fixes for this trip and **long-term** fixes.

## What "fully covered" means here

For **every driver on the rental agreement**:

1. **Damage**: the full value of the rental car is covered.
2. **Fees**: loss of use and related rental company charges are covered.
3. **Liability**: at least **$300,000** applies to that driver. The skill encourages **$1,000,000+**.

And always:
- **Never let anyone who isn't on the rental agreement drive.** If they do, there's no damage coverage.
- **Stay within the rental agreement's territory terms.** Driving into a country the agreement doesn't allow means no damage coverage.

## Install

### claude.ai
1. Download `rental-car-coverage.zip` from the [latest release](https://github.com/c-theuer/rental_car_coverage/releases/latest).
2. In claude.ai, go to **Settings → Capabilities → Skills**, choose **Upload skill**, and select the zip.
3. Start a chat and describe your rental.

### Claude Code
```bash
git clone https://github.com/c-theuer/rental_car_coverage.git ~/.claude/skills/rental-car-coverage
```
Or clone it anywhere and symlink the folder into `~/.claude/skills/`.

## Repository layout

```
SKILL.md                   # workflow and rules Claude follows
references/
  damage.md                # personal policy and credit card damage coverage
  household.md             # spouses, household drivers, authorized users
  liability.md             # liability, no-fault/PIP states, rental SLI
  international.md         # Mexico, Canada, US territories, overseas
  umbrella.md              # true umbrella vs follow-form excess
  other-risks.md           # car sharing, agreement violations, EVs, injuries, payment pitfalls
  report-template.md       # output format
evals/scenarios.md         # test scenarios
```

## Disclaimer

This skill is for **educational purposes only** and is **not financial, legal, or insurance advice**. Insurance policies, credit card benefits, rental company terms, and state laws vary and change. The author is **not responsible for mistakes**, omissions, or any decisions or losses arising from using this skill. **Verify the skill's advice yourself** with your insurer, credit card issuer, and rental company before relying on it.

## Reporting bugs

Found a bug, wrong advice, or outdated information? Please [open an issue](https://github.com/c-theuer/rental_car_coverage/issues). Include the scenario you described (leave out personal details) and what the skill got wrong.

## License

[MIT](LICENSE)
