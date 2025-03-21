#let _callout(body, title: none, type: "theorem", breakable: false) = {
  assert(type in types)
  let type-name = upper(type.at(0)) + type.slice(1)
  let (file, color) = types.at(type)
  let radius = 5pt

  v(5pt)
  block(
    breakable: breakable,
    radius: radius,
    stroke: 2pt + color,
  )[
    #block(
      fill: color,
      breakable: breakable,
      width: 100%,
      spacing: 0pt,
      radius: (x: radius, y: 0),
      inset: (x: 1em, y: 0.35em),
      grid(
        columns: 2,
        gutter: 6pt,
        align: start + horizon,
        image("icons/" + file, width: 1.25em),
        text(if title != none { title } else { type-name }, weight: "bold"),
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

