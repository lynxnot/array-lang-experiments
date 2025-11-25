⍝ AOC 2024 - day 1

infile ← './aoc_d1-input.txt'
input ← (⎕CSV⍠'Separator' ' ')infile''(2 0 0 2)

⍝ sort each column indipendently, output is transposed
colsort ← (⊂∘⍋⌷⊢)⍤1⍉

⍝ sum of the absolute distances between samples
⍝ after sorting each column indipendently
solve1 ← +/(|⍤-⌿colsort)   
⎕ ← solve1 input

⍝ get a ref to each column
left  ← ⊣/input
right ← ⊢/input

⍝ filter right keeping only elements present in left
fc2 ← right/⍨ right∊left

⍝ use the key operator to determine frequencies of each
⍝ element
⎕ ← solve2 ← +/{⍺×≢⍵}⌸fc2

