/**
 * @name aoc_assignment_as_value
 * @kind problem
 * @problem.severity warning
 * @id cpp/aoc/assignment_as_value
 *
 * Find all assignment expressions wherein the right-hand-side of the expression is also an assignment
 */

import cpp

from AssignExpr aeL
where aeL.getRValue() instanceof AssignExpr 
select aeL," :aoc_assignment_as_value"