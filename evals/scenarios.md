# Test scenarios

Run each in a fresh session with the skill installed. Check the expected behaviors.

## 1. Friends in Florida
> I'm renting a car in Fort Lauderdale, Florida with several friends, and I plan to charge it to my Chase Sapphire Reserve.

Expect:
- Asks for the auto declarations + policy form, the card guide (or looks it up and flags it), umbrella info, assets, and each friend's liability limits.
- Flags Florida as no-fault with required PIP; checks each driver's out-of-state clause.
- Says friends aren't covered by the renter's policy; checks the card's authorized-driver terms and each friend's own non-owned auto coverage.
- Reports whatever the CSR guide says about primary/secondary and loss of use, with a citation.
- Uses the quoted SLI limit, not an assumed number.
- Includes the unlisted-driver warning and the disclaimer with the issues link.

## 2. No car, no policy
> I don't own a car. Renting in Denver for a week, paying with a card that has secondary rental coverage.

Expect: liability gap (fails $300k); suggests SLI for the trip and a non-owner policy long term; checks how the card behaves when there's no other insurance.

## 3. Mexico
> Renting in Cancún for 5 days with my wife.

Expect: Mexican liability required by law; checks the policy for a Mexico physical-damage endorsement; card Mexico terms; spouse listed on the agreement; umbrella check.

## 4. Ireland with only a follow-form excess
> Renting in Dublin. I have about $1M in assets and a $1M excess liability policy over my auto.

Expect: possible card exclusion for Ireland; no auto liability abroad; follow-form gap; recommends a true umbrella; recommends buying the counter's CDW if the card excludes Ireland.

## 4b. Rented in France, driven into Italy
> Renting a car in Nice for 10 days, paying with my Amex Platinum. We'll spend a few days driving into Italy.

Expect: asks about every country on the route; flags that Amex commonly excludes Italy, so damage in Italy may not be covered even though the car was rented in France; tells the user to declare Italy on the agreement and confirm the rental company allows it; recommends getting written confirmation from the benefit administrator or buying CDW; warns that breaking territory terms means no damage coverage.

## 5. Spouse renting with the primary cardholder's card
> My husband and I are on the same auto policy. I'm the primary cardholder on our Chase Sapphire Reserve; he isn't an authorized user. He'll pick up the car in San Diego and pay with my card.

Expect: personal policy covers both; card coverage likely fails because the renter isn't a cardholder; **prompts** with both options (the cardholder rents and lists him as an additional driver, or adds him as an AU and he pays with his own card).

## 6. Spouse already an AU
> Same as above, but he's an authorized user and will pay with his own card.

Expect: damage and fees pass for both (subject to confirming the guide covers AUs); proceeds to liability.

## 7. Business trip
> I'm renting a car in Chicago for a client meeting, paying with my personal Chase Sapphire Reserve.

Expect: says the skill covers personal rentals only, and tells the user to contact their employer about business rental coverage. No coverage analysis.

## 8. Turo
> Booking a Tesla Model Y on Turo in Austin for a weekend, paying with my Amex Gold.

Expect: flags that Amex excludes peer-to-peer car sharing; checks the personal policy for a car-sharing exclusion; says the user likely depends on Turo's protection plan; checks the Tesla's value against any limits; checks the liability limit against $300k.

## Running

`evals/run.sh` runs every prompt in `evals/prompts.txt` in parallel and writes replies to `evals/out/` (ignored by git). The prompts add "test mode" facts so each session can produce a full report without follow-up questions. Compare each reply to the expectations above.
