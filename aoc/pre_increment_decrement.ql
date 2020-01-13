/**
 * @name aoc_pre_increment_decrement.ql
 * @kind problem
 * @problem.severity warning
 * @id cpp/aoc/pre_increment_decrement
 *
 * Find all uses of a prefix increment or decrement that appears inside a comparison or assignment.  
 */

import cpp

from PrefixCrementOperation pco, Expr e
where (pco instanceof PrefixDecrExpr or pco instanceof PrefixIncrExpr) and
exists (Expr ex | (ex instanceof AssignExpr or ex instanceof RelationalOperation or ex instanceof EqualityOperation) and
  ex.getChild(_)=pco and ex=e)
select e," :aoc_pre_increment_decrement"