#import "../../colors.typ": *

#let types = (
  info: (file: "info.svg", color: light-grey), warning: (file: "warning.svg", color: orange), error: (file: "error.svg", color: red), problem: (file: "bug_report.svg", color: light-green), question: (file: "question.svg", color: light-grey), example: (file: "experiment.svg", color: purple), theorem: (file: "theorem.svg", color: lighter-blue),
)

#let callout(body, title: none, type: "theorem", breakable: false) = {
  assert(type in types)
  let type-name = upper(type.at(0)) + type.slice(1)
  let (file, color) = types.at(type)

  v(5pt)
  block(
    clip: true, breakable: breakable, radius: 5pt, stroke: 2pt + color,
  )[
    #block(
      fill: color, breakable: breakable, width: 100%, spacing: 0pt, inset: (x: 1em, y: 0.35em), grid(
        columns: 2, gutter: 6pt, align: start + horizon, image("icons/" + file, width: 1.25em), text(if title != none { title } else { type-name }, weight: "bold"),
      ),
    )
    #block(width: 100%, breakable: true, inset: (x: 1em, y: 0.65em))[
      #body
    ]
  ]
}
