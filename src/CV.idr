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
      """Full-time TDD and pairing (remote / local). Variety of team sizes and types. Interviewing new recruits at all stages.

Current team: Cloud Operations. Deploying, operating and monitoring Pivotal Cloud Foundry on Google Cloud Platform.
Cloud Foundry: Pivotal Web Services, CLI, docs tooling team, CF services.
RabbitMQ core team: Objective-C/Swift client, RabbitMQ server.
Labs: consulting large enterprise clients and startups. Leading small and large teams.

Languages in production: Ruby, JavaScript, Go, Objective-C, Swift, Erlang, Elixir.
Languages for prototypes: Clojure, Haskell.

Ran a weekly discussion group for SF Bay Area programmers interested in XP for about a year."""

    , MkPosition
      "Software Engineer (freelance)"
      "Superhug"
      "Brighton"
      (From (February 2010) (To $ December 2011))
      """A Rails-based e-commerce site (offline).

Full-stack devops: everything from CSS to implementing an S3-backed FTP site with Chef. Blue-green deploys using AWS ELB."""

    , MkPosition
      "Software Engineer (contract)"
      "Friday"
      "London"
      (From (March 2011) (To $ June 2011))
      """Prototype version of Patchwork for Friday's client FutureGov. Software to enable care workers to raise alarms about their clients.

Full-stack Rails development including JavaScript. Assistance deploying to council web servers."""

    , MkPosition
      "Software Engineer (contract)"
      "BBC"
      "London"
      (From (October 2008) (To $ February 2010))
      """Ruby, Rails, PHP, Zend Framework, Perl. Pair programming, TDD. Primary software developer of initial version of BBC Introducing Rails management tool."""

    , MkPosition
      "Software Engineer (contract)"
      "Learning and Skills Council"
      "Coventry"
      (From (May 2008) (To $ September 2008))
      """Rails prototype version of a government website called "Skills Accounts". It was later re-implemented in C# by another team.

The Learning and Skills Council was a UK government quango. It was closed in March 2010, and this website is long gone."""

    , MkPosition
      "Software Developer"
      "YOUhome"
      "London"
      (From (July 2007) (To $ May 2008))
      "Rails, Ruby, JavaScript, HTML, CSS."

    , MkPosition
      "Projects Team Leader"
      "ServerChoice"
      "London"
      (From (April 2006) (To $ June 2007))
      """Generic ordering system for multiple Rails sites. Use of Rails engines (the first version), JavaScript, Prototype.js, jQuery, Leading a Scrum / XP team.

Promoted to Projects Team Leader December 2006."""

    , MkPosition
      "Web and Software Developer"
      "The ITC"
      "Abergele"
      (From (October 2005) (To $ April 2006))
      "Knocking together PHP apps, wild-west style."
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
