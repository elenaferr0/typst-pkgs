#import "colors.typ": *

#let cover(
  body,
  title: str,
  subtitle: none,
  name: str,
  uni: str,
  primary-color: blue,
  secondary-color: light-blue,
) = {
  place(
    bottom + left,
    [
      #move(
        dx: -200pt,
        dy: 250pt,
        [#rotate(30deg, [#rect(width: 500pt, height: 300pt, fill: secondary-color, stroke: none)])],
      )
    ],
  )

  place(
    bottom + right,
    [
      #move(
        dx: 280pt,
        dy: 250pt,
        [#rotate(-30deg, [#rect(width: 1000pt, height: 400pt, fill: primary-color, stroke: none)])],
      )
    ],
  )

  v(35%)

  set text(30pt)
  heading(outlined: false, text(title), numbering: none)
  set text(16pt)
  if subtitle != none {
    heading(outlined: false, text(subtitle), numbering: none)
    v(5%)
  }

  set text(16pt)
  text(name)
  linebreak()
  set text(12pt)
  text(uni)

  pagebreak()

  body
}
