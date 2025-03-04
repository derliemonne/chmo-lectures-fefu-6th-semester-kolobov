#set text(lang: "ru", size: 14pt)
#set par(justify: true)
#import "@preview/mannot:0.2.2": *
#import "./utils.typ"



#align(center)[
  дальневосточный федеральный университет\
  институт математики и компьютерных технологий.\
  6-й семестр, 2024-2025 учебный год.\
  лектор: колобов александр георгиевич.
]


#align(center, text(22pt)[
  *Численные МетОды дифференциальных уравнений (ЧМО)*
])
#align(center, text(14pt)[
  также известные как
])

#align(center, text(22pt)[
  *отчисленные методы*
])



#align(right)[`2025-02-25`]

курс делится на 4 части

= первая часть


$ y' = f(x, y) wide phi(x, c) $

задача коши (или задача с начальными условиями) ставится обычно так:

$ y' = f(x, y) wide x in [x_0, x_0 + X] $

$ y(x_0) = y_0 wide y(x) = "решение" $

если условий больше, то такие задачи называются краевыми, потому что чаще всего мы работаем на отрезке и условия ставятся на краях отрезка.

$ y''(x) + p(x)y'(x) + q(x) y(x) = f(x) wide x in [a, b] $

смешанные условия самого общего вида:

$ alpha_1 y(a) + beta_1 y'(a) = gamma_1 \
  alpha_2 y(b) + beta_2 y'(b) = gamma_2
$

такая задача называется задачей дирихле.

пока что займёмся просто задачей коши.

$ y' = f(x, y) wide x in[x_0, x_0 + X] \
y(x_0) = y_0 $

самый простой способ --- использовать формулу тэйлора:

$y(x)$ --- есть, хотим посчитать $y(x+h)$:

$ y(x+h) = y(x) + h y'(x) + h^2/2 y''(x) + dots $

подойдём по рабочекрестьянски, выкинем производные второй степени и старше:

$ y(x+h) = y(x) + h f(x, y) + O(h^2) $

формула эйлера. формула грубовата, но на первый раз сойдёт, как говорится.

можно эту формулу улучшать.

$ y(x+h) = y(x) + integral_x^(x+h) f(x, y) dif x $

по разному приближая этот интеграл, мы получаем разные решения.

рассмотрим пример, аппроксимируем интеграл при помощи формулы трапеций:

$ y(x+h) = y(x) + h/2 (y'(x) + y'(x+h)) + O(h^3) $

где:

$ y'(x) = f(x, y)\
y'(x+h) = f(x + h, y(x + h)) $

это #mark(color: green)[неявная формула адамса]:

$ mark(y(x+h)) = y(x) + h/2 (f(x, y) + f(x + h, mark(y(x+h))) + O(h^3) $

она неявная, поэтому можно сделать так (улучшенный метод эйлера):

$ f(x+h, y(x+h)) := f(x+h, y^*) $

$ y^* := y(x) + h f(x, y) $

== рунге-кутта

$ alpha_2, alpha_3, dots, alpha_q, p_1, p_2, dots, p_q wide b_(i j) wide 0 < j < i <= q $

предположим, что мы знаем все эти константы.

$ k_1 (h) = h f(x, y) $

$ k_2 (h) = h f (x+alpha_2 h, y + beta_21 k_1 (h)) $

$ dots $

$ k_q (h) = h f (x+alpha_q h, y + beta_(q 1) k_1 (h) + dots + beta_(q, q-1) k_(q-1) (h)) $

$ y(x + h) approx y(x) + sum_(i=1)^q  p_i k_i (h) = z(h) $

$ y(x + h) = z(h) $

погрешность:

$ phi(h) = y(x+h) - z(h) $

будем считать, что $exists phi'(h), phi''(h), dots, phi^((s))(h), phi^((s+1))(h)$. будем выбирать константы так, чтобы все эти производные были нулями.

будем считать, что

$ phi(0) = 0\
  phi'(0) = 0\
  dots.v\
  phi^((s))(0) = 0\
  phi^((s+1))(0) != 0
$

$ phi(h) = sum_(i=0)^s (phi^((i))(0))/i! h^i + (phi^((s+1))(theta h)) / (s+1)! h^(s+1), wide 0 < theta < 1 $

$ markrect(phi(h) = O(h^(s+1)), padding: #0.5em) $

пример:

$ q=1\
  phi(h) = y(x+h) - y(x) - p_1 h f(x, y) wide phi(0) = 0\
  phi'(h) = y'(x+h) - p_1 f(x, y)\ phi'(0) = y'(x) - p_1 f(x, y) = f(x, y)(1-p_1)=0 wide p_1 = 1\
 $

$
  phi''(h) = y''(x+h)\
  phi''(0) = y''(x)
  
$

$ 
  y(x+h) = y(x) + h f(x, y)
$

вот получили формулу эйлера, теперь рассмотрим:

$ q= 2 $

$ phi(h) = y(x+h) - y(x) - p_1 k_1 (h) - p_2 k_2 (h) $

формула при $q=4$:

$ k_1 = h f(x, y) wide k_2 = h f(x+h/2, y+k_1/2) wide k_3=h f (x+h/2, y+k_2/2) $

$ k_4 = h f(x+h, y+k_3) wide y(x+h) = y(x) + 1/6 (k_1 + 2 k_2 + 2 k_3 + k_4 ) $

просто тупо запускаем цикл по `i`:

$ y_(i+1) = y_i + 1/6(dots $

$ abs(R_n) <= e^(M X)  [cosh' X + N epsilon + abs(R_0)] $

$R_0$ --- это начальная погрешность, $M-$ константа, $X$ --- длина отрезка

$ R_n = y(x_n) - y_n wide n <= N $

$ O(h^q) $

#align(right)[`2025-03-04`]

= метод конечных разностей

$ cases(
    L u(x) = f(x) comma space x in G,
    l u(x) = mu(x) comma space x in Gamma
), quad H_0 $

$
  overline(G) = G + Gamma
$

пусть наш отрезок для определённости $[0, 1]$

$ overline(omega) = {x_k = h k, k = 0, 1, dots, N; h dot N = 1} $

$ Delta_h $

$ y_h (x_k), space x_k in overline(omega)_h $

проекция точного решения на сетку:

$ u_h = P_h u $

$P$ --- оператор проектирования.

теперь можно сравнивать $norm(y_h - u_h)_h$.

условаие согласования:

$  norm(dot)_0 := lim_(h->0) norm(dot)_h $

$ norm(y)_C = max_(y in overline(G)) abs(y(x)) $

аналог на сетке:

$ norm(y_h)_C = max_(x_k in overline(omega)_h) abs(y(x_k)) $

чаще всего работают с:

$ norm(y)_L_2 = (integral_0^1 y^2(x) dif x)^(1/2) $

$ [norm(y_h)] = (sum_(i=0)^N y^2 (x_i))^(1/2) $

$ ]norm(y_h)[ = (sum_(i=1)^(N-1) y^2 (x_i))^(1/2) $

скобочками показывают включение крайних точек.

\

$ L, space L_h $

$ l, space l_h $

$ cases(
    L_h u_h = phi_h,
    l_h u_h = chi_h)  
$

$ L_h u_h = sum_(xi in Ш(x, h)) A_h (x, xi) dot u_h (xi) $

$Ш(x, h)$ --- шаблон

аппроксимация первой производной:

$ (u(x+h) - u(x))/h wide (x, x+h) $

введём понятие погрешность аппроксимации в конкретной точке:

$ psi(x) = L_h u(x) - L u(x) $

порядок аппроксимации $m:$
$ psi(x) = O(h&^m) $

вернёмся к разностной задаче:

$ cases(
    L_h u_h = phi_h,
    l_h u_h = chi_h)  
$

это СЛАУ.

погрешность решения:

$ z_h = y_h - u_h $

если подставить погрешность решения:

$ cases(
  L_h z_h = psi_h,
  l_h z_h = nu_h
) $

если выполняются пределы, то аппроксимация работает:

$ norm(psi_h)_h_1 -->_(h->0) 0 $

$ norm(nu_h)_h_2 -->_(h->0) 0 $

$ norm(psi_h)_h_1 = O(h^m) $

$ norm(nu_h)_h_2 = O(h^m) $

обратите внимание, что можно использовать разные нормы.

мы говорим о сходимости, если:

$ norm(z_h)_h_3 -->_(h->0) 0 $

$ norm(z_h) = O(h^m) $

ещё нас интересует корректность задачи (единственное решение + устойчивость).

держу в курсе, мы работаем только с линейными задачами.

$ norm(y_h)_h_1 <= M_1 abs(phi_h)_h_2 + M_2 norm(chi_h)_h_3 $

$M_1, M_2$ --- const.

из аппроксимации и устойчивостти следует сходимость (теорема филиппова):

$ norm(z_h)_h_1 = norm(y_h - u_h)_h_1 <= M_1 norm(psi_h)_h_2 + M_2 norm(nu_h)_h_3  $

$ norm(z_h) -->_(h->0) 0 $

\

$ u'(x) $

$ (u(x+h) - u(x))/h = u'(x) + O(h) "разность вперёд" $

$ (u(x) - u(x - h))/h = u'(x) + O(h) "разность назад" $

$ (u(x+h) - u(x-h))/(2h)) = u'(x) + O(h^2) "центральная разность" $

как это доказать?

$ u(x plus.minus h) = u(x) plus.minus h u'(x) + h^2 /2 u''(x) plus.minus h^3/6 u'''(x) + O(h^4) $

для второй производной трёхточечный шаблон:

$ (u(x+h) - 2 u (x) + u(x - h))/ h^2 = u''(x) + O(h^2) $

\

$ sigma (u(x+h) - u(x))/h + (1 - sigma) (u(x+2h) - u(x+h))/h = u'(x) + h/2(3-2 sigma)u''(x) + O(h^2) $

лучшая $sigma=3/2$:

$ (4 u(x+h) - 3 u(x) - u(x+2 h))/(2h) $

$ (3 u(x) - 4u(x-h) + u(x-2h))/(2h) $

\

вот эту задачу мы будем решать весь семестр:

$ u''(x) + p(x) u'(x) + q(x) u(x) = f(x), quad x in [0,1] $

$ alpha_1 u(0) + beta_1 u'(0) = gamma_1 $

$ alpha_2 u(1) + beta_2 u'(1) = gamma_2 $

$ x_i in overline(omega)_h $

разностная схема:

$ (y_(i+1) - 2y_i + y_(i-1))/h^2 + p_i (y_(i+1)-y(i-1))/(2h) + q_i u_i = f_i, quad i = 1, dots, N-1 $

эта схема точности $O(h^2)$. теперь добавляем граничные условия, тоже их аппроксимируем:

$ alpha_1 y_0 + beta_1 (y_1 - y_0)/h = gamma_1 $

$ alpha_2 y_N + beta_2 (y_N - y_(N-1))/h = gamma_2 $

здесь мы только точность $O(h)$ сделали. поэтому вообще эта схема из-за граничных условий становится схемой первого порядка.

а теперь сделаем второй порядок:

$ alpha_1 y_0 + beta_1 (-3y_0 + 4y_1 - y_2)/(2h) = gamma_1 $

$ alpha_2 y_N + beta_2 (dots.c) = gamma_2 $

