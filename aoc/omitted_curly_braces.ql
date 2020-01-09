/**
 * @name aoc_omitted_curly_braces.ql
 * @kind problem
 * @problem.severity warning
 * @id cpp/aoc/omitted_curly_braces
 *
 * Find all the if and for statements that don't explicitly define a block (using curly braces) for the body of
 * the if or for statement.  Also don't match these statements if the single statement (in the body) is a break, 
 * return or continue statement. For the "if statement" we allow a single line body if there is an 
 * accompanying else statement - since if an additional line is accidentally added to the body the compiler will 
 * flag the "else" statement as an error.
 *
 * We restrict the results to those in which the one-line body of the if or for statement starts on the next line 
  * as this is more likely to cause buggy code since anyone making modifications to the code body in question would 
 * likely need to add curly braces if an additional statement was added.
 */

import cpp

class IfOrForStmt extends Stmt{
	IfOrForStmt(){
      this instanceof IfStmt or this instanceof ForStmt
	}
}

class BreakOrReturnOrContinue extends Stmt{
  	BreakOrReturnOrContinue(){
      this instanceof ReturnStmt or this instanceof BreakStmt or this instanceof ContinueStmt
  }
}

from IfOrForStmt iofs
where (iofs instanceof IfStmt and 
  			not(iofs.(IfStmt).getThen() instanceof Block) and
			not(iofs.(IfStmt).getThen() instanceof BreakOrReturnOrContinue) and
			not(iofs.(IfStmt).hasElse()) and
			iofs.(IfStmt).getThen().getLocation().getStartLine()>iofs.(IfStmt).getLocation().getStartLine()) 
  				or
	  (iofs instanceof ForStmt and 
        	not(iofs.(ForStmt).getStmt() instanceof Block) and
			not(iofs.(ForStmt).getStmt() instanceof BreakOrReturnOrContinue) and
        	iofs.(ForStmt).getStmt().getLocation().getStartLine()>iofs.(ForStmt).getLocation().getStartLine())
select iofs,"aoc_omitted_curly_braces"