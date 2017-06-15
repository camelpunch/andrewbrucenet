module Classes

import Site

public export
data ABClass
  = Container
  | Gibberish
  | MenuItem
  | Menu
  | NoHist

public export
Show ABClass where
  show Container = "container"
  show Gibberish = "gibberish"
  show MenuItem = "menu-item"
  show Menu = "menu"
  show NoHist = "nohist"

