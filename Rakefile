require "pathname"
require "fileutils"

VERSION = "0.14"

def trash(path)
  if Pathname(path).exist?
    system "trash", path.to_s
  end
end

task "package:all" => ["package:vanilla", "package:extended_timeline", "package:shattered_europe"]

task "package:vanilla" do
  trash "output"
  trash "build"
  Pathname("build/fun_and_balance").mkpath

  system "./fun_and_balance/build_fun_and_balance"

  system "cp fun_and_balance/fun_and_balance.mod build/"
  system "cp -a output/fun_and_balance-1.7.3/* build/fun_and_balance/"
  Dir.chdir("build") do
    system "7za a ../fun_and_balance_#{VERSION}_for_eu4_1.7.3.7z"
  end
end

task "package:extended_timeline" do
  trash "output"
  trash "build"
  Pathname("build/fun_and_balance_et").mkpath

  system "./fun_and_balance/build_fun_and_balance_et"

  system "cp fun_and_balance/fun_and_balance_et.mod build/"
  system "cp -a output/fun_and_balance_et/* build/fun_and_balance_et/"
  Dir.chdir("build") do
    system "7za a ../fun_and_balance_#{VERSION}_for_eu4_1.7.3_and_extended_timeline_0.10.7z"
  end
end

task "package:shattered_europe" do
  trash "output"
  trash "build"
  Pathname("build/fun_and_balance_shattered_europe").mkpath

  system "./fun_and_balance/build_fun_and_balance_shattered_europe"

  system "cp fun_and_balance/fun_and_balance_shattered_europe.mod build/"
  system "cp -a output/fun_and_balance_shattered_europe/* build/fun_and_balance_shattered_europe/"
  Dir.chdir("build") do
    system "7za a ../fun_and_balance_#{VERSION}_for_eu4_1.7.3_and_shattered_europe.7z"
  end
end

