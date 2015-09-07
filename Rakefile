require "pathname"
require "fileutils"

def trash(*paths)
  paths.each do |path|
    next unless Pathname(path).exist?
    system "trash", path.to_s
    ds_store = Pathname(path).parent + ".DS_Store"
    ds_store.unlink if ds_store.exist?
  end
end

class ModBuilder
  attr_reader :category, :name, :archive_name
  def initialize(category, name, archive_name)
    @category = category
    @name = name
    @archive_name = archive_name
  end

  def mod_descriptor
    Pathname("output/#{name}.mod")
  end

  def mod_picture
    Pathname("pictures/#{name}.png")
  end

  def build_dir
    Pathname("build/#{name}")
  end

  def build!
    # Half of this should probably be done by ModBuilder
    trash "output/#{name}", "build"
    Pathname("build/#{name}").mkpath
    system "./#{category}/build_#{name}" or raise "Build failed"
    system "cp #{mod_descriptor} build/"
    system "cp -a output/#{name}/* #{build_dir}/"
    system "cp #{mod_picture} #{build_dir}/" if mod_picture.exist?
    Dir.chdir("build") do
      system "7za a '../#{archive_name}'"
    end
  end
end

####

FUN_AND_BALANCE_VERSION = "0.24alpha"

desc "Build all packages"
task "all" => ["ck2", "eu4"]

desc "Build all CK2 packages"
task "ck2" => ["no_dynastic_names", "no_localized_ranks", "no_localized_landed_titles", "suez_canal", "modern_times", "modern_times_plus"]

desc "Build all EU4 packages"
task "eu4" => ["vanilla", "extended_timeline", "shattered_europe"]

desc "Build CK2 No Dynastic Names"
task "no_dynastic_names" do
  ModBuilder.new(
    "ck2_mods",
    "no_dynastic_names",
    "ck2_no_dynastic_names.7z",
  ).build!
end

desc "Build CK2 No Localized Landed Titles"
task "no_localized_landed_titles" do
  ModBuilder.new(
    "ck2_mods",
    "no_localized_landed_titles",
    "ck2_no_localized_landed_titles.7z",
  ).build!
end

desc "Build CK2 No Localized Ranks"
task "no_localized_ranks" do
  ModBuilder.new(
    "ck2_mods",
    "no_localized_ranks",
    "ck2_no_localized_ranks.7z",
  ).build!
end

desc "Build CK2 Suez Canal"
task "suez_canal" do
  ModBuilder.new(
    "ck2_mods",
    "suez_canal",
    "ck2_suez_canal.7z",
  ).build!
end

desc "Build CK2 Modern Times"
task "modern_times" do
  ModBuilder.new(
    "ck2_mods",
    "modern_times",
    "ck2_modern_times.7z",
  ).build!
end

desc "Build CK2 Modern Times Plus"
task "modern_times" do
  ModBuilder.new(
    "ck2_mods",
    "modern_times_plus",
    "ck2_modern_times_plus.7z",
  ).build!
end

desc "Build Fun and Balance for vanilla"
task "vanilla" do
  ModBuilder.new(
    "fun_and_balance",
    "fun_and_balance",
    "fun_and_balance_#{FUN_AND_BALANCE_VERSION}_for_eu4_1.13.0.7z",
  ).build!
end

desc "Build Fun and Balance for Extended Timeline"
task "extended_timeline" do
  ModBuilder.new(
    "fun_and_balance",
    "fun_and_balance_et",
    "fun_and_balance_#{FUN_AND_BALANCE_VERSION}_for_eu4_1.13.0_and_extended_timeline_0.13.5.7z"
  ).build!
end

desc "Build Fun and Balance for Shattered Europe"
task "shattered_europe" do
  ModBuilder.new(
    "fun_and_balance",
    "fun_and_balance_shattered_europe",
    "fun_and_balance_#{FUN_AND_BALANCE_VERSION}_for_eu4_1.11.4_and_shattered_europe.7z",
  ).build!
end

desc "Remove build files"
task "clean" do
  trash "output", "build"
end

desc "Generate reference for refactoring"
task "reference" do
  trash "output", "build", "reference"
  system "ck2_mods/build_ck2tweaks"
  system "ck2_mods/build_custom_scenario"
  system "ck2_mods/build_no_dynastic_names"
  system "ck2_mods/build_no_localized_landed_titles"
  system "ck2_mods/build_no_localized_ranks"
  system "ck2_mods/build_modern_times"
  system "ck2_mods/build_modern_times_plus"
  system "fun_and_balance/build_fun_and_balance"
  system "fun_and_balance/build_fun_and_balance_et"
  # system "fun_and_balance/build_fun_and_balance_shattered_europe" # not updated to recent version
  FileUtils.mv "output", "reference"
end
