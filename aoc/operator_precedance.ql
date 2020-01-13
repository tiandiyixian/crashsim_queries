/**
 * @name aoc_operator_precedence.ql
 * @kind problem
 * @problem.severity warning
 * @id cpp/aoc/operator_precedence
 *
 * Find all non-parenthesized, non arithmetic binary expressions that have at least one binary-sub expression on 
 * either the left or right of the binary operator. Also eliminate expressions that consist entirely 
 * of only a single operator (e.g. && logical operator). For example we are looking for expressions similar to  1 || 2 && 3 
 */

import cpp

from BinaryOperation bo
where exists (BinaryOperation b | (bo.getLeftOperand()=b or bo.getRightOperand()=b) and (not b instanceof BinaryArithmeticOperation) and
  				not exists (ParenthesisExpr pe1, ParenthesisExpr pe2 | b.getLeftOperand()=pe1 and b.getRightOperand()=pe2) and
				bo.getOperator()!=b.getOperator())
select bo," :aoc_operator_precedence"