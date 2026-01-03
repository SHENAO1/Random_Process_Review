#import "../../template.typ": *

// 【注意】已移除 #show: project...

// 原一级标题改二级 (==)
== 基础知识回顾

#kbox("连续均匀分布 U(a, b)", [
  若随机变量 $X$ 在区间 $[a, b]$ 上取任意值的概率相等，则称 $X$ 服从均匀分布。
  
  *概率密度函数 (PDF):*
  $ f(x) = cases(1/(b-a) &\, a <= x <= b, 0 &\, "其他") $

  *数字特征:*
  - 均值: $E X = (a+b)/2$
  - 方差: $D X = E X^2 - E^2 X = (b-a)^2 / 12$
  - 矩生成函数: $M_X (t) = E[e^(t X)] = (e^(t b) - e^(t a)) / (t(b-a))$
])

#intuition("独立性与相关性性质", [
  1. *独立性定义:* $f_(X Y)(x, y) = f_X (x) dot f_Y (y)$ 或 $P(X=x, Y=y) = P(X=x) P(Y=y)$。
  2. *性质:* 若 $X, Y$ 独立，则 $E[X Y] = E X dot E Y$，协方差 $op("Cov")(X, Y) = 0$，相关系数 $rho(X, Y) = 0$。
  3. *方差性质:* $op("Var")(X + Y) = op("Var")(X) + op("Var")(Y)$ (需独立)。
])

// 原一级标题改二级 (==)
== 典型例题解析

// 原二级标题改三级 (===)
=== 题型一：含随机相位的过程 (2015.1)

#exbox("2015.1 真题", [
  *题目:* 设有随机过程 $X(t) = A cos(omega_0 t + Phi)$。其中 $omega_0 > 0$ 为常数，$A$ 与 $Phi$ 是相互独立且服从在 $[0, 1]$ 区间上均匀分布的随机变量。求过程的均值函数。

  *解:*
  根据期望的线性性质与独立性：
  $ E[X(t)] &= E[A cos(omega_0 t + Phi)] \
            &= underbracket(E[A], "独立") dot E[cos(omega_0 t + Phi)] $
  
  由 $A ~ U(0, 1)$，得 $E[A] = (0+1)/2 = 1/2$。
  
  由 $Phi ~ U(0, 1)$，利用期望定义积分：
  $ E[cos(omega_0 t + Phi)] &= integral_0^1 cos(omega_0 t + Phi) dot 1 dif Phi \
  &= [sin(omega_0 t + Phi)]_(Phi=0)^(Phi=1) \
  &= sin(omega_0 t + 1) - sin(omega_0 t) $
  
  *综上所述:*
  $ E[X(t)] = 1/2 [sin(omega_0 t + 1) - sin(omega_0 t)] $
])

// 原二级标题改三级 (===)
=== 题型二：随机变量的线性组合 (2011.1)

#exbox("2011.1 真题", [
  *题目:* $X, Y$ 两个随机变量的均值函数和方差分别为 $m_X, m_Y, delta_X, delta_Y$，相关系数为 $rho$。设 $Z(t) = X + t Y$。求 $m_Z(t)$ 和 $R_Z(t_1, t_2)$。

  *预备公式:*
  - $E[a X + b Y] = a E X + b E Y$
  - $D X = E X^2 - E^2 X arrow.double E X^2 = D X + E^2 X = delta_X + m_X^2$
  - $rho = op("Cov")(X, Y) / (sqrt(D X) sqrt(D Y)) = (E[X Y] - E X E Y) / (sqrt(delta_X) sqrt(delta_Y))$
  - 故 $E[X Y] = rho sqrt(delta_X delta_Y) + m_X m_Y$

  *解:* 1. *求均值函数 $m_Z(t)$*
     $ m_Z(t) = E[Z(t)] = E[X + t Y] = E X + t E Y = m_X + t m_Y $
  
  2. *求自相关函数 $R_Z(t_1, t_2)$*
     $ R_Z(t_1, t_2) &= E[Z(t_1) Z(t_2)] = E[(X + t_1 Y)(X + t_2 Y)] \
     &= E[X^2 + t_2 X Y + t_1 Y X + t_1 t_2 Y^2] \
     &= E X^2 + (t_1 + t_2) E[X Y] + t_1 t_2 E Y^2 $
     
     代入预备公式中的结论：
     $ R_Z(t_1, t_2) = (delta_X + m_X^2) + (t_1 + t_2)(rho sqrt(delta_X delta_Y) + m_X m_Y) + t_1 t_2 (delta_Y + m_Y^2) $
])

// 原二级标题改三级 (===)
=== 题型三：高斯过程与三角函数 (2016.2)

#exbox("2016.2 真题", [
  *题目:* 设随机过程 $X(t) = U cos omega_0 t + V sin omega_0 t, t >= 0$。其中 $omega_0$ 为常数，$U, V$ 是两个相互独立且正态分布的变量，且 $E U = E V = 0, E U^2 = E V^2 = sigma^2$。求该过程的一维概率密度函数。

  *解:* 要确定一维PDF，对于线性组合的高斯变量，关键在于求出均值和方差。
  
  1. *求均值:*
     $ E[X(t)] = E[U cos omega_0 t + V sin omega_0 t] = cos(omega_0 t) E U + sin(omega_0 t) E V = 0 $
  
  2. *求方差:*
     $ D[X(t)] &= E[X^2(t)] - E^2[X(t)] = E[X^2(t)] \
     &= E[(U cos omega_0 t + V sin omega_0 t)^2] \
     &= E[U^2 cos^2 omega_0 t + 2 U V sin omega_0 t cos omega_0 t + V^2 sin^2 omega_0 t] \
     &= cos^2(omega_0 t) E U^2 + sin(2 omega_0 t) E[U V] + sin^2(omega_0 t) E V^2 $
     
     由于 $U, V$ 独立，$E[U V] = E U E V = 0$。且 $E U^2 = E V^2 = sigma^2$。
     $ D[X(t)] = sigma^2 (cos^2 omega_0 t + sin^2 omega_0 t) = sigma^2 $
  
  3. *确定分布:*
     由于 $U, V$ 是相互独立的高斯变量，$X(t)$ 是 $U, V$ 的线性组合给，$X(t)$ 对于固定的 $t$ 也是高斯随机变量。
     即 $X(t) ~ N(0, sigma^2)$。
  
  *一维概率密度函数:*
  $ f_X (x) = 1/(sqrt(2 pi) sigma) e^(- x^2 / (2 sigma^2)), quad x in (-infinity, +infinity) $
])

// 原二级标题改三级 (===)
=== 题型四：多项式型随机过程 (课后题 2.1)

#exbox("课后题 2.1", [
  *题目:* 设随机过程 $X(t) = X t + Y + Z t^2$ (注：右侧 $X,Y,Z$ 为随机变量)。其中 $X, Y, Z$ 是相互独立的随机变量，且均值为 $0$，方差为 $1$。求随机过程 $X(t)$ 的协方差函数 $C_X(t_1, t_2)$。

  *分析:*
  - 均值函数: $m_X(t) = E[X(t)] = t E X + E Y + t^2 E Z = 0$。
  - 协方差函数定义: $C_X(t_1, t_2) = E[(X(t_1) - m_X(t_1))(X(t_2) - m_X(t_2))]$。
  - 当 $m_X(t) = 0$ 时，$C_X(t_1, t_2) = R_X(t_1, t_2) = E[X(t_1) X(t_2)]$。
  - 已知条件: $E X = E Y = E Z = 0$, $D X = D Y = D Z = 1$。
  - 推论: $E X^2 = D X + (E X)^2 = 1$ (同理 $E Y^2 = 1, E Z^2 = 1$)。
  - 交叉项: 因独立且均值为0，如 $E[X Y] = E X E Y = 0$。

  *解:*
  $ C_X(t_1, t_2) &= E[X(t_1) X(t_2)] \
  &= E[(X t_1 + Y + Z t_1^2)(X t_2 + Y + Z t_2^2)] \
  &= E[X^2 t_1 t_2 + X Y t_1 + X Z t_1 t_2^2 + Y X t_2 + Y^2 + Y Z t_2^2 + Z X t_1^2 t_2 + Z Y t_1^2 + Z^2 t_1^2 t_2^2] $
  
  利用期望线性性质，所有含交叉项（如 $X Y, X Z, Y Z$）的期望均为 0。只剩下平方项：
  $ &= t_1 t_2 E X^2 + E Y^2 + t_1^2 t_2^2 E Z^2 \
  &= t_1 t_2 (1) + 1 + t_1^2 t_2^2 (1) \
  &= 1 + t_1 t_2 + t_1^2 t_2^2 $
  
  *结果:*
  $ C_X(t_1, t_2) = 1 + t_1 t_2 + t_1^2 t_2^2 $
])