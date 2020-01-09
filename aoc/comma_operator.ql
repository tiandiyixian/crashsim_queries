/**
 * @name aoc_comma_operator.ql
 * @kind problem
 * @problem.severity warning
 * @id cpp/aoc/comma_operator
 *
 * Find all assignments where the right hand side is an instance of a comma expression. 
 */

import cpp

from Assignment a
where a.getRValue() instanceof CommaExpr
select a,"aoc_comma_operator"