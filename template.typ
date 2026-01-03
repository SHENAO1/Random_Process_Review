// template.typ

// --- 1. 字体与配色定义 ---
#let colors = (
  mainblue: rgb(0, 102, 204),
  alertred: rgb(204, 0, 0),
  intuitiongreen: rgb(0, 128, 128),
  subbg: rgb(240, 245, 250),
  graytext: luma(100),
)

// 精简字体列表
#let fonts = (
  serif: ("Source Han Serif SC", "SimSun"),      // 宋体
  sans:  ("Source Han Sans SC", "SimHei"),       // 黑体
  english: ("Linux Libertine", "Times New Roman"), // 西文
)

// --- 2. 辅助状态定义 ---
#let utils = (current-heading: state("current-heading", ""),)

// 自动更新章节标题的状态
#show heading.where(level: 1): it => { utils.current-heading.update(it.body); it }


// --- 3. 核心盒子组件 ---
#let colorbox(title, body, color: colors.mainblue, icon: none) = {
  block(
    width: 100%,
    breakable: true, 
    spacing: 1.2em,
    stack(
      dir: ltr,
      rect(
        width: 100%,
        fill: color.lighten(95%),
        stroke: 1pt + color,
        radius: 4pt,
        inset: 0pt,
        stack(
          dir: ttb,
          // 标题栏
          block(
            width: 100%,
            fill: color,
            inset: (x: 10pt, y: 8pt),
            radius: (top-left: 3pt, top-right: 3pt),
            text(fill: white, weight: "bold", size: 10.5pt, font: fonts.sans)[
              #if icon != none { icon + h(0.5em) } #title
            ]
          ),
          // 内容区
          block(
            width: 100%,
            fill: white,
            inset: 12pt,
            radius: (bottom-left: 3pt, bottom-right: 3pt),
            body
          )
        )
      )
    )
  )
}

// --- 4. 主项目函数 ---
#let project(title: "", author: "", body) = {
  set document(author: author, title: title)
  set page(
    paper: "a4",
    margin: (x: 1.8cm, y: 2.2cm), 
    numbering: "1",
    header: context {
      // 只有非第一页才显示页眉
      if counter(page).get().first() > 1 [
        #set text(fill: colors.graytext, size: 9pt, font: fonts.sans)
        #align(left + bottom, stack(dir: ltr, 
             [随机过程复习笔记], h(1fr), utils.current-heading.get()
        ))
        #line(length: 100%, stroke: 0.5pt + colors.graytext)
      ]
    }
  )

  // 【全局字体设置】
  set text(
    font: (fonts.english.at(0), ..fonts.serif), 
    lang: "zh", 
    size: 10.5pt, 
    fill: black 
  )

  // 【粗体魔法】
  show strong: set text(font: (fonts.english.at(0), ..fonts.sans))

  set par(leading: 1em, first-line-indent: 2em, justify: true)

  // 【标题样式 - 已修复自动编号逻辑】
  show heading: it => {
    // 标题使用黑体
    set text(font: fonts.sans, weight: "bold", fill: colors.mainblue)
    
    if it.level == 1 {
       pagebreak(weak: true)
    }

    block(below: 1em, above: 1.5em)[
      #if it.level == 1 {
         // 检测是否开启了编号
         if it.numbering != none {
            text(size: 16pt)[第 #counter(heading).display() 章 #h(0.5em) #it.body]
         } else {
            // 如果是目录或无编号章节，直接显示标题
            text(size: 16pt)[#it.body]
         }
      } else {
        // 二级及以下标题
        text(size: 12pt)[
          #if it.numbering != none { counter(heading).display() + h(0.5em) } 
          #it.body
        ]
      }
    ]
  }

  // 数学公式字体
  show math.equation: set text(font: "New Computer Modern Math")
  set math.equation(numbering: "(1)")

  // 列表样式优化
  set list(indent: 1em, marker: ([•], [--]))
  show list: it => block(spacing: 0.6em, it)

  // 封面
  align(center)[
    #v(4em)
    #block(stroke: (y: 2pt + colors.mainblue), inset: 2em, width: 100%)[
      #text(2.5em, weight: "bold", font: fonts.sans, fill: colors.mainblue, title)
    ]
    #v(2em)
    #text(1.2em, author)
    #v(4em)
  ]

  body
}

// --- 5. 导出快捷命令 ---
#let kbox(title, body) = colorbox(title, body, color: colors.mainblue)
#let exbox(title, body) = colorbox(title, body, color: colors.alertred)
#let intuition(title, body) = colorbox(title, body, color: colors.intuitiongreen)