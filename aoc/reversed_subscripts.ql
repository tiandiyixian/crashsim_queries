/**
 * @name aoc_reversed_subscripts.ql
 * @kind problem
 * @problem.severity warning
 * @id cpp/aoc/reversed_subscripts
 *
 * Find all uses of array expressions where the index is placed before the array, for example - 1["abc"], this is equivalent to "abc"[1].
 */

import cpp

from ArrayExpr ae
where ae.getChild(0)=ae.getArrayOffset()
select ae," :aoc_reversed_subscripts"