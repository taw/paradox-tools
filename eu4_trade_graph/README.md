To create new trade map, first export existing one to simple text format:

    $ ruby ./export_trade_graph /path/to/eu4 > trade_graph.txt
  
Then edit the file. For now the only supported operations are keeping links as they are, reversing them, or deleting them. Import script can't yet add new links (it's planned as a future feature).

Validate to check that there are no problems. Game will crash if there are any loops
  
    $ ruby ./validate_trade_graph trade_graph.txt

If the sript gives you OK, you can import it back:

    $ ruby ./import_trade_graph trade_graph.txt /path/to/eu4 > 00_tradenodes.txt

Put that file into your mod as common/tradenodes/00_tradenodes.txt and enjoy!
