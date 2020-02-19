# It starts with 139 different bonuses, need to filter them down to manageable levels
class BonusScoring
  def initialize
    @ht = Hash.new(0)
  end

  def round!
    @ht.each do |k,v|
      @ht[k] = v.round(6) if v.is_a?(Float)
    end
  end

  def to_h
    round!
    @ht.dup
  end

  def keys
    @ht.keys
  end

  def method_missing(*args)
    if args.size == 2
      k, v = *args
      if @ht.has_key?(k)
        @ht[k] += v
      else
        @ht[k] = v
      end
    else
      super
    end
  end

  ### Bonus conversions ###

  [
    # This is probbaly a net negative, since you're less likely to get random same dynasty with another country
    :heir_chance,

    # Presitge is just so irrelevant let's not bother tracking it
    :prestige,
    :prestige_decay,
    :prestige_from_land,
    :prestige_from_naval,

    # loans are basically irrelevant unless you go full florrynomics, and that's no longer possible
    :interest,

    # unless you only own 1-2 ports, it's completely irrelevant
    :global_ship_recruit_speed,
    :global_regiment_recruit_speed,
    :build_time,

    # if you have to worry about that, you're doing something wrong
    :enemy_core_creation,
    :core_decay_on_your_own,

    # These are so godawfully underpowered we might just as well ignore them
    :rebel_support_efficiency,
    :embargo_efficiency,
    :global_spy_defence,

    # Ignored because ridiculously underpowered
    :culture_conversion_cost,

    # Was pretty close to irrelevant, not sure how much it matters post 1.12
    :global_garrison_growth,
    :garrison_size,

    # Examples when it matters are extremely conditional
    :trade_range_modifier,

    # AI is completely immune to naval attrition, so this is extremely conditional (player only)
    :naval_attrition,

    # Influence matters but we have no idea which direction you care about
    :mr_aristocrats_influence,
    :mr_guilds_influence,
    :mr_traders_influence,
    :bureaucrats_influence,
    :enuchs_influence,
    :temples_influence,
    :rr_girondists_influence,
    :rr_royalists_influence,
    :rr_jacobins_influence,

    # This could be a bit more exploitable, but it's still situational which direction you care about,
    :monthly_piety,

    # Far too conditional
    :devotion,
    :church_power_modifier,

    # Sailors seriously just don't matter
    :global_sailors_modifier,
    :sailors_recovery_speed,
    :sailor_maintenance_modifer,

    # Naval battles, they hard to model and relatively low importance
    :sunk_ship_morale_hit_recieved,
    :capture_ship_chance,

    # Unless there are special events, this seems purely cosmetic
    :female_advisor_chance,
    :may_recruit_female_generals,
  ].each do |k|
    define_method(k){|_| }
  end

  # Bonus itself is completely irrelevant, even if you play merc game there are always enough
  # This bonus (12/100%) is actually converted further to relative bonus assuming base force limit 50
  # so +25% possible mercenaries (+3 absolute force limit) is assumed to translate to
  # 6% land force limit
  def possible_mercenaries(v)
    land_forcelimit(12*v)
  end

  # They aren't worth the same, but very conditional and hard to judge value
  def may_perform_slave_raid(v)
    extra_minor_abilities 1
  end
  def reduced_stab_impacts(v)
    extra_minor_abilities 1
  end

  def may_explore(v)
    @ht[:may_explore] += 1.0
  end
  def auto_explore_adjacent_to_colony(v)
    # Very weak explore variant, might be good enough for some countries
    @ht[:may_explore] += 0.25
  end

  # Assume used 75% of the time
  def diplomatic_upkeep(v)
    monthly_dip_points 0.75 * v
  end
  def free_leader_pool(v)
    monthly_mil_points 0.75 * v
  end

  # This generated some monthly increase, just without cap increase
  # since it's so rare to be at cap, let's count it as 90% as good
  def manpower_recovery_speed(v)
    global_manpower_modifier 0.90 * v
  end

  # Assume 20% of your armies are in attrition mode on average,
  # and your army size is equal to your manpower pool size on average
  def land_attrition(v)
    global_manpower_modifier -0.2*v
  end

  # Since conversion in territories, estimate 50% own, 10% heretic, 40% heathen
  def tolerance_own(v)
    global_revolt_risk -v * 0.50
  end
  def tolerance_heretic(v)
    global_revolt_risk -v * 0.10
  end
  def tolerance_heathen(v)
    global_revolt_risk -v * 0.40
  end
  def global_unrest(v)
    global_revolt_risk v
  end

  # For most countries army tradition will be much higher than navy tradition
  # Assume average 25% navy and 75% army tradition
  def navy_tradition_decay(v)
    navy_tradition -0.25*v
  end
  def army_tradition_decay(v)
    army_tradition -0.75*v
  end

  # Guestimate resting ponts of 20% army and 5% navy tradition from typical amount of fighting
  def army_tradition_from_battle(v)
    army_tradition(0.2 * v)
  end
  def naval_tradition_from_battle(v)
    army_tradition(0.05 * v)
  end

  # Assume 2 diplomats, and diplomats spending 25% of their time fabricating, 25% improving relations
  # Since this is 1/(1-x) not 1+x (50% reduction means you get 200% work done, not 150% work)
  # I arbitrarily added 1.5x factor here, but it's really just ballpark.
  #
  # Justifying trade conflicts may take 1% of your diplomat-time - likely far less but there's some extra value
  # from time sensitivity here
  #
  # Signs opposite since it's time vs modifier
  def fabricate_claims_cost(v)
    diplomats 2 * 1.5 * 0.25 * -v
  end
  def improve_relation_modifier(v)
    diplomats 2 * 1.5 * 0.25 * v
  end
  def justify_trade_conflict_cost(v)
    diplomats 2 * 1.5 * 0.01 * -v
  end
  # It's at least as good as fabrication cost discount
  def spy_offence(v)
    diplomats 2 * 0.25 * v
  end

  # Hard cold facts:
  # * 22400 points spent on ideas, or 5/month
  # * 54000 base points spent on tech, or 12/month (actual differs, but modifier is applied to base not total)
  def idea_cost(v)
    monthly_mixed_monarch_points 5 * -v
  end
  def technology_cost(v)
    monthly_adm_points 4 * -v
    monthly_dip_points 4 * -v
    monthly_mil_points 4 * -v
  end
  def mil_tech_cost_modifier(v)
    monthly_mil_points 4 * -v
  end
  def dip_tech_cost_modifier(v)
    monthly_dip_points 4 * -v
  end
  def adm_tech_cost_modifier(v)
    monthly_adm_points 4 * -v
  end

  # Assuming +1 stab button / 15 years (base cost 100, mods apply to this not total)
  # It's not uncommon to be at permanent +2/+3 due to events, but then you could be deep in negative territory
  def stability_cost_modifier(v)
    monthly_adm_points (-v * 100.0 / 12 / 15)
  end
  # Assuming one reduce WE button press every 10 years
  # It's somewhat common early game, often multiple presses same day on peaceout, late game not really due to absolutism
  def war_exhaustion_cost(v)
    monthly_dip_points (-v * 75.0 / 12 / 10)
  end
  # -2 WE is worth 75 dip
  # Assume you are at positive-enough-to-care WE 25% of the time
  # This is *monthly* number
  def war_exhaustion(v)
    monthly_dip_points -v*(75.0/2.0)*0.25
  end
  # Assuming reduce inflation button is used once / 50 years
  def inflation_action_cost(v)
    monthly_adm_points (-v * 75.0 / 12 / 50)
  end
  # -2 inflation is worth 75 adm
  # Assume you are at positive-enough-to-care inflation 25% of the time
  # This is *annual* number
  def inflation_reduction(v)
    monthly_adm_points v*(75.0/2.0/12)*0.25
  end
  # This is mostly used to very quickly gain absolutism
  # Assume only cheapest is clicked (50), once every 20 years
  def harsh_treatment_cost(v)
    monthly_mil_points (-v * 50.0 / 12 / 20)
  end

  # Assume average of 8dev/year cored before efficiency unlocks,
  # proportionally more after efficiency
  #
  # This also affects coring time, so reduces OE
  # 8dev/year = average OE of 24%
  def core_creation(v)
    overextension(v * 0.24)
    core_creation_cost(v)
  end

  def core_creation_cost(v)
    monthly_adm_points (-v * 10.0 * 8.0 / 12)
  end

  def overextension(v)
    global_foreign_trade_power v*-1.0
    stability_cost_modifier v*0.5
    mercenary_cost v*0.5
    diplomatic_reputation v*-2.0
    improve_relation_modifier v*-0.5
    global_unrest v*5.0
    yearly_corruption v*0.5
  end

  # Fighting it costs 0.05 gold / effective dev
  # Typical incomes are of order of magnitude of 0.25 gold / effective dev
  #
  # Assume there's half a chance you're at positive corruption
  # And half that you're debating to not lose your bonus (and debasing gives you half as much)
  def yearly_corruption(v)
    money -v * 0.20 * 0.75
  end

  # Assume average of 4dev/year diploannexed before efficiency unlocks,
  # proportionally more after efficiency
  def diplomatic_annexation_cost(v)
    monthly_dip_points (-v * 10.0 * 4.0 / 12)
  end
  # Assume half of your cored dev comes from unjustified demands
  # (this also means demands on anyone except war leader)
  def unjustified_demands(v)
    monthly_dip_points -v * 3 * 8.0 / 12
  end

  # Based on simulations average AI country presses the button 28 times during the game
  # and average base cost is 65 (= mean number of times it was used before on same province is 3)
  # This means average monthly development spending is 0.4
  #
  # Big assumption is that humans are same as AI here
  def development_cost(v)
    buttons_per_month = 28.0/(1820-1444)/12
    monthly_mixed_monarch_points (buttons_per_month * 65 * -v)
  end

  # Assumptions:
  # * average build will be about: 50% inf, 10% cav, 40% art
  # * of that 10% merc inf, and 40% regular inf, never any merc cav/art
  # * inf take double the damage as other types, so double reinforcement costs
  # * art/inf combat ability contributes same as their numbers, cavalry contributes double their numbers
  #
  # * base costs ratios are: inf 500 (25%), cav 250 (13%), art 1200 (62%)
  # * base reinforce ratios: inf 1000 (41%), cav 250 (10%), art 1200 (49%)
  # * base combat ability ratios: inf 50 (46%), cav 20 (18%), art 40 (36%)
  #
  # For land units cost and maintenance are proportional

  # For navy it's harder to make good assumptions.
  # First, ships need to be rebuilt and maintenance cost are not proportional to recruitment costs
  # TCO over 40 years (when it will need to be rebuilt if not sunk yet):
  # * heavy     - 250.16
  # * light     -  59.84
  # * galley    -  25.84
  # * transport -  31.20
  #
  # Actual fleet composition being extremely dependent on your circumstances,
  # but decent ballpark figures are:
  # 50% light ships, 10% heavy ships, 15% galleys, 25% transports
  #
  # So costs are:
  # 45% light, 37% heavy, 6% galley, 12% transport
  #
  # and maintenance is 70% of total cost
  #
  # Since land units last forever I assume maintenance is 90% of the cost
  #
  # Of course nations with big galley cost discounts might go full galley spam because of them,
  # but then you get into naval force limit issues etc. It's too conditional to consider here
  #
  # As for power, by canons/hull strength we can sort of assume ballpark figures:
  # 1 heavy = 3 lights or galleys = 6 transports
  # so total power of your fleet would then be:
  # 30% heavy, 45% light, 15% galley, 10% transport

  # http://www.eu4wiki.com/Land_warfare#Comparison
  def infantry_cost(v)
    calculated_land_cost 0.25 * 0.1 * v
  end
  def cavalry_cost(v)
    calculated_land_cost 0.13 * 0.1 * v
  end
  def artillery_cost(v)
    calculated_land_cost 0.62 * 0.1 * v
  end
  def global_regiment_cost(v)
    calculated_land_cost v
  end
  def infantry_power(v)
    land_unit_power 0.46 * v
  end
  def cavalry_power(v)
    land_unit_power 0.18 * v
  end
  def artillery_power(v)
    land_unit_power 0.36 * v
  end
  # Artillery fires from backrow 95% of time
  # Mostly in very long battles you can sometimes have artillery front row
  # because infantry got beaten up so bad
  # I'm assuming this scales with base damage
  # (and isn't sneakily double, changing 50% to 65%)
  def backrow_artillery_damage(v)
    artillery_power(v*0.95)
  end
  # Very vaguely estimate that 100% more cavalry flanking range makes your cavalry 50% more effective
  # which is probably an overstatement in reality due to deployment logic, battles at full width etc.
  def cavalry_flanking(v)
    cavalry_power(0.5 * v)
  end
  # Assume 50% damage in fire and 50% in shock
  # this isn't true very early game where shock rules, but should be true overall
  #
  # Weight damage taken and damage received modifiers equally
  # combat ability only affect damage dealt
  # discipline affects damage both taken and dealt
  def shock_damage_received(v)
    land_unit_power v*-0.50
  end
  def shock_damage(v)
    land_unit_power v*0.50
  end
  def fire_damage_received(v)
    land_unit_power v*-0.50
  end
  def fire_damage(v)
    land_unit_power v*0.50
  end

  def heavy_ship_cost(v) # not seen anywhere
    calculated_ship_cost 0.37 * v
  end
  def light_ship_cost(v)
    calculated_ship_cost 0.45 * v
  end
  def galley_cost(v)
    calculated_ship_cost 0.06 * v
  end
  def transport_cost(v) # not seen anywhere
    calculated_ship_cost 0.12 * v
  end
  def global_ship_cost(v)
    calculated_ship_cost v
  end

  def naval_maintenance_modifier(v)
    calculated_ship_cost 0.7*v
  end
  def land_maintenance_modifier(v)
    calculated_land_cost 0.9*v
  end

  def heavy_ship_power(v)
    naval_unit_power 0.30 * v
  end
  def light_ship_power(v)
    naval_unit_power 0.45 * v
  end
  def galley_power(v)
    naval_unit_power 0.15 * v
  end
  def transport_power(v)
    naval_unit_power 0.10 * v
  end
  # Assume 50% of naval battles are at full width
  def global_naval_engagement_modifier(v)
    naval_unit_power 0.5 * v
  end

  # Assume ships spend 20% of time in repairs
  # And half of that could be avoided if they could reapir at sea
  def sea_repair(v)
    raise unless v == true
    naval_unit_power 0.2*0.5
  end
  def global_ship_repair(v)
    naval_unit_power v*0.2
  end

  # Assume your light ships spend 20% of their time blockading, so you need fewer if you have blockade efficiency
  def blockade_efficiency(v)
    light_ship_cost -v*0.20
  end

  # Assume your light ships spend 10% of their time privateering, so they hive you more money with privateer efficiency
  # Assume you get 2x as much money as with trade steering on average in situations where you want to privateer
  def privateer_efficiency(v)
    trade_steering 2*v*0.1
  end

  # Assume 25% of nodes are inland, so this bonus is worth 25% of trade steering bonus
  def caravan_power(v)
    trade_steering 0.25*v
  end

  # Discipline is twice as powerful as combat ability as it affects
  # both damage dealt (like combat ability) and damage taken:
  # damage dealt = (100% + combat ability) * (100% + discipline modifiers) * other stuff
  # damage taken =                           (100% - discipline modifiers) * other stuff
  # (durability is naval equivalent of discipline)
  def discipline(v)
    land_unit_power(2*v)
  end
  # - infantry does 46% to total damage
  # - but it takes most of damage in combat
  #   - if art takes damage 10% of time, cav 50% of time (flanking otherwise), and inf 100% of time,
  #     the damage reduction from infantry discipline is like 85% of total units
  def infantry_discipline(v)
    land_unit_power(0.46*v) # damage dealt
    land_unit_power(0.85*v) # damage received
  end
  # Estimate 20% of infantry is mercs
  def mercenary_discipline(v)
    infantry_discipline(0.2*v)
  end
  def ship_durability(v)
    naval_unit_power(2*v)
  end
  # Morale increases morale damage, and defense. Discipline does that and regular damage/defense,
  # so morale is worth about half as much as discipline
  def land_morale(v)
    land_unit_power 0.5 * v
  end
  def naval_morale(v)
    naval_unit_power 0.5 * v
  end

  # Reman claims 6 pips is worth 75% more damage dealt in gives phase
  # Assume 80% of battles will have leaders
  #
  # For naval units assume 25% will have leaders because who can afford admirals anyway
  def leader_land_fire(v)
    fire_damage 0.80 * (0.75/6) * v
  end
  def leader_land_shock(v)
    shock_damage 0.80 * (0.75/6) * v
  end

  # Both phases worth the same
  def leader_naval_fire(v)
    naval_unit_power 0.25 * (0.75/6) * 0.50 * v
  end
  def leader_naval_shock(v)
    naval_unit_power 0.25 * (0.75/6) * 0.50 * v
  end

  # Assume 25% heretic 75% heathen
  def global_heretic_missionary_strength(v)
    global_missionary_strength 0.25 * v
  end

  # Extra pip speeds up siege by about 17%
  # Asssume 80% of sieges have leaders
  def leader_siege(v)
    siege_ability v*0.17*0.80
  end

  # I assume this adds to base of 15% (20% in home territory) not 100%
  # I doesn't translate to anything, but let's just guess that army which instantly recovered
  # morale every monthly tick would be 10% better. That's not as good as it sounds since it still
  # won't matter during combat, or if combat happens same month as previous one.
  def recover_army_morale_speed(v)
    land_unit_power v*0.1
  end
  def recover_navy_morale_speed(v)
    naval_unit_power v*0.1
  end

  # Guestimate that 2x reinforcement speed would make land units 10% more effective
  def reinforce_speed(v)
    land_unit_power v*0.1
  end

  # +1/year with 5% default decay makes it stabilize at 20 higher level
  # This results in regular bonuses, and better leaders
  #
  # PIPs according to http://www.eu4wiki.com/Military_tradition#Military_leaders
  def army_tradition(v)
    level = 0.2 * v

    land_morale 0.25*level
    manpower_recovery_speed 0.1*level
    recover_army_morale_speed 0.1*level
    siege_ability 0.05*level

    leader_siege 1.5*level
    leader_land_fire 2.25*level
    leader_land_shock 2.25*level
    leader_land_manuever 2.25*level
  end

  def navy_tradition(v)
    level = 0.2 * v

    naval_morale 0.25*level
    blockade_efficiency 1.0*level
    trade_steering 1.0*level
    recover_navy_morale_speed 0.1*level
    privateer_efficiency 0.25*level

    leader_naval_shock 2.25*level
    leader_naval_fire 2.25*level
    leader_naval_manuever 2.25*level
  end

  # These are somewhat relevant early game.
  # If you're over force limit, any force limit %X increase is basically %X maintenance reduction
  # (except light ships suffer square of that, as some cheap exploit prevention trick probably)
  #
  # Assuming you're going to be over your force limit 20% of the time
  # Actual number will be less, but it's weighted towards more desperate times
  #
  # Assume 10% of your land force limit comes from vassals, which is probably too much
  def land_forcelimit_modifier(v)
    calculated_land_cost -0.2*v
  end
  def vassal_forcelimit_bonus(v)
    land_forcelimit_modifier 0.1*v
  end
  def naval_forcelimit_modifier(v)
    calculated_ship_cost -0.2*v
  end

  # Scaled roughly with how good the CBs are
  def cb_on_primitives(v)
    extra_cbs 0.25
  end
  def cb_on_overseas(v)
    extra_cbs 0.25
  end
  # Holy War and Cleansing of Heresy are two great CBs
  # Defender of the Faith not counted as it only gives you CB on people you already have good CBs on (one of two above)
  def cb_on_religious_enemies(v)
    extra_cbs 2
  end
  def idea_claim_colonies(v)
    extra_cbs 0.25
  end

  # Assuming half of your trade power is spent on steering, and you capture half of the value of trade steered again
  # 25% of your trade power in your home node, 75% abroad
  # 50% of your total trade power from provinces (does that include buildings and province modifiers or just base???)
  #
  # These ratios are based on a lot of assumptions
  def trade_steering(v)
    global_trade_power 0.5*v
  end
  def global_prov_trade_power_modifier(v)
    global_trade_power 0.5*v
  end
  def global_own_trade_power(v)
    global_trade_power 0.25*v
  end
  def global_foreign_trade_power(v)
    global_trade_power 0.75*v
  end
  def global_trade_power(v)
    trade_efficiency 0.5*v
  end
  def global_trade_income_modifier(v)
    trade_efficiency v
  end
  # Assume 10% of your trade power will come from light ships
  def global_ship_trade_power(v)
    global_trade_power 0.1*v
  end
  # Goods produced modifier directly increases production income and (somebody's) trade income
  # Assume that you'll capture 80% of own trade income (and 20% of others' - but it's their modifiers that apply)
  def global_trade_goods_size_modifier(v)
    trade_efficiency v*0.8
    production_efficiency v
  end
  # This is extremely hard. Inland nodes are often extremely competitive (HRE), so this bonus matter little
  # Assume total 500 trade power in node, and that node would increase your trade income by 20% if fully controlled
  def merchant_steering_to_inland(v)
    trade_efficiency (v/500.0)*0.2
  end

  # Numbers based on AI games, 1.12.0, typical medium-big countries, ~1625 or so.
  #
  # From a few simulations, ballpark figures for income of a typical medium-big country:
  # 30% tax, 20% production, 40% trade, 5% gold, 2% tariff, 2% vassal, 1% loot
  # But these are *totals*, and we're modifying base numbers:
  # Typical modifiers mid-game are:
  # +25% tax, +50% production, +50% trade, +25% vassal, +25% tariff, +0% loot
  # Since these bonuses are additive not multiplicative we need to go back to base numbers
  # before adding bonus
  #
  # For costs:
  # 25% army, 5% state, 10% fort, 20% advisors, 5% navy, 35% balance (which I assume goes for 20% buildings, 5% embracement, 10% other stuff)
  # I'll assume of that army spending, 5% is mercs, 5% is reinforcement, 90% is regular maintenance
  #
  # This isn't really true, since incomes from simualion already come with many modifiers, mostly positive,
  # and these idea bonuses apply to base not total, so for most part this is going to overestimate
  # how much value you'll be getting.

  def production_efficiency(v)
    money (0.20/1.50)*v
  end
  def trade_efficiency(v)
    money (0.40/1.50)*v
  end
  def global_tax_modifier(v)
    money (0.30/1.25)*v
  end
  def global_tariffs(v)
    money (0.02/1.25)*v
  end
  def vassal_income(v)
    money (0.02/1.25)*v
  end
  def loot_amount(v)
    money 0.01*v
  end
  def fort_maintenance_modifier(v)
    money 0.10*-v
  end
  def advisor_cost(v)
    money 0.20*-v
  end
  # Assume 20% of forts on rival borders
  def rival_border_fort_maintenance(v)
    fort_maintenance_modifier 0.2*v
  end
  # Assume for applicable cultures it will affect half of advisors
  # (most advisors will be off-culture but you'll have enough chances to reroll etc. to make pick cheaper one)
  def same_culture_advisor_cost(v)
    advisor_cost(0.5*v)
  end
  def calculated_land_cost(v)
    money 0.25*-v
  end
  def calculated_ship_cost(v)
    money 0.05*-v
  end
  def build_cost(v)
    money 0.20*-v
  end
  def embracement_cost(v)
    money 0.05*-v
  end
  def state_maintenance_modifier(v)
    money 0.05*-v
  end
  # This bonus applies to base cost, not full merc cost, so discount is proportional to how much of your inf is mercs
  def mercenary_cost(v)
    infantry_cost 0.2*v
  end
  def merc_maintenance_modifier(v)
    # Since professionalism, mercs tend to be kept forever rather than disbanded when no longer needed
    mercenary_cost v
  end
  def no_cost_for_reinforcing(v)
    raise unless v == true
    calculated_land_cost -0.05
  end

  # Multiply by 50% chance that you're Catholic. This might be low for national ideas since only nations that start
  # Scale by 1/12 since it's annual number
  #
  # After that it's reasonable estimate that each papal influence point
  # is worth about as much as adm point as you can use 100 to buy +1 stability
  def papal_influence(v)
    monthly_adm_points(v * 0.5 / 12.0)
  end

  # Assumes:
  #   2 diplomats - 20% time in travel
  #   2 merchant  -  1% time in travel
  #   1 colonist  - 10% time in travel
  def envoy_travel_time(v)
    diplomats -2*0.20*v
    merchants -2*0.01*v
    colonists -1*0.10*v
  end

  # It has ridiculous abuse ceiling (moving to New World etc.)
  # but in normal start it's roughly comparable to one colonist
  def may_establish_frontier(v)
    colonists 1
  end

  # This is potentially useful, but it's so extremely conditional (only emperor) I'm not going to score it
  def imperial_authority(v)
  end

  # Growth triggers once a year
  # Settler chance triggers once a month for chance of 1% of +25 colonists
  # Assume 90% of colonies have settlers, and 75% of them are under cap where this is relevant
  def colonist_placement_chance(v)
    global_colonial_growth 25*0.01*12*0.90*0.75
  end

  # Assume on aveareg you'll be using 50% of this bonus
  # Utilization depends on bonus of course, +10% unity is good for everyone, +50% is probably a bit wasted
  def religious_unity(v)
    stability_cost_modifier v*0.5
    global_revolt_risk -2*v*0.5
  end

  # Not sure how that works since it's unique USA thing
  # I'm assuming it just removes intolerance. With average -4 intolerance and 20% wrong religion provinces
  # that's what it amounts to
  def no_religion_penalty(v)
    global_revolt_risk -4*0.2
  end

  # Assume it affects 5% of your provinces, and avearge -RR is -2
  def years_of_nationalism(v)
    global_revolt_risk (2*0.05*v)
  end

  # Assume that extra accepted culture is on average in 5% of provinces
  def num_accepted_cultures(v)
    affected = v * 0.05
    global_revolt_risk -2*affected
    global_tax_modifier 0.33*affected
    global_missionary_strength 0.02*affected
    global_manpower_modifier 0.33*affected
    global_sailors_modifier 0.20*affected
  end

  ### Higher level calculations ###
  # Assume strength of the military is 80% army 20% navy.
  def land_unit_power(v)
    military_power 0.8*v
  end
  def naval_unit_power(v)
    military_power 0.2*v
  end

  # These are ballpark estimates how good this is
  # Naval is much more important since it's also used for exploration
  def leader_land_manuever(v)
    land_unit_power 0.01*v
  end
  def leader_naval_manuever(v)
    naval_unit_power 0.02*v
  end

  # Counting 100% range extension worth as much as 0.25 colonist - it's extremely conditional
  def range(v)
    colonists 0.25*v
  end

  # Guess base numbers of 50 land, 50 naval
  def land_forcelimit(v)
    land_forcelimit_modifier(v/50.0)
  end

  def naval_forcelimit(v)
    naval_forcelimit_modifier(v/50.0)
  end

  # Let's set base to B = 5 + 10 (empire) + 16 (level 20 tech, about halfway)
  # Let's asy that you double that many non-state territories
  # So gaining V states, let's you increase your autonomy-weighted land from:
  # from: B * 1 + 2B * 0.25 to
  # to: B * 1 + V * 0.75 + 2B * 0.25
  # or [0.75 v] / [1.5 b] = v/2b

  def max_states(v)
    b = 5+10+16
    avg_autonomy_reduction = v / (2.0 * b)
    global_manpower_modifier avg_autonomy_reduction
    global_sailors_modifier avg_autonomy_reduction
    global_tax_modifier avg_autonomy_reduction
    production_efficiency avg_autonomy_reduction
    global_trade_power 0.5*avg_autonomy_reduction
    land_forcelimit_modifier avg_autonomy_reduction
    naval_forcelimit_modifier avg_autonomy_reduction
  end

  # This is multiplicative
  # Average AE is:
  #   first two eras: 0%
  #   then: 10% (tech) + up to 40% (absolutism)
  #   then: 30% (tech) + up to 40% (absolutism)
  # So if you have max absolutism all the time, base is 30%
  # Let's assume 25%. Then extra 5% is actually 6.66% discount.
  #
  # Conflicting claims if it affects AE or not
  def administrative_efficiency(v)
    diplomatic_annexation_cost(-v/0.75)
    core_creation_cost(-v/0.75) # just cost not time
    province_warscore_cost(-v/0.75)
    ae_impact(-v/0.75)
  end

  # Asssume cap is reachable 25% of the time
  def max_absolutism(v)
    absolutism 0.75 * v
  end

  def absolutism(v)
    administrative_efficiency (v/100.0)*0.4
    discipline (v/100.0)*0.05
    core_decay_on_your_own (v/100.0)*-0.5
  end

  # Arbitrarily assume reinforce costs are 20% of army costs
  def reinforce_cost_modifier(v)
    calculated_land_cost 0.2*v
  end

  # It's 2d4-2 so there's a 1/16 of natural 6
  # If this is stacked, next one is valued less, but such stacks are unlikely
  def monarch_admin_power(v)
    monthly_adm_points(v*15.0/16.0)
  end

  # This assumes you never take any policies beyond cap
  # (since there are so few really good ones)
  # so it's estimated value of extra policy
  def free_adm_policy(v)
    monthly_mixed_monarch_points 0.5*v
  end
  def free_dip_policy(v)
    monthly_mixed_monarch_points 0.5*v
  end
  def free_mil_policy(v)
    monthly_mixed_monarch_points 0.5*v
  end

  # Assume 60% the enemies are wrong religion
  # It increases as game goes
  def warscore_cost_vs_other_religion(v)
    province_warscore_cost(v*0.6)
  end

  def score
    total = 0
    @ht.each do |k,v|
      case k
      # Base unit of value
      when :monthly_mixed_monarch_points
        # This is meant for unpredictable mix, for 1/1/1 like all tech just use explicit values
        total += v
      # Diploannexations got nerfed to hell, now paper mana is king
      when :monthly_dip_points
        total += v*1.0
      when :monthly_adm_points
        total += v*1.3
      when :monthly_mil_points
        total += v*0.7
      when :colonists
        # Definitely the most important agent type by huge margin
        total += 3*v
      when :diplomats
        # Everybody starts with 3 at kingdom tier, and 4th etc.
        # are not really a big deal
        total += 0.75*v
      when :merchants
        # This also provides +5 naval force limit per merchant beyond 2nd, not counted separately
        # I'd say they became less relevant as you can get them from CNs and trade companies,
        # however this is only true if you have colonists (so basically included in colonist score), or very late game
        total += 1*v
      when :missionaries
        # Extra missionaries are really good.
        # Missionary strength is much easier to achieve than it used to be,
        # so count +2% missionary strength as about equivalent to +1 misionary
        total += 1*v
      when :global_missionary_strength
        total += 50.0*v
      when :global_revolt_risk
        total -= 0.75*v
      when :global_autonomy
        total += -5.0*v
      when :province_warscore_cost
        # 20% discount would be worth 2 mp
        total -= 10.0*v
      when :money
        # Doubling the money
        total += v*12
      when :siege_ability
        # Doubling siege speed
        total += v*5
      when :defensiveness
        # Slowing down enemy sieges x2
        total += v*1
      when :military_power
        # Doubling military combat power both land and sea
        total += v*12
      when :movement_speed
        # Assume army that moves 100% faster is worth 4mp/month
        # Sadly due to shatered retreat rules, ZoCs etc. it's not as useful as it appears
        total += v*4
      when :global_manpower_modifier
        # Doubling total manpower
        total += v*4
      when :global_colonial_growth
        total += v/50.0
      when :extra_minor_abilities
        total += v*0.25
      when :extra_cbs
        # Tech group based CBs got nerfed
        # and good CBs are less important now that you'll get universal CBs late game
        # so reducing it slightly
        total += v*1.0
      when :legitimacy
        total += v*0.5
      when :republican_tradition
        total += v # value at 2x legitimacy, old patches used 0-1, now 0-100
      when :may_explore
        total += v*2
      when :advisor_pool
        # This is far less valuable now that you can just buy it for small amount of money
        # and estates provide free overpowered advisors
        total += 0.05*v
      when :hostile_attrition
        # Because of 5% attrition cap this is very poor effect, even this is probably overvaluing it
        total += 0.1*v
      when :relations_decay_of_me
        total += 2*v
      when :ae_impact
        # Especially when stacking, this can be amazing
        total -= 5*v
      when :diplomatic_reputation
        # This is back to being good
        total += v
      when :reduced_liberty_desire
        # 3 points are as good as 1 point of diplomatic reputation when it comes to subjects
        # It does nothing for all other uses of diplomatic reputation
        # For total assume 25% of relations you care about are subject relations
        total += v / 12.0
      when :yearly_absolutism
        # This is going to get capped really quickly
      when :migration_cooldown, :horde_unity, :cav_to_inf_ratio, :amount_of_banners, :monthly_fervor_increase, :yearly_harmony
        # Extremely situational
      when :native_assimilation, :native_uprising_chance
        # Not very meaningful since native policies are a thing
      when :yearly_tribal_allegiance
        # Too situational
      when :global_institution_spread, :institution_spread_from_true_faith
        # This makes very little difference,
        # the difficulty is just getting institutions to reach you,
        # spread % modifiers after that is basically insignificant
        #
        # Unless of course you're just spamming development to
        # get them without spread, then it matters even less
      when :possible_policy, :possible_adm_policy, :possible_dip_policy, :possible_mil_policy
        # going over cap would be really unusual
      when :maintain_dynasty
        # mostly bad as it prevents PUs, but it's so conditional either way it's best to score as zero
      else
        warn "#{k} not scored"
      end
    end
    total.round(4)
  end
end
