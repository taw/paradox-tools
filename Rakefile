require "pathname"
require "fileutils"
require "date"

class Date
  # Default inspect is just really stupid
  def inspect
    "Date.new(#{year}, #{month}, #{day})"
  end

  def to_s
    "%04d.%d.%d" % [year, month, day]
  end
end

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

  def build_dir
    Pathname("output/#{name}")
  end

  def mod_descriptor
    Pathname("output/#{name}.mod")
  end

  def build!
    # Half of this should probably be done by ModBuilder
    trash build_dir, mod_descriptor
    system "./#{category}/build_#{name}" or raise "Build failed"
    Dir.chdir("output") do
      system "7za a '../#{archive_name}' '#{name}'/ '#{name}'.mod >/dev/null"
    end
  end
end

####

FUN_AND_BALANCE_VERSION = "0.29"

desc "Build all packages"
task "all" => ["ck2", "eu4"]

desc "Build all CK2 packages"
task "ck2" => ["no_dynastic_names", "no_localized_ranks", "no_localized_landed_titles", "suez_canal", "modern_times", "modern_times_plus"]

desc "Build all EU4 packages"
task "eu4" => ["vanilla", "extended_timeline"]

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
task "modern_times_plus" do
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
    "fun_and_balance_#{FUN_AND_BALANCE_VERSION}_for_eu4_1.16.3.7z",
  ).build!
end

desc "Build Fun and Balance for Extended Timeline"
task "extended_timeline" do
  ModBuilder.new(
    "fun_and_balance",
    "fun_and_balance_et",
    "fun_and_balance_#{FUN_AND_BALANCE_VERSION}_for_eu4_1.16.3_and_extended_timeline_1.0.2.7z"
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
  FileUtils.mv "output", "reference"
end

desc "Run tests"
task "test" do
  system %q[ruby -e 'Dir["test/*.rb"].each{|x| require "./#{x}"}']
end

def fix_date(str)
  case str
  when /\A\d+\.\d+\.\d+\z/, /\A\d+ \S+ \d+\z/, /\A\S+ \d+, \d+\z/
    Date.parse(str).to_s
  else
    str
  end
end

desc "Fix code in modern times database"
task "code:cleanup" do
  Dir["ck2_mods/**/*.rb"].each do |path|
    path = Pathname(path)
    orig_content = path.read
    content = orig_content.gsub(/"([^"\n]+)"/) do
      m = $1
      begin
        if m =~ /(?:-|\u2013)/
          m = m.split(/(\s*(?:-|\u2013)\s*)/, -1).each_slice(2).map{|d,s| [fix_date(d), s]}.join
        else
          m = fix_date(m)
        end
      rescue
        # keep
      end
      %Q["#{m}"]
    end
    if content != orig_content
      puts "#{path} changed"
      File.write(path, content)
    end
  end
end
