#import "colors.typ": *

#let setup(body, header-l: none, header-r: none, main-color: none) = {
  let font-size = 11pt
  // set rules
  set text(font: "Radio Canada Big", size: font-size)

  set heading(numbering: "1.")

  set outline(depth: 3, indent: 10pt)

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
            line(length: 100%, stroke: grey)
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

  // show rules
  show outline: o => {
    o
    pagebreak()
  }

  body
}
