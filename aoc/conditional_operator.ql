/**
 * @name aoc_conditional_operator.ql
 * @kind problem
 * @problem.severity warning
 * @id cpp/aoc/conditional_operator
 *
 * Find all uses of the conditional operator that are not part of an assert macro and that appear on the righthand side of an assignment
 * expression.
 */

import cpp

from ConditionalExpr ce, AssignExpr ae
where not (exists (MacroInvocation mi | ce.isAffectedByMacro() and mi.getAnAffectedElement()=ce and mi.getMacroName().toLowerCase().matches("%assert%"))) 
  and ae.getRValue()=ce
select ce," :aoc_conditional_operator"