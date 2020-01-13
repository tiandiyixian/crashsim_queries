/**
 * @name aoc_post_increment_decrement.ql
 * @kind problem
 * @problem.severity warning
 * @id cpp/aoc/post_increment_decrement
 *
 * Find all uses of a postfix increment or decrement operators that appears inside a comparison or assignment.
 */

import cpp

from PostfixCrementOperation pco, Expr e
where (pco instanceof PostfixDecrExpr or pco instanceof PostfixIncrExpr) and
exists (Expr ex | (ex instanceof AssignExpr or ex instanceof RelationalOperation or ex instanceof EqualityOperation) and
  ex.getChild(_)=pco and ex=e)
select e," :aoc_post_increment_decrement"
