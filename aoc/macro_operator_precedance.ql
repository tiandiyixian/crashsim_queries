/**
 * @name aoc_macro_operator_precedence.ql
 * @kind problem
 * @problem.severity warning
 * @id cpp/aoc/operator_precedence
 *
 * Find all macro invocations that involve macros being expanded into a binary expression. 
 * The macro in question should not already be parenthesized, contain a quote or a semicolon (macro is likely a statement)
 * and must contain one of the following mathematical operators: -+&|*^><%/
 */

import cpp

from MacroInvocation mi, string s, Element e
where s=mi.getMacro().getBody() and s.regexpMatch(".*[-+&|*/^><%].*") and not s.matches("%(%)%") and 
not s.matches("%\"%\"%") and not s.matches("%;%")and e instanceof BinaryOperation and mi.getAnAffectedElement()=e
select e," :aoc_macro_operator_precedence"