/**
 * @name aoc_change_of_literal_encoding
 * @kind problem
 * @problem.severity warning
 * @id cpp/aoc/preprocessor_in_statement
 *
 * Find all functions that have a octal or hex literal somewhere in at least one of its the arguments
 */

import cpp

class HexOrOctLiteral extends Literal{
	HexOrOctLiteral(){
      (this instanceof HexLiteral) or (this instanceof OctalLiteral)  
	}
}

class FuncionCallWithHexOrOctArgument extends FunctionCall{
  	FuncionCallWithHexOrOctArgument(){
      exists (HexOrOctLiteral lit | this.getAnArgumentSubExpr(_)=lit)
  }
}

from FuncionCallWithHexOrOctArgument fc
select fc, "aoc_change_of_literal_encoding"
