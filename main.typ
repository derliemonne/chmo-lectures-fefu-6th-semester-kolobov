#set text(lang: "ru", size: 14pt)
#set par(justify: true)
#set heading(numbering: "1.")
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

$ alpha_2, alpha_3, dots, alpha_q, p_1, p_2, dots, p_q wide beta_(i j) wide 0 < j < i <= q $

предположим, что мы знаем все эти константы.

$ k_1 (h) = h f(x, y) $

$ k_2 (h) = h f (x+alpha_2 h, y + beta_21 k_1 (h)) $

$ dots $

$ k_q (h) = h f (x+alpha_q h, y + beta_(q 1) k_1 (h) + dots + beta_(q, q-1) k_(q-1) (h)) $

$ y(x + h) approx y(x) + sum_(i=1)^q  p_i k_i (h) = z(h) $

$ y(x + h) approx z(h) $

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

== метод конечных разностей

$ cases(
    L u(x) = f(x) comma space x in G,
    l u(x) = mu(x) comma space x in Gamma
), quad H_0 $

$
  overline(G) = G + Gamma
$

пусть наш отрезок для определённости $[0, 1]$

$ overline(omega) = {x_k = h k, k = 0, 1, dots, N; h dot N = 1} $

$ Delta h $

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

$ (u(x+h) - u(x-h))/(2h) = u'(x) + O(h^2) "центральная разность" $

как это доказать?

$ u(x plus.minus h) = u(x) plus.minus h u'(x) + h^2 /2 u''(x) plus.minus h^3/6 u'''(x) + O(h^4) $

для второй производной трёхточечный шаблон:

$ (u(x+h) - 2 u (x) + u(x - h))/ h^2 = u''(x) + O(h^2) $

\

$ sigma (u(x+h) - u(x))/h + (1 - sigma) (u(x+2h) - u(x+h))/h = u'(x) + h/2(3-2 sigma)u''(x) + O(h^2) $

лучшая $sigma=3/2$:

$ (4 u(x+h) - 3 u(x) - u(x+2 h))/(2h) $

// $ (3 u(x) - 4u(x-h) + u(x-2h))/(2h) $

\

вот эту задачу мы будем решать весь семестр:

$ u''(x) + p(x) u'(x) + q(x) u(x) = f(x), quad x in [0,1] $

$ alpha_1 u(0) + beta_1 u'(0) = gamma_1 $

$ alpha_2 u(1) + beta_2 u'(1) = gamma_2 $

$ x_i in overline(omega)_h $

разностная схема:

$ (y_(i+1) - 2y_i + y_(i-1))/h^2 + p_i (y_(i+1)-y_(i-1))/(2h) + q_i u_i = f_i, quad i = 1, dots, N-1 $

эта схема точности $O(h^2)$. теперь добавляем граничные условия, тоже их аппроксимируем:

$ alpha_1 y_0 + beta_1 (y_1 - y_0)/h = gamma_1 $

$ alpha_2 y_N + beta_2 (y_N - y_(N-1))/h = gamma_2 $

здесь мы только точность $O(h)$ сделали. поэтому вообще эта схема из-за граничных условий становится схемой первого порядка.

а теперь сделаем второй порядок:

$ alpha_1 y_0 + beta_1 (-3y_0 + 4y_1 - y_2)/(2h) = gamma_1 $

$ alpha_2 y_N + beta_2 (dots.c) = gamma_2 $

#align(right)[`2025-03-11`]

== распространение волны

три типа уравнений:

$ (diff^2 u)/(diff t^2) = a^2 (diff^2 u)/(diff x^2) $

$ (diff u)/(diff t) = a (diff^2 u)/(diff x^2), quad a>0 $

эллиптическое уравнение лапласа:

$ (diff^2 u)/(diff x^2) + (diff^2 u)/(diff y^2) = 0 $

если правая часть не $=0$, а $=f(x,y)$, то это уравнение пуассона.

для построения разностных схем нужно ввести сетку. тут уже две переменные $x, y$, нужно две сетки, например, $x in [0,1], space t in [0, T]$.

пример прямоугольной сетки на двухмерном пространстве:

$ x_i = a + i h wide y_i = c+i l $

возьмём уравнение теплопроводности:

$ (diff U)/(diff t) = a (diff^2 U)/(diff x^2) quad 0 <= x <= 1, space a>0, space t >0 $

начальное условие:

$ U(x, 0) = phi(x) $

граничное условие:

$ U(0, t) = psi_1 (t) \ U(1, t) = psi_2 (t) $

сетка:

$ x_i = i h, space i = 0, 1, dots, N $

$ t_j = j tau, space j = 0, 1, dots $

$U_i^j$ --- обозначение для $U(x_i, t_j)$. снизу пространственные координаты, сверху --- временная.

$ (u_i^(j+1) - u_i^j)/tau = a (u_(i+1)^j - 2 u_i^j + u_(i-1)^j)/h^2  $

$ u_i^0 = phi(x_i) $

это двуслойная схема по времени $O(tau)$, по пространству $O(h^2)$. записывают просто $O(tau + h^2)$. схема является явной.

напишем ещё одну схему для того же уравнения (то же самое, но по времени $j+1$):

$ (u_i^(j+1) - u_i^j) / tau = a (u_(i+1)^mark(j+1) - 2 u_i^mark(j+1) + u_(i-1)^mark(j+1))/h^2 $

тут на $j$-м слое одна точка, а на $(j+1)$-м аж три! это неявная схема. придётся решать СЛАУ. можно юзать метод монотонной прогонки.

точность такая же. но зачем нам тогда неявная схема? оказывается, она для чего-то нужна.

давайте запишем дифференциальную задачу

$ L U(x, t) = F(x, t) $

$ G, Gamma, overline(G) $

построим разностную схему:

$ L_h u_h = f_h $

пусть $tau = r  h$, то есть шаги зависимы.

рассмотрим разность между точным и приближённым:

$ delta u_i^j := U_i^j - u_i^j $

$ delta u := max_(i, j) abs(delta u_i^j) $

считаем, что разностная схема сходится, если:

$ lim_(h->0) delta u = 0 $

мы говорим о точности $k$-го порядка, если $u <= "const" dot h^k$

$ u_h = U_h - delta_h $

$ L_h u_h = L_h U_h - L_h delta_h = f_h $

невязка, погрешность аппроксимации:

$ R_n = L_h U_h - f_h $

$ L_h delta_h = R_h $

$ R := max R_h  $

более-менее точное определение аппроксимации:

$ lim_(h->0 \ tau -> 0) R = 0 $

на минуточку представим, что разностная схема у нас очень сложная и:

$ O(h^2 + tau + tau/(h^2)) $

нам для аппроксимации надо, чтобы $tau$ стремился к нулю быстрее, чем $h^2$.

есть такое понятие, как условная аппроксимация и безусловная (абсолютная). если $tau$ стремится к нулю быстрее, чем $h^2$, то это условная аппроксимация. если $O(h^2 + tau^2)$ --- то это абсолютная аппроксимация.

$ u_i^(j+1) = lambda u_(i-1)^j + (1-2lambda)u_i^j + lambda u_(i+1)^j, space lambda := (a tau)/h^2 $

предположим, что $lambda <= 1/2$. то есть уже некое ограничение на соотношение шагов. сумма коэффициентов:

$ lambda + (1- 2 lambda) + lambda = 1 $

а теперь оценим:

$ max_(1 <= i <= N -1) abs(u_i^(j+1)) = max_(1 <= i <= N-1) abs(lambda u_(i-1)^j + (1 - 2 lambda) u_i^j + lambda u_(i-1)^j) <= max_(1<=i<=N-1) abs(u_i^j) (lambda + (1 -2lambda) + lambda) $

получили:

$ max_(1<=i<=N-1) abs(u_i^(j+1)) <= max_(1<=i<=N-1) abs(u_i^j) $

то есть решение со временем не растёт! а что это есть как не устойчивость? это и есть устойчивость!

можно ещё будет пошаманить и показать, что $lambda > 1/2$, то процесс развалится, но мы конечно же доказывать такое не будем.

это конечно не дикий недостаток, но недостаток всё же --- ограничение на соотношение шагов.

а давайте теперь запишем неявную схему:

$ lambda u_(i-1)^(j+1) - (1 + 2lambda) u_i^(j+1) + lambda u_(i-1)^(j+1) = -u_i^j, space i=1, 2, dots, N-1 $

нужно решать слау методом прогонки.

вспомним условие адамара (диагональное преобладание), когда:

$ abs(a_(i j)) > sum_(j=1 \ j!=i) abs(a_(i j)) $

тут диагональное преобладание на лицо:

$ abs(1 + 2 lambda) > abs(lambda) + abs(lambda) $

#align(right)[`2025-03-18`]

== волновое уравнение

$ (diff^2 U)/(diff t^2) = a^2 (diff^2 U)/(diff x^2) $

$ U|_(t=0) = U(x, 0) = phi(x) $

$ lr((diff U)/(diff t)|)_(x=0) = 0, space U|_(x=0) =0 $

шаблон --- крест:

$ i, j+1 $
$ i-1, j wide i, j wide i+1, j $
$ i-1, j-1 $

$ (u_i^(j+1) - 2u_i^j + u_i^(j-1))/(tau^2) = a^2 (u_(i+1)^i - 2u_i^j + u_(i-1)^j)/h^2 $

$ u_i^0 = phi(x_i) $

$ (u_i^1 - u_i^0) / tau = psi(x_i) => u_i^1 = u_i^0 + tau psi(x_i) wide =O(tau) $

и так далее...

эта схема второго порядка $O(h^2 + tau^2)$. но на первом шаге мы потеряем точность. но это не критично.

будем юзать тейлора:

$ u_i^1 = u_i^0 + tau lr((diff^2 u)/(diff t)|)_(t=0)  + tau^2 / 2 lr((diff^2 u)/(diff t^2)|)_(t=0) + O(tau^3) $

конкретно:

$ u_i^1 = u_i + tau psi(x_i) + tau^2 / 2 a^2 (diff^2 u)/(diff x^2) $

$ u_i^1 = phi(x_i) + tau psi(x_i) + (tau^2 a^2)/2 phi''(x_i) $

$ lambda := (a^2 tau^2) / h^2 $

$ u_i^(j+1) = 2 (1 - lambda) u_i^j + lambda (u_(i+1)^j - u_(i-1)^j) - u_i^(j-1) $

$ lambda < 1 $

следующая схема:

$ (u_i^(j+1) - 2u_i^j + u_i^(j+1)) / tau^2 = a^2 / 2 ((u_(i-1)^(j+1) - 2u_i^(j+1) + u_(i+1)^(j+1))/ h^2  + (u_(i-1)^(j-1) - 2u_i^(j-1) + u_(i+1)^(j-1))/ h^2) $

$ lambda u_(i-1)^(j+1) - (1 + 2 lambda) u_i^(j+1) + lambda_(i+1)^(j+1) = (1 + 2 lambda) u_i^(j+1) - lambda (u_(i+1)^(j-1) + u_(i-1)^(j-1)) - 2u_(i)^j $

$ u_0^j - u_N^j = 0 $

== уравнение теплопроводности

$ (diff U)/(diff t) = (diff^2 U)/(diff x^2) + (diff^2 U)/(diff y^2) $

$ U(x, y, 0) = phi(x, y) $

положим $ 0<= x <= 1, space 0 <= y <= 1, space 0 <= t <= T$. вот в таком параллелепипеде рассмтраиваем задачу.

$ x_i = i h, space y_i = j l, space t_k = tau k $

// параллелепипед разбивается на маленькие параллелепипеды этими плоскостями.

посмотрим на схему:

$ (u_(i j)^(k+1) - u_(i j)^k) / tau = (u_(i+1,j)^k - 2u_(i j)^k + u_(i-1, j)^k)/h^2 + (u_(i, j+1)^k - 2 u_(i j)^k + u_(i, j -1)^k)/l^2 $

$ u_(i j)^(k+1) = (1 - 2lambda_1 - 2 lambda_2)u_(i j)^k + lambda_1(u_(i+1, j)^k + u_(i-1, j)^k) + lambda+2 (u_(i,j+1)^k + u_(i, j-1)^k) $

$ lambda_1 = tau/h^2 wide lambda_2 = tau/l^2 $

условие устойчивости: $lambda_1 + lambda_2 <= 1/2$.

можно себе упростить жизни. рассмотрим, когда $lambda_1 + lambda_2 = 1/2$.

устойчивость --- норма решения не растёт по времени.

$ lambda_1 (u_(i-1, j)^(k+1) + u_(i+1,j)^(k+1)) - (1+2lambda_1 + 2lambda_2) u_(i j)^(k+1) + lambda_2 (u_(i, j-1)^(k+1) + u_(i, j+1)^(k+1)) = - u_(i j)^k $

тут будет матричная прогонка.

== уравнение лапласа (эллиптическое)

$ (diff^2 U)/(diff x^2) + (diff^2 U)/(diff y^2) = 0 $

$ U|_Gamma = phi(x, y)  $

этот процесс стационарный --- от времени не зависит.

схема типа крест:

$ (u_(i+1, j) - 2u_(i,j) + u_(i-1, j))/ h^2 + (u_(i,j+1) - 2u_(i,j) + u_(i, j-1))/h^2 = 0 $

предположили, что шаг по $x$ и $y$ одинаков $=h$.

$ u_(i j) = 1/4 (u_(i+1, j) + u_(i-1,j) + u_(i,j+1) + u_(i, j-1)) $

решаем итерационно:

$ u_(i j)^((k+1)) = 1/4 (u_(i+1, j)^((k)) + u_(i-1,j)^((k)) + u_(i,j+1)^((k)) + u_(i, j-1)^((k))) $

это метод якоби в чистом виде!

но лучше использовать другой подход, более красивый.

$ (diff U)/(diff t) = (diff^2 U)/(diff x^2) + (diff^2 U)/(diff y^2) $

$ U|_Gamma = phi(x, y) $

по сути это тоже самое, ведь процесс-то стационарный. этот подход называется фиктивным временем.
таким образом мы перешли от эллиптического к параболическому уравнению. это метод установления.

$ (diff^2 V)/(diff x^2)+(diff^2 V)/(diff y^2) = 0 $

$ U stretch(->)_(t -> oo) V $

сходимость очень быстрая, 4-5 шагов!

\

```
на этом первая часть окончена. можно сдавать коллок!
```

#align(right)[`2025-03-25`]

= вторая часть

рассмотрим функци#emph[анал]:

$ J_1 (u) = integral_a^b pi(x, u, u') dif x $

$ u = u(x) $

имеет первую непрерывную производную. граничные условия:

$ u(a) = u_a wide u(b) = u_b $

$u_1$ находится в $epsilon$-окрестности функции:

$ abs(u_1 (x) - u(x)) <= epsilon $

среди функций, лежащих в $epsilon$-окрестности, имеющих непрерывную производную и удовлетворяющих граничным условиям, найти функцию, доставляющую экстремум функционалу $J_1$.

введём ещё функцию $eta: eta (a) = eta(b) = 0$.

$ u_alpha (x) = u(x) + alpha eta (x) $

параметр $alpha$ мал, чтобы $u_alpha$ тоже попадала в окрестность.

подставим:

$ J_1 (u_alpha) = integral_a^b pi(x, u+ alpha eta, u' + alpha eta') dif x  $

посмотрим это как на функцию от $alpha$:

$ J_1 (u_alpha) := Phi(alpha) $

первая вариация функционала:

$ diff J_1 (u) = lr((diff Phi) / (diff alpha) |)_(alpha = 0) $

вторая вариация функционала:

$ diff^2 J_1 (u) = lr((diff^2 Phi)/(diff alpha^2)|)_(alpha =0) $

$ diff J_1 (u) = integral_a^b (pi_u eta + pi_(u') eta') dif x $

$ integral_a^b pi_(u') eta' dif x = pi_(u') eta |_a^b - integral_a^b (dif)/(dif x) (pi_u') eta (x) dif x $ 

$ diff J_1 (u) = integral_a^b eta (x) (pi_u - dif/(dif x) (pi_u')) dif x = 0 $

уравнение эйлера:

$ pi_u - dif / (dif x) (pi_u') = 0 $


$ pi = ((diff u)/(diff x))^2 + k u^2 - 2 f u $

$ k(x), f(x), k > 0 $

уравнение эйлера для вон того функционала:

$ - (dif^2 u)/(dif x^2) + k u = f(x) $

\

$ L u = f, wide u in Phi(L) $

$ Phi(L)-$ всюду плотное множество. то есть его замыкание совпадает с ним самим.

$ J_1 (u) = min_(v in Phi (L)) J_1 (v) $

$ J_1(u) = (L u, u) - 2 (f, u) $

$L$ --- линейный, самосопряжённый, положительный:

самосопряжённый:

$ (L u, v) = (u, L v) $

положительный:

$ (L u, u) > 0 $

если решение задачи существует, то оно доставляет минимум.

$ L u_0 = f wide u_alpha = u_0 + alpha eta $

$ eta in Phi(L) $

$ J_1 (v_alpha) = (L (u_0 + alpha eta), u_0 + alpha eta) - 2f, u_0 + alpha eta) =\
= L(u_0, u_0) + 2 alpha (L u_0, eta) + alpha^2 (L eta, eta) - 2(f, u_0) - 2 alpha (f, eta) = \
= J_1 (u_0) + 2alpha(L u_0 - f_1 eta) + alpha^2 (L eta, eta) $

- $ 2alpha(L u_0 - f_1 eta) = 0$

- $ (L eta, eta) > 0$

$ J_1 (v_alpha) > J(u_0) $

доказано. теперь в другую сторону докажем:

$u_0$ --- элемент, который доставляет минимум.

$ J_1 (v_alpha) >= J_1 (u_0)  $

$ v_alpha = u_0 + alpha eta $

$ J_1 (v_alpha) = J_1 (u_0) + 2 alpha (L u_0 - f, eta) + alpha^2 (L eta, eta) $

$ 2 alpha (L u_0 - f, eta) + alpha^2 (L eta, eta) >= 0 $

тут вспоминаем школу и получаем:

$ (L u_0 - f, eta) = 0 $

второй сомножитель --- произвольная функция, значит $L u_0$ некуда деваться --- оно равно нулю.

в дальнейшем будем работать с задачей (I):

$ - (dif^2 u)/(dif x^2) + k u = f(x) wide x in [a, b] $

$ u(a) = u(b) = 0 $

задача (II) --- уравнение пуассона:

$ laplace u = (diff^2 u) / (diff x^2) + (diff^2 u)/(diff y^2) = -f (x, y) wide (x, y) in Omega  $

$ u |_Gamma = 0 $

$ Omega = (a, b) times (c, d) $

$ Omega = Omega + Gamma $

введём ещё парочку пространств:

$U_1$ --- функции с непрерывными производными до второго порядка включительно и с нулевыми граничными условиями: $u(a) = u(b) = 0$.

$U_2$ --- функции с непрерывными производными до второго порядка включительно и $u|_Gamma = 0$.

теперь обратимся к вариационным производным.

$ J_1 (u) = integral_a^b (((diff u)/(diff x))^2 + k u^2 - alpha f u ) dif x $

$ J_2 (u) = integral.double_Omega [((diff u)/(diff x))^2 + ((diff u)/(diff y))^2 - 2 f u] dif x dif y $

пространство соболева:

$ attach(W, t:0, tr: 1, br: 2) [a, b] $

$ norm(u)_attach(W, br: 2, tr: 1, t: 0) = (integral_a^b [u^2 + ((diff u)/(diff x))^2] dif x)^(1/2) $

$ norm(u)_(W_2^1 (Omega)) = (integral.double_Omega [u^2 + ((diff u)/(diff x))^2 + ((diff u)/(diff y))^2 dif x dif y])^(1/2) $

$ J_1 (u) = min_(v in W_2^1 [a, b]) J_1 (v) $

$ J_2 (u) = min_(v in W_2^1 (Omega)) J_2 (v) $

#align(right)[`2025-04-01`]

== метод ритца

строится минимизирующая последовательность

$ mu = inf J (u) $

$u_n$ называется минимизирующей, если $lim_(n->oo) J(u_n) = mu$

классический метод ритца заключается в выборе $phi_i$, $i = 1, dots, n$, удовлетворяющих следующим условиям:

+ $phi_i in H_A$ (энергетическое пространство, в нашем случае пространство соболева)

+ $forall n space phi_i - $ линейно независимы

+ ${phi_i}$ полна в $H_A$

$ phi_1^((n)), phi_2^((n)), dots, phi_n^((n)) wide V_n $

полнота:

$ forall u in H_A and forall epsilon > 0 space exists N, space u_n = sum_(i=1)^n a_i phi_i : norm(u - u_n)_H_A < epsilon  $

$ u_n = sum_(i=1)^n a_i^((n)) phi_i^((n)) $

$ J(u_n) = (A u_n, u_n) - 2 (f, u_n) = (sum_(i=1)^n A phi_i^((n)) a_i^((n)), sum_(p=1)^n a_p^((n)) phi_p^((n))) - 2 (f, sum_(p=1)^n a_p^((n)) phi_p^((n))) = \
= sum_(i,p=1)^n (A phi_i^((n)), phi_p^((n))) a_i^((n)) a_p^((n)) - 2 sum_(p=1)^n a_p^((n)) (f, phi_p^((n))) $

такое условие:

$ (diff J (u_n)) / (diff a_i^((n))) = 0, quad i = 1, dots, n $

$ (diff J (u_n)) / (diff a_i^((n))) = 2 sum_(p=1)^n (A phi_i^((n)), phi_p^((n))) a_p^((n)) - 2 (f, phi_p^((n))), quad i = 1, dots, n $

получили слау относительно коэффициентов $a$:

$ sum_(p=1)^n) (A phi_i^((n)), phi_p^((n))) a_p^((n)) = (f, phi_i^((n))), quad i = 1, dots, n $

определитель грамма:

$ {(A phi_i^((n)), phi_p^((n)))} $

он всегда отличен от нуля, значит система имеет единственное решение.

находим коэффициенты $a_i$ и получаем решение в аналитическом виде:

$ u_n = sum_(i=1)^n a_i^((n)) phi_i^((n)) $

== метод галёркина (бубнова-галёркина)

это проекционный метод.

мы решаем то же самое уравнение:

$ A u = f $

вводится слабая форма этого уравнения:

$ (A u, v) = (f, v), wide v in H_A $

из этого условия ортогональности ищутся коэффициенты $a_i$:

$ (A u_n - f, phi_i) = 0, space i = 1, dots, n $

a.k.a. метод конечных элементов (МКЭ).

в качестве элементов базиса используются локальные сплайны.


функция называется финитной, если она равна нулю, кроме конечного интервала.

аспекты применения метода:

+  нужно осуществить некое разбиение $T_n$ области $overline(Omega)$ на конечное число подобластей $K$. эти подобласти и называются конечными элементами.

  + $overline(Omega) = union.big_(K in T_n) K$

  + $K in T_n$ --- конечные элементы не вырождаются

  + соседние конечные элементы не перекрываются

+ строится конечномерное подпространство, чтобы на каждой подобласти выбранного разбиения базисные функции $phi_i$ должны быть многочленами некой степени не выше заданной.

+ в заданном конечномерном подпространстве должен существовать по крайней мере один базис из функций с минимальными носителями.

посмотрим как работает этот метод на конкретной задаче:

$ u in W_2^1 [a, b] $

$ J(u) = inf_(v in W_2^1[a,b]) J(v) $

$ J(v) = integral_a^b (v')^2 dif x - 2 integral_a^b f v dif x $

$ Delta: x_i = a + i h, wide h = (b-a)/N  $

возьмём пространство сплайнов первой степени с однородными краевыми условиями (так как мы работаем в пространстве соболева):

$ V_n wide n = N - 1 $

$ V_(N-1) $

$ phi(t) = cases(
  1 + t comma space t in [-1, 0],
  1 - t comma space t in [0, 1],
  0 comma space t in.not [-1, 1]
) $

#figure(image("image.png", width: 30%))

$ phi_i^((N-1)) = phi((x-x_i)/h), space i = 1, dots, N $

согласно методу ритца мы ищем решение:

$ u_(N-1) = sum_(i=1)^(N-1) v_i phi_i^((N-1))(x) $

$ v_i = "const" $

если посчитать в точке $x = x_i$

$ v_i = u_(N-1) (x_i) $

$ A = -dif^2/(dif x^2 ) $

$ (A phi_i^((N-1)), phi_p^((N-1)))  = (-dif^2 / (dif x^2) phi_i^((N-1)), phi_p^((N-1))) = integral_a^b (dif phi_i^((N-1)))/(dif x) (dif phi_p^((N-1)))/(dif x) dif x = \
= cases(
  2/h comma space i = p,
  -1/h comma space i = p plus.minus 1,
  0 comma space abs(i-p) > 1
) $

$ 1/h (-v_(i-1) + 2v_i - v_(i+1)) = h g_i $

$ cases(
    - (v_(i-1) - 2 v_i + v_(i+1))/h^2 = g_i,
    v_0 = v_N = 0
  ) $

$ g_i = 1/h integral_a^b f phi_i^((n-1)) dif x $

`2025-04-08`

== метод коллокации

$ L u = f, wide x in [a, b] $

$ L u |_(x=xi_k) = f(xi_k) $




сплайны шонберга или кубические сплайны класса $C^2$:

$ S(x) in C^2 $

будем искать решение в виде кубического сплайна.

задача:

$ L[y(x)] = y''(x) + p(x) y'(x) + q(x) y(x) = r(x), wide x in [a, b] $

$ alpha_1 y(a) + beta_1 y'(a) = gamma_1 $

$ alpha_2 y(b) + beta_2 y'(b) = gamma_2 $

пусть задача имеет единственное решение.

чтобы строить сплайн, нужна сетка:

$ Delta: quad a = x_0 < x_1 < dots < x_N = b $

точки коллокации (или узлы коллокации): $xi_k$.

условие коллокации:

$ L(S(xi_k)) = S''(xi_k) + p(xi_k) S'(xi_k) + q(xi_k) S(xi_k) = r(xi_k), wide xi_k in[a, b] $

$ alpha_1 S(a) + beta_1 S'(a) = gamma_1 $

$ alpha_2 S(b) + beta_2 S'(b) = gamma_2 $

сколько брать узлов? размерность пространства сплайнов $C^2$ составляет $N + 3$. то есть должно быть уравнений $N+3$.

у нас уже есть два условия на концах, поэтому будем брать $(N+1)$ штук:

$ xi_k, space k=0, dots, N $

по-босяцки, узлы коллокации совпадают с узлами сплайна:

$ xi_k = x_k $

если хотим получить схему повышенной точности, то тогда точки могут не совпадать уже.

рассмотрим частный случай, когда первой производной нет $(p(x) equiv 0)$.

$ S(x_i) := u_i $
$ S''(x_i) := M_i $
$ M_i + q_i u_i = r_i, wide i = 0, dots, N $

$ q_i = q(x_i), quad r_i = r(x_i) $

$ mu_i M_(i-1) + 2 M_i + lambda_i M_(i+1) = 6 / (h_(i-1) + h_i) ((u_(i+1) - u_i)/h_i - (u_i - u_(i-1))/h_(i-1)),\ i = 1, dots ,N-1 $

$ mu_i = h_(i-1)/(h_i + h_(i-1)) wide lambda_i =1 - mu_i $

сплайн по моментам записывается следующим образом:

$ S(x) = u_i (1 - t) + u_(i + 1) t - h_i^2 / 6 t (1 - t) [(2-t)M_i + (1+t)M_(i+1)] $

$ h_i = x_(i+1) - x_i wide t = (x - x_i)/h_i $

$ S'(x) = (u_(i+1) - u_i)/h_i - h_i/6 [(2 - 6t + 3t^2)M_i + (1 - 3t^2)M_(i+1)] $

$ lambda_i (1 + h_(i-1)^2 / 6 q_(i-1))u_(i-1) - (1 - (h_i h_(i-1))/3 q_i) u_i + mu_i (1 + h_i^2 / 6 + q_(i+1)) u_(i+1) = \
= (h_(i-1) h_i)/6 (mu_i r_(i-1) + 2 r_i + lambda_i r_(i+1)), quad i = 1, dots ,N - 1
 $

$ alpha_1 S(x_0) + beta_1 S'(x_0) = gamma_0 $

потребуем диагональное преобладание:

$ abs(1 - (h_i h_(i-1))/3 q_i) - lambda_i abs(1 + h_(i-1)^2 / 6 q_(i-1)) -mu_i abs(1 + h_i^2 / 6 + q_(i+1)) > 0 $

$ h_(i-1)^2 max {abs(q_(i-1)), abs(q_i)} <= 6, quad i = 1, dots, N $

$ q(x) <= q < 0 $

$ beta_1 <= 0 wide beta_2, a_j >= 0 $

$ abs(a_i) + abs(b_i) != 0, quad i = 1, 2 $

условие можно достичь, пошаманив с параметров $h$.

а если представить, что $p(x) equiv.not 0$, то... заебёмся, смысла нет этим заниматься.

\

теорема о сходимости, общая.

пусть $p(x) equiv 0$ 

$ y(x) in C^2 W_(Delta, oo)^4 [a, b] $

$ norm(S(x) - y(x))_C = O(overline(h)^2), quad overline(h)=max_i h_i $

точное решение на всём отрезке принадлежит классу це 2:

$ y(x) in C^2 [a, b] $

а внутри подотрезочка:

$ y(x) in W_oo^4 [x_i, x_(i+1)] $

"ок".

$ abs(S(x) - S_c (x)) + abs(S_c (x) - y(x)) <= "оценки" $

$ O(overline(h)^4) $

`2025-04-15`

$ L [y(x)] = y'' (x) + p(x) y'(x) + q(x) y(x) = r(x), quad x in[a,b] $

мы рассматривали $p(x) equiv 0 $, теперь рассмотрим общий случай.

B-сплайны (сокращение от "базисный" сплайн):

$ S(x) = sum_(i=-1)^(N+1) b_i B_i (x) $

сетка для построения сплайна:

$ Delta: x_0 < x_1 < ... < x_N $


$ B_i (x) = 1/6 cases(
  0 comma& x < x_(i-2),
  t^3 comma& x_(i-2) <= x <= x_(i-1),
  1 + 3 t + 3 t^2 (1 - t) comma& x_(i-1) <= x <= x_i,
  1 + 3(1-t) + 3t^2 (1-t)^2 comma quad& x_i <= x <= x_(i+1),
  (1-t)^3 comma& x_(i+1) <= x <= x_(i+1),
  0 comma& x > x_(i+1) 
) $

$ t_i = (x - x_i) / h $

$ sum_(i-1)^(N+1) b_i B''_i (x) + p(x) sum_(i-1)^(N+1) b_i B'_i (x) + q(x) + sum_(i-1)^(N+1) b_i B_i (x) = r(x) $

подставляем в точке $x_k$:

$ sum_(i-1)^(N+1) b_i B''_i (x_k) + p(x) sum_(i-1)^(N+1) b_i B'_i (x_k) + q(x_k) sum_(i-1)^(N+1) b_i B_i (x_k) = r(x_k) $

$ sum_(i=k-1)^(k+1) b_i [B''_i (x_k) + p(x_k) B'_i (x_k) + q(x_k) B_i (x_k)] = r(x_k) $

получится трёхдиагональная матрица с мусором в начале и конце. нужно будет исключить $b_(N+1), b_(-1)$.

условия диагонального преобладания:

$ 1 - 1/2 p_i h_i + 1/6 q_i h^2 >= 0 \
  1 + 1/2 p_i h_(i-1) + 1/6 q_i h_(i-1)^2 >= 0 $

условие простое. чтобы его достичь, надо просто взять достаточно маленький шаг.

\

$ (f_(i-1) - 2f_i + f_(i+1))/h^2 = f''_i + O(h^2) $

если потянуть, то:

$ (f_(i-1) - 2f_i + f_(i+1))/h^2 = f''_i + h^2 / 12 f''''_i + O(h^4) $

момент сплайна:

$ M_i = f''_i + O(h^2) $

$ M_i = f''_i - h^2 / 12 f''''_i + O(h^4) $

полусумма:

$ 1/2 (M_i + (f_(i-1) -2f_i + f_(i+1))/h^2) = f''_i + O(h^4) $

$ (M_(i-1) - 2 M_i + M_(i+1)) / h^2 = f''''_i + O(h^4) $

== основные свойства метода сплайн-коллокации

- одинаковая эффективность как на равномерных, так и на неравномерных сетках. эффективность значит простота, что можно привести к трёхдиагональной матрице.
- высокая точность аппроксимации первой производной
- простота построения схем повышенной точности. в том числе для уравнений с переменными коэффициентами
- решение и его производные можно вычислять в любых точках области

$ b_i = f_i + O(h^2) $

можно сдавать второй коллок.

= третья часть