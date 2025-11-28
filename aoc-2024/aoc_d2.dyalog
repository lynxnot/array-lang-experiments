⍝ AOC 2024 - day 2

infile ← 'aoc_d2-input.txt'

NL ← ⎕UCS 10

raw_data ← ⍪¨⍎¨¨' '(≠⊆⊢)¨NL(≠⊆⊢)⊃⎕NGET infile


⍝ get a 2-windowed subtraction reduction in d
⍝ check if all elems of d are same sign (strictly monotonic)
⍝ check if all abs elems of d are in range 1-3 inclusives
⍝ reduce to count safe reports
⎕ ← solve1 ← +/⊃,/{ (∧⌿(1≤⊢∧3≥⊢)|d) ∧ ∧⌿2=⌿(⊢÷|) d←2-⌿⍵}¨raw_data


