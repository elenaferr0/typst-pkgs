#let code-block(body, title: none, border: true, breakable: false) = {
  let color = rgb(200,200,200);

  v(5pt)
  block(
    breakable: breakable,
    radius: 5pt,
    stroke: if border {1pt + color},
  )[
    #if title != none {
      block(
        radius: (top: 5pt, bottom: 0pt),
        fill: color,
        breakable: breakable,
        width: 100%,
        spacing: 0pt,
        inset: (x: 1em, y: 0.55em),
        text(raw(title, theme: none), size: 12pt, weight: "bold"),
      )
    }
    #block(
      width: 100%,
      breakable: true,
      inset: (x: 1em, y: 0.65em),
    )[
      #body
    ]
  ]
}
