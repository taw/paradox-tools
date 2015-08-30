require_relative "config_menu"

class ConfigMenuETGameModification < ConfigMenuGameModification
  def apply!
    build_mod_config_menu!(
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
