module Classes

import Mrk.Attributes

%default total
%access public export

data ABClass
  = Container
  | Gibberish
  | MenuItem
  | Menu
  | NoHist
  | NoPrint

AttributeValue ABClass where
  toAttr Container = "container"
  toAttr Gibberish = "gibberish"
  toAttr MenuItem = "menu-item"
  toAttr Menu = "menu"
  toAttr NoHist = "nohist"
  toAttr NoPrint = "noprint"

Show ABClass where
  show Container = "container"
  show Gibberish = "gibberish"
  show MenuItem = "menu-item"
  show Menu = "menu"
  show NoHist = "nohist"
  show NoPrint = "noprint"

Eq ABClass where
  x == y =
    toAttr x == toAttr y

-- Local Variables:
-- idris-load-packages: ("mrk")
-- End:
