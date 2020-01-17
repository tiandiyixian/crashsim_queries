/**
 * @name aoc_implicit_predicate.ql
 * @kind problem
 * @problem.severity warning
 * @id cpp/aoc/implicit_predicate
 *
 * Finds all expressions used in the conditional part of the control structure 
 * (if, while, switch) wherein the expression is a binary operation and is treated as 
 * an implicit predicate - the expression does not contain an explicit comparison operation - for example, the statement:   if (6 % 3)] 
 */

import cpp

from ControlStructure cs
where not cs.getControllingExpr() instanceof ComparisonOperation
select cs," :aoc_implicit_predicate"
