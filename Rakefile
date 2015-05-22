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
    Pathname("#{category}/#{name}.mod")
  end

  def mod_picture
    Pathname("#{category}/#{name}.png")
  end

  def build_dir
    Pathname("build/#{name}")
  end

  def build!
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

FUN_AND_BALANCE_VERSION = "0.21a"

desc "Build all packages"
task "package:all" => ["package:ck2", "package:eu4"]

desc "Build all CK2 packages"
task "package:ck2" => ["package:no_dynastic_names"]

desc "Build all EU4 packages"
task "package:eu4" => ["package:vanilla", "package:extended_timeline", "package:shattered_europe"]

desc "Build CK2 No Dynastic Names package"
task "package:no_dynastic_names" do
  ModBuilder.new(
    "ck2_mods",
    "no_dynastic_names",
    "ck2_no_dynastic_names.7z",
  ).build!
end

desc "Build Fun and Balance for vanilla package"
task "package:vanilla" do
  ModBuilder.new(
    "fun_and_balance",
    "fun_and_balance",
    "fun_and_balance_#{FUN_AND_BALANCE_VERSION}_for_eu4_1.11.4.7z",
  ).build!
end

desc "Build Fun and Balance for Extended Timeline package"
task "package:extended_timeline" do
  ModBuilder.new(
    "fun_and_balance",
    "fun_and_balance_et",
    "fun_and_balance_#{FUN_AND_BALANCE_VERSION}_for_eu4_1.11.4_and_extended_timeline_0.12.3.7z"
  ).build!
end

desc "Build Fun and Balance for Shattered Europe package"
task "package:shattered_europe" do
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
