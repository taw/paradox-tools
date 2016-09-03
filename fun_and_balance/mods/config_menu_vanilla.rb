require_relative "config_menu"

class ConfigMenuVanillaGameModification < ConfigMenuGameModification
  def apply!
    build_mod_config_menu!(
      menu_set_flag_option("enable_achievements", "Enable Achievements"),
      menu_clr_flag_option("enable_achievements", "Disable Achievements"),
      menu_set_flag_option("disable_holy_sites", "Disable Holy Sites"),
      menu_clr_flag_option("disable_holy_sites", "Enable Holy Sites"),
      menu_set_flag_option("disable_extra_missions", "Disable extra missions"),
      menu_clr_flag_option("disable_extra_missions", "Enable extra missions"),
      menu_set_flag_option("disable_extra_formable_countries", "Disable extra formable countries"),
      menu_clr_flag_option("disable_extra_formable_countries", "Enable extra formable countries"),
      menu_set_flag_option("disable_eu3_style_elections", "Disable EU3 style elections"),
      menu_clr_flag_option("disable_eu3_style_elections", "Enable EU3 style elections"),
      menu_set_flag_option("enable_burgundian_succession_crisis", "Enable Burgundian Successian Crisis"),
      menu_clr_flag_option("enable_burgundian_succession_crisis", "Disable Burgundian Successian Crisis"),
      PropertyList[
        "name", "fun_and_balance_menu.done",
      ],
    )
    localization! "fun_and_balance_menu",
      "fun_and_balance_menu.done" => "Done"
  end
end
