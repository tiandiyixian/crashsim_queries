/**
 * @name aoc_type_conversion.ql
 * @kind problem
 * @problem.severity warning
 * @id cpp/aoc/implicit_predicate
 *
 * Finds all binary expressions that get explicitely cast from one numeric type to another
 *
 */
import cpp
 
from ArithmeticConversion ac
where not ac.isImplicit() and ac.getExpr() instanceof BinaryOperation
select ac,ac.getSemanticConversionString()+" :aoc_type_conversion" 
