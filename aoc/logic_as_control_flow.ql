/**
 * @name aoc_logic_as_control_flow.ql
 * @kind problem
 * @problem.severity warning
 * @id cpp/aoc/logic_as_control_flow
 *
 * Find all logical expressions (&&, ||) where the righthand side of the expression is a function call.
 */

import cpp

from BinaryLogicalOperation bl, FunctionCall fc
where (bl instanceof LogicalAndExpr or bl instanceof LogicalOrExpr) and
exists (Expr ex | bl.getRightOperand().getChild(_)=ex and fc=ex)
select bl, " :aoc_logic_as_control_flow"