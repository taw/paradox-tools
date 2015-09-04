module ModernTimes
  HOLDERS = {
    # Dynasty changed names twice, but whatever
    e_britannia: {
      "1837.6.20" => {
        birth: "1819.5.24",
        death: "1901.1.22",
        name: "Victoria",
        female: true,
        dynasty: "Windsor",
      },
      "1901.1.22" => {
        birth: "1841.11.9",
        death: "1910.5.6",
        name: "Edward",
        dynasty: "Windsor",
      },
      "1910.5.6" => {
        birth: "1865.6.3",
        death: "1936.1.20",
        name: "George",
        dynasty: "Windsor",
      },
      "1936.1.20" => {
        birth: "1894.6.23",
        death: "1972.5.28",
        name: "Edward",
        dynasty: "Windsor",
      },
      "1936.12.11" => {
        birth: "1895.12.14",
        death: "1952.2.6",
        name: "George",
        dynasty: "Windsor",
      },
      "1952.2.6" => {
        birth: "1926.4.21",
        death: :never,
        name: "Elizabeth",
        dynasty: "Windsor",
        female: true,
      },
    },
    e_germany: {
      "1888.6.15" => {
        birth: "1859.1.27",
        death: "1941.6.4",
        name: "Wilhelm",
        dynasty: "Hohenzollern",
      },
      # Backdate, ignore interregnum
      "1918.11.28" => {
        name: "Friedrich",
        dynasty: "Ebert",
      },
      # Ignore temporary ones
      "1925.5.12" => {
        name: "Paul",
        dynasty: "von Hindenburg",
      },
      "1934.8.2" => {
        name: "Adolf",
        dynasty: "Hitler",
      },
      "1945.4.30" => {
        name: "Karl",
        dynasty: "Donitz",
      },
      # Now this is bullshit on so many levels...
      # German "presidents" do nothing, so choosing chancellor as much more prominent person
      # Backdating a lot
      "1945.5.23" => {
        name: "Konrad",
        dynasty: "Adenauer",
      },
      "1963" => {
        name: "Ludwig",
        dynasty: "Erhard",
      },
      "1966" => {
        name: "Kurt Georg",
        dynasty: "Kiesinger",
      },
      "1969" => {
        name: "Willy",
        dynasty: "Brandt",
      },
      "1974" => {
        name: "Helmut",
        dynasty: "Schmidt",
        birth: "1918.12.23",
      },
      "1982" => {
        name: "Helmut",
        dynasty: "Kohl",
        birth: "1930.4.3",
      },
      "1998" => {
        name: "Gerhard",
        dynasty: "Schroeder",
        birth: "1944.4.7",
      },
      "2005" => {
        name: "Angela",
        dynasty: "Merkel",
        female: true,
      }
    },
    e_russia: {
      "1894.11.1" => {
        name: "Nicholas",
        dynasty: "Romanov",
        birth: "1868.5.6",
        death: "1918.7.17",
      },
      # Not really ruling ever, but alternative is interregnum
      "1917.3.15" => {
        name: "Michael",
        dynasty: "Romanov",
        birth: "1878.10.22",
        death: "1918.6.12",
      },
      # Backdating
      "1918.6.12" => {
        name: "Vladimir",
        dynasty: "Lenin",
        death: "1924.1.21",
      },
      "1924.1.21" => {
        name: "Joseph",
        dynasty: "Stalin",
        death: "1953.3.5",
      },
      "1953.3.5" => {
        name: "Georgy",
        dynasty: "Malenkov",
      },
      "1955.2.8" => {
        name: "Nikita",
        dynasty: "Khrushchev",
      },
      "1964.10.14" => {
        name: "Leonid",
        dynasty: "Brezhnev",
      },
      "1982.10.12" => {
        name: "Yuri",
        dynasty: "Andropov",
      },
      "1984.2.13" => {
        name: "Konstantin",
        dynasty: "Chernenko"
      },
      # Skipping Gennady Yanayev 3-day plot silliness
      "1985.3.11" => {
        name: "Mikhail",
        dynasty: "Gorbachev",
      },
      "1991.12.25" => {
        name: "Boris",
        dynasty: "Yeltsin",
        birth: "1931.2.1",
        death: "2007.4.23",
      },
      # Putin -> Medvedev -> Putin, but script doesn't support it yet
      "1999.12.31" => {
        name: "Vladimir",
        dynasty: "Putin",
      },
    },
  }
end
