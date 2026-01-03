#import "template.typ": project

#show: project.with(
  title: "随机过程复习笔记",
  author: "申奥"
)

// 1. 设置目录不需要编号，这样模板就不会给它加“第0章”
#set heading(numbering: none)
#outline(indent: auto)

// 2. 目录之后，开启正文编号，格式为 "1.1"
#set heading(numbering: "1.1")

// --- 正文开始 ---

// 【注意】这里不要再写“= 第1章 预备知识”，只写标题名字
// 模板会自动把它变成“第 1 章 预备知识”
= 预备知识
#include "chapters/01_preliminaries/1.1_prob_space.typ"
#include "chapters/01_preliminaries/1.6_cond_exp.typ"

// 你的 Fortest 笔记
// 如果你希望这些笔记也算作正式章节（第2章...），保持现状即可
// 如果你希望它们只是附录或者不带“第X章”，可以在 include 前加 #set heading(numbering: none)
= 考点速记与真题
#include "chapters/Fortest/01_definition_review.typ"