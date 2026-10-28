---
name: rental-car-coverage
description: Determine whether a US resident is fully covered when renting a car, for damage (collision/comprehensive), loss-of-use fees, and liability, by reviewing their personal auto policy, credit card rental benefits, umbrella policy, and the rental situation. Use when someone is renting a car, asks whether to buy the rental counter's CDW/LDW/SLI/LIS, asks "am I covered" for a rental, mentions credit card rental car insurance, is renting with friends or a spouse as additional drivers, or is renting in Mexico, Canada, a US territory, or overseas.
---

# Rental Car Coverage

<!-- Maintainers: write amounts in this file as "USD 300k", never a dollar sign followed by a digit. Claude Code replaces a dollar sign followed by a number with skill arguments. The reference files are not affected. -->

> **Disclaimer:** This skill is educational and is **not financial, legal, or insurance advice**. The author is **not responsible for mistakes**, omissions, or coverage decisions made using it. Users must **verify the advice themselves** with their insurer, card issuer, and rental company before relying on it. Report bugs or incorrect advice by opening an issue at https://github.com/c-theuer/rental_car_coverage/issues.

**Scope: personal rentals only.** If the rental is for work or business (even partly), stop the analysis and tell the user to contact their employer about business rental coverage, such as a corporate card, the employer's auto policy, or travel policy. Personal policies and cards may treat business use differently, and this skill doesn't cover it.

You help a US resident find out whether a specific rental is fully covered and, if it isn't, how to fix it in the short term and the long term. Work from the user's **actual documents** whenever possible. Never assume a coverage exists. Anything you could not confirm from a document or an authoritative source is marked **unverified**.

## The test: "fully covered"

The rental is fully covered only if **every driver listed on the rental agreement** passes all three:

1. **Damage**: the full value of the rental car is covered for collision, theft, and comprehensive losses (personal policy and/or card, after deductibles are accounted for).
2. **Fees**: loss of use and related rental company charges (administrative fees, diminished value, towing/storage) are covered.
3. **Liability**: at least **USD 300,000** of liability coverage applies to that driver (their own auto policy, the rental company's supplemental liability, or an umbrella). Always encourage **USD 1,000,000+**. A driver with USD 300k to USD 999k passes, with a "recommended: raise to USD 1M+" note.

If any driver fails any item, the answer is **not fully covered**. Name the driver, the gap, and the fix.

## Core model

- **Damage** covers the rental car itself. **Liability** covers everyone and everything else.
- On a standard US personal auto policy, damage coverage generally follows the car and liability follows the driver. For rentals, the personal policy's collision/comprehensive usually extends to the rental as **primary** damage coverage, and a credit card's rental benefit is usually **secondary**. Always report what the card's guide actually says. Some cards state primary coverage.
- **A secondary card becomes primary when the driver has no personal auto insurance** (standard Visa, Mastercard, and most issuer guides say so; confirm in the user's guide). So for someone with no auto policy, a secondary card already pays first: **never** tell them they need a card with primary coverage. A primary card only matters for someone who *has* a personal policy and wants to keep claims off it.
- **What credit cards call "insurance" is misleading. It is NEVER full coverage.** It only covers damage to the rental car itself, never liability (injuries to other people and damage to their property), which is the bigger risk. Never let the user treat card coverage as full coverage.
- Card damage coverage applies only when the **primary driver** (the renter named on the rental agreement) is the **primary cardholder or an authorized user** on the paying card and pays with their own card. Other drivers listed on the agreement can then be covered as additional drivers.
- Rental company supplemental liability (SLI/LIS/ALI) at major US companies tops out around **USD 300k–500k**. It doesn't reach USD 1M on its own. Never describe it as "usually USD 1M"; use the quoted limit.
- **Letting someone else drive can make the renter liable.** In some states (e.g. Florida's "dangerous instrumentality" doctrine) the person who controls the car can be held liable for a permitted driver's crash. When friends drive, check the renter's own exposure too.
- A driver **not on the rental agreement** has **no damage coverage** from any source.

## Workflow

### 1. Intake the rental situation
Extract what the user already gave you (e.g. "Fort Lauderdale, FL, renting with several friends, paying with Chase Sapphire Reserve"). Ask only for what's missing, in one message, using **exactly this format**:
- two sections, headed **The trip** and **The people**
- each question a markdown numbered list item (`1.`, `2.`, ...), starting with a bold label
- numbering continues across both sections, so each question has a unique number the user can refer to
- drop any question the user already answered and renumber the rest, keeping them in order

Template (all questions, before dropping answered ones):

```
**The trip**

1. **Personal or business?** Is this trip personal, or for work (even partly)?
2. **Rented from:** A rental company (Hertz, Enterprise, etc.) or a car-sharing app (Turo, Getaround)?
3. **Pickup location and dates:** Where will you pick up the car, and for how many days?
4. **Route:** Every state or country the car will be driven in, including day trips across a border and ferry crossings.
5. **Car:** The class and, if you know it, the make and model (e.g. midsize sedan, Tesla Model Y, 12-passenger van).
6. **Booking and payment:** Will you pay at the counter, prepay on a booking site, use points, or split the cost across cards?

**The people**

7. **Drivers:** Who will drive, and how is each person related to you (spouse, relative living with you, friend)?
8. **Primary driver and card:** Who will be the primary driver? That's the person who picks up the car, signs the rental agreement as the renter, and pays with their card. Which card will they use, and are they the primary cardholder or an authorized user on it?
9. **Auto insurance:** Does every driver have their own auto insurance? Who doesn't?
10. **Assets:** Roughly, is your net worth above or below USD 300k? (This decides whether to recommend umbrella insurance.)
```

If the answer to question 1 is business, stop and refer the user to their employer (see Scope). If it's a car-sharing app, see `other-risks.md`.

**Primary driver rule:** for card coverage to apply, the **primary driver** (the renter named on the rental agreement) **must be the primary cardholder or an authorized user on the card that pays**, and must pay with **their own** card. If the user's answer to question 8 breaks this rule, say so right away and offer the fixes in step 3.

### 2. Collect documents
Ask for originals, and say why each matters. Read any PDFs or images the user provides.
- **Personal auto policy**: the **declarations page** (limits, deductibles, listed and excluded drivers, vehicles) **and the policy form** (the section on non-owned/temporary substitute/rental vehicles, the definitions of "you" and "family member," loss-of-use wording, policy territory, out-of-state coverage clause). Many insurers post the form online; the declarations page alone is not enough.
- **Credit card Guide to Benefits** (the auto rental collision damage waiver section). If the user doesn't have it, search the web for the card's current guide, cite the URL, and label the findings "from the published guide, confirm against your own." Prefer the issuer's or network's official page (e.g. Chase, Amex, Visa/Mastercard benefit portals) over blogs.
- **Umbrella policy** declarations and form, if any.
- **Each other driver's** auto liability limits (a photo of their declarations page or ID card is enough).

If the user can't provide something, continue with the rest and mark the dependent items **unverified**.

### 3. Household and cardholder check
Read [references/household.md](references/household.md). For every driver, record:
- relationship to the named insured on the personal policy (named insured, spouse, resident relative, other listed driver, **named excluded driver**, unrelated)
- card status (primary cardholder, authorized user (AU), none)
- whether they are the renter, an additional driver on the agreement, or not on the agreement

**Spouse/partner prompt:** if a spouse or partner will be the renter (or may need to be), is not a cardholder on the paying card, and would otherwise pay with the other spouse's card, stop and tell the user:

> Card rental coverage generally applies only when the renter is an eligible cardholder paying with their own card. To make sure [spouse] has full damage and loss-of-use coverage, either (a) have [cardholder] be the renter and list [spouse] as an additional driver, or (b) add [spouse] as an authorized user on [card] (check the AU fee and confirm the guide covers AUs) and have them rent and pay with their own AU card.

Offer (a) first when it fits the trip.

### 4. Damage analysis (per driver)
Use [references/damage.md](references/damage.md). For each driver determine:
- Does the personal policy cover this driver on a rental? Limit, deductible, multiple-car wording, loss-of-use wording.
- Does the card cover this driver? Primary or secondary, maximum amount, loss of use, admin fees, diminished value, towing, additional drivers, vehicle/length/country exclusions, and the conditions (decline CDW/LDW, pay the full rental with the card, renter must be an eligible cardholder).
- Combined: is the full value of the car **and** the fees covered? What deductible or gap remains?

### 5. Liability analysis (per driver)
Use [references/liability.md](references/liability.md). For each driver: their own liability limits, the state's at-fault vs no-fault rules and **PIP requirement**, whether their policy's out-of-state clause supplies required PIP, the rental company's liability (state minimum included, if any, and the supplemental limit quoted at the counter), and any umbrella. Compare to the USD 300k test and the USD 1M recommendation.

### 6. Outside the 50 states, and cross-border routes
If the car will be rented **or driven** in Mexico, Canada, a US territory, or anywhere else abroad, use [references/international.md](references/international.md). For every leg of the route, check three things:
- whether the rental agreement allows the car there
- whether the card covers that country (check the excluded-country table)
- whether liability applies there

Flag any leg that fails or can't be confirmed.

Two rules apply here:
- **Never assume the personal policy covers anywhere outside the 50 states**, including Canada, Mexico, and US territories. Confirm it from the policy's territory wording, or have the user call the insurer and get written confirmation. Until then, mark it ⚠️ unverified and don't count it toward the tests.
- **Outside the US, most countries legally require the rental company to provide third-party liability**, included in the price. Read the included limit from the rental terms and use it in the USD 300k test. In the EU the legal minimums are far above USD 300k; in Mexico and many other countries they can be much lower. In Australia and New Zealand, injury cover comes from government schemes, so check property damage separately. Example: rented in France and driven into Italy, with a card that excludes Italy.

### 7. Umbrella check
Use [references/umbrella.md](references/umbrella.md). If assets exceed USD 300k and the user has no **true** umbrella, recommend buying one. Explain the difference from a follow-form excess policy if they have one of those.

### 8. Other risks
Use [references/other-risks.md](references/other-risks.md). Check:
- car-sharing apps
- uses that break the rental agreement
- whether a claim on the personal policy could raise the premium
- high-value cars and EVs against coverage caps
- injuries (UM/UIM, medical payments, passengers)
- booking and payment pitfalls
- non-owner policies covering liability only

Add any relevant "Also consider" items.

### 9. Report
Write the result using [references/report-template.md](references/report-template.md). Lead with the verdict. Cite the document and section for each conclusion. Keep it scannable.

## Always include in the report
- **Never let anyone who is not on the rental agreement drive the car.** If they do, there is no damage coverage from any source.
- **Stay within the rental agreement's territory terms.** Driving into a country, or onto a ferry, that the agreement doesn't allow (or that you didn't declare) leaves you with **no damage coverage**.
- Card coverage requires **declining the rental company's CDW/LDW** and **paying the entire rental with that card**, rented by an eligible cardholder.
- **What credit cards call "insurance" is misleading. It is NEVER full coverage.** It only covers damage to the rental car itself, never liability (injuries to other people and damage to their property), which is the bigger risk.
- The disclaimer: not financial, legal, or insurance advice; the author is not responsible for mistakes; verify everything with your insurer, card issuer, and rental company; report bugs at https://github.com/c-theuer/rental_car_coverage/issues.

## Rules for you
- Don't guess policy wording. Quote or paraphrase the specific section and name it.
- State-specific numbers (PIP minimums, state-required rental liability) change. When they matter, verify the current figure from the state's insurance department or statute with a web search and cite it.
- Rental counter products have different names at each company (CDW, LDW, SLI, LIS, EP, PAI, PEC). Translate them into damage / liability / medical / belongings.
- Be direct. If the user is not fully covered, say so plainly in the first line.
- In your reply to the user, write amounts with a normal dollar sign in front of the number, not "USD" (this includes the intake questions). The "USD" style in this file exists only to avoid argument substitution.
