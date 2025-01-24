#import "colors.typ": *

#let setup(body, header-l: none, header-r: none) = {
  let font-size = 11pt
  set text(font: "Radio Canada Big", size: font-size)
  // show heading.where(level: 2): set text(blue)

  set page(
    header: context {
      if here().page() != 1 {
        grid(
          columns: 2,
          gutter: 5pt,
          text(header-l, grey, style: "italic", size: font-size - 1pt),
          align(right, text(header-r, grey, style: "italic", size: font-size - 1pt)),
          grid.cell(
            colspan: 2,
            line(length: 100%, stroke: blue)
          )
        )
      }
    },
    footer: context {
      if counter(page).get().first() == 1 {
        return
      }
      
      let alignment = if calc.odd(counter(page).get().first()) {
        right
      } else {
        left
      }

    align(
      alignment, 
      counter(page).display(
        "1/1",
        both: true,
       )
     )
    }
  )

  body
}
