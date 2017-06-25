module CV

import Site
import CVGenerator

export
cv : Page
cv =
  MkPage "/cv/" "cv" "CV" "CV"
  [ CVGenerator.cv $ MkDocument
    [ MkPosition
      "Senior Software Engineer"
      "Pivotal"
      "London / San Francisco"
      (From (January 2012) Present)
      """Full-time TDD and pairing (remote / local). Variety of team sizes and types.

Labs: consulting large enterprise clients and startups. Leading small and large teams.
Cloud Foundry: Pivotal Web Services, CLI, docs tooling team, CF services.
RabbitMQ core team: Objective-C/Swift client, RabbitMQ server.
Current team: Cloud Operations. Running Cloud Foundry on Google Cloud Platform.

Languages in production: Ruby, JavaScript, Go, Objective-C, Swift, Erlang, Elixir.
Languages for prototypes: Clojure, Haskell.

Ran a weekly discussion group for SF Bay Area programmers interested in XP for about a year."""

    , MkPosition
      "Software Engineer (freelance)"
      "Superhug"
      "Brighton"
      (From (February 2010) (To $ December 2011))
      ""

    , MkPosition
      "Software Engineer (contract)"
      "Friday"
      "London"
      (From (March 2011) (To $ June 2011))
      ""

    , MkPosition
      "Software Engineer (contract)"
      "BBC"
      "London"
      (From (October 2008) (To $ February 2010))
      ""

    , MkPosition
      "Software Engineer (contract)"
      "Learning and Skills Council"
      "Coventry"
      (From (May 2008) (To $ September 2008))
      ""

    , MkPosition
      "Software Developer"
      "YOUhome"
      "London"
      (From (July 2007) (To $ May 2008))
      ""

    , MkPosition
      "Projects Team Leader"
      "ServerChoice"
      "London"
      (From (April 2006) (To $ June 2007))
      ""

    , MkPosition
      "Web and Software Developer"
      "The ITC"
      "Abergele"
      (From (October 2005) (To $ April 2006))
      ""
    ]
    [ MkCourse
      "University of Cambridge"
      "BA"
      "Philosophy"
      "2:2"
      (From (October 2002) (To $ July 2005))
      ""

    , MkCourse
      "Ysgol Emrys ap Iwan"
      "A Level"
      "Computing"
      "A"
      (From (September 1995) (To $ July 2001))
      ""
    ]
  ]
