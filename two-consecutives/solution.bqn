#!/usr/bin/env bqn

# SRM 727 - problem 1
# A string is beautiful if there are two consecutive equal characters,
# i.e. "KEEP", "YYYYY", "TTORR" are all beautiful.
# "A", "GH", and "ABCABCBAX" are not beautiful.
#
# given a string S, find if by dropping a single character it can be beautified

# true is 0-pos to avoid a NOT(¬)
res ← ⟨"Possible", "Impossible"⟩ 

#in ← "ABCABCBAX"
#in ← "ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWX"
#in ← "ABCDEFGHIJKLMNOPQRSTUVWXYZYBCDEFGHIJKLMNOPQRSTUVWX"
# does not work if ≠in is 1 
# in ← "A"

# define the set of masks to drop a single character
# first and last chars have no influence
Mask ← (<˘1↓((1-˜⊢)↑(¬∘=⌜˜∘↕⊢)))≠

# use replicate to filter with the set of masks
# then use the double shift trick (1«»⊸≠) to check for adjacent equals
# this will mark with a 0 the end of consecutives chars groups
# since its a 0 we can simply double reduce with multiply
Solve ←  res⊑˜(×´((×´1«»⊸≠)¨/˜⚇1⟜Mask))
#Solve in

# thoughts and code self-review after digestion
#
# the previous solution is convoluted and shows how my reasoning is very for-loopy. 
# Furthermore I have ignored the most interesting part of the algorithm until the very end, 
# that is how to determine if we have two consecutive chars -> (1«»⊸≠),
# which i have found on [bqncrate](https://mlochbaum.github.io/bqncrate/)
#
# another point is that Mask is returning an array of arrays (<˘) this is
# because i was really confused by the difference between a matrix and an array of arrays,
# and how to work with a matrix. also being used to the map function in other languages, 
# I have brute-forced a way to use each (¨) in the solve function, which in my mind was the correct approach.
# Also I could not figure out what was the depth modifier really doing, thus the brute-forcing.
#
# Adam explanation in this [video](https://youtu.be/S9cfN9oVI5I?si=TWyHnpGsPdNuzH0n0) is actually fantastic
# and cleared out so many doubts and misunderstandings about the depth/rank modifier, axes, etc...
# I would have to experiment more with the idea of trailing and leading axes and, in particular, verify if there
# are any differences between APL and BQN. 
# Also I have noticed that some functions seems to apply to columns when they can (at least in APL).
# for instance `Avg ← +⌿÷≢` is defined with replicate-first (⌿) instead of replicate (/), 
# the previous video explains why
#
# On a more ergonomic plan, switching keyboard layout from fr_CH to en_UK, while also typing BQN glyphs 
# with a reference picture showing the en_US layout was kinda frustrating. 
# As the swiss keyboard is really bad for programming in general, i should probably stick to en_UK (or en_US?) for work.
# I rarely write in french/italian anyway...

#------------------------------------------------------------------------------
# so after this self-introspection, lets rewrite the solution with a totally different approach!
#
# also let's use overly long function names for now, this is of course to please java programmers 
# and at the same time justify the use of a one-liner in the final solution

ContainsConsecutives ← ∨´(«=⊢)
ContainsConsecutivesIfDropOne ← ∨´(«=»)
# compared to the previous approach we are reducing with OR (∨) here. It would be interesting to see 
# how `∨´(f=g)` compares to `×´(f≠g)` in terms of performances. is it irrelevant or one is faster than the other?


# fix in case we have less than 2 chars
ContainsConsecutivesIfDropOneAndIsShort ← ∨´('z'⊸«='a'⊸»)
# The usage of bind left allows to convert the dyadic (in this case) functions « and » to monadic,
# by partially applying the scalars 'z' and 'a' respectively. we can then apply 
# the 3-train fork pattern, monadic-dyadic-monadic also known as the phi-combinator.


SolveAgain ← "Impossible"‿"Possible"⊑˜ ∨´∘((«='a'⊸») ∾ («=⊢))

# so in this case we have a phi-combinator or 3-train fork (one with the join, ∾ ) with
# two phi-combinators on each side.
# The OR-reduction is then jotted atop the whole train (see-wid-there? choo-choo-mofos!)
# this is possible because we have a single flat array, which Adam recommends in his [APL-style-guide](https://abrudz.github.io/style/)
# not sure if the original problem was asking to identify simply beautiful string (without the drop one thing)
# but i thought the nested phi's were pretty cool

in ← ⟨"ABCABCBAX", "ABCABCAX", "A"⟩
SolveAgain¨in
# •Show SolveAgain¨in
