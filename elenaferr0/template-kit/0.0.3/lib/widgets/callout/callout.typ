#import "../../colors.typ": *

#let types = (
  info: (
    file: "info.svg",
	text-color: black,
    color: light-grey,
  ),
  warning: (
    file: "warning.svg",
	text-color: black,
    color: orange,
  ),
  error: (
    file: "error.svg",
	text-color: black,
    color: red,
  ),
  problem: (
    file: "bug_report.svg",
	text-color: black,
    color: light-green,
  ),
  question: (
    file: "question.svg",
	text-color: black,
    color: light-yellow,
  ),
  example: (
    file: "experiment.svg",
	text-color: black,
    color: purple,
  ),
  theorem: (
    file: "theorem.svg",
	text-color: black,
    color: lighter-blue,
  ),
  idea: (
    file: "idea.svg",
	text-color: white,
    color: blue,
  ),
)

#let _callout(body, title: none, type: "theorem", breakable: false) = {
  assert(type in types)
  let type-name = upper(type.at(0)) + type.slice(1)
  let (file, color, text-color) = types.at(type)
  let radius = 5pt

  v(5pt)
  block(
    breakable: breakable,
    radius: radius,
    stroke: 1pt + color,
  )[
    #block(
      fill: color,
      breakable: breakable,
      width: 100%,
      spacing: 0pt,
      radius: (top: radius, bottom: 0pt),
      inset: (x: 1em, y: 0.35em),
      grid(
        columns: 2,
        gutter: 6pt,
        align: start + horizon,
        image("icons/" + file, width: 1.25em),
        text(if title != none { title } else { type-name }, weight: "bold", text-color),
      ),
    )
    #block(
      width: 100%,
      breakable: true,
      inset: (x: 1em, y: 0.65em),
    )[
      #body
    ]
  ]
}

// Shortcuts for callouts of given types
#let info(body, title: none, breakable: false) = _callout(body, title: title, type: "info", breakable: breakable)
#let warn(body, title: none, breakable: false) = _callout(body, title: title, type: "warning", breakable: breakable)
#let err(body, title: none, breakable: false) = _callout(body, title: title, type: "error", breakable: breakable)
#let prob(body, title: none, breakable: false) = _callout(body, title: title, type: "problem", breakable: breakable)
#let question(body, title: none, breakable: false) = _callout(body, title: title, type: "question", breakable: breakable)
#let eg(body, title: none, breakable: false) = _callout(body, title: title, type: "example", breakable: breakable)
#let theo(body, title: none, breakable: false) = _callout(body, title: title, type: "theorem", breakable: breakable)
#let idea(body, title: none, breakable: false) = _callout(body, title: title, type: "idea", breakable: breakable)
