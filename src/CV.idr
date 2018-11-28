module CV

import Data.Vect
import Mrk

import CVGenerator
import Classes
import Layout

export
cv : Document Root
cv = page "Andrew Bruce: CV" "Andrew Bruce" $ do
  p "me@andrewbruce.net / +447864303876"
  p [ClassNames [NoPrint]] $ do
    a (Just "/cv.pdf") "PDF version"
  CVGenerator.cv $ MkDocument
    [ MkPosition
      "DevOps Consultant (contract)"
      "Boclips"
      "London"
      (From (July 2018) Present)
      """Modernising how Boclips deploys and runs software in the cloud, migrating from AWS EC2 deployments to Kubernetes on GKE.

Introducing unified monitoring and logging systems and practices. Improving security of infrastructure, including credential management. Knowledge sharing through pair programming."""

    , MkPosition
      "WebOps Engineer (contract)"
      "Government Digital Services"
      "London"
      (From (October 2017) (To $ March 2018))
      """Developing and operating the UK Government Platform as a Service, based on Cloud Foundry.

Apps, service brokers, scripts and monitoring in Go, Ruby and BASH. TDD, pairing.
     """

     , MkPosition
      "Senior Software Engineer"
      "Pivotal"
      "London / San Francisco"
      (From (January 2012) (To $ October 2017))
      """TDD, pairing and mentoring. Remote and local. Interviewing candidates at all stages.

Product teams: On Demand Services for Cloud Foundry, Cloud Operations, RabbitMQ core team, Pivotal Web Services, Cloud Foundry CLI, docs tooling, CF services.

2012-2014: Consulting and leading teams for household-name clients and smaller startups.

Ruby, JavaScript, Go, Objective-C, Swift, Erlang, Clojure, Haskell.

Ran a weekly discussion group for SF Bay Area engineers for one year."""

    , MkPosition
      "Software Engineer (freelance)"
      "Superhug"
      "Brighton"
      (From (February 2010) (To $ December 2011))
      """A Rails-based e-commerce site (offline). Full-stack devops using Chef and AWS."""

    , MkPosition
      "Software Engineer (contract)"
      "Friday"
      "London"
      (From (March 2011) (To $ June 2011))
      """Prototype version of Patchwork for Friday's client FutureGov. Software to enable care workers to raise alarms about their clients.

Full-stack Rails development. Assistance deploying to council web servers."""

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
      """Rails prototype for a government website called "Skills Accounts".

The Learning and Skills Council was a UK government quango. It was closed in March 2010."""

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
      """TDD and pairing. Generic ordering system for multiple Rails sites. Use of Rails engines (the first version), JavaScript, Prototype.js, jQuery, Leading a Scrum / XP team.

Promoted to Projects Team Leader December 2006."""

    , MkPosition
      "Web and Software Developer"
      "The ITC"
      "Abergele"
      (From (October 2005) (To $ April 2006))
      "LAMP application development."
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

-- Local Variables:
-- idris-load-packages: ("mrk")
-- End:
