/**
 * @name anoms_rename_system_call.ql
 * @kind problem
 * @problem.severity warning
 * @id cpp/anoms/rename_system_call
 *
 * Find all rename system calls where the first argument comes from a user-tainted source.
 * The renameat and renameat2 system calls are included in the search but for these system
 * calls we also search for the possiblity that the file descriptor could be from a user-tainted source.
 * 
 *  rename system call URL: http://man7.org/linux/man-pages/man2/rename.2.html
 **/

import cpp
import semmle.code.cpp.security.Security
import semmle.code.cpp.security.TaintTracking

class RenameSystemCall extends FunctionCall{
    RenameSystemCall(){
        this.getTarget().getQualifiedName() = "rename"
    }
}

class RenameatSystemCall extends FunctionCall{
    RenameatSystemCall(){
		this.getTarget().getQualifiedName() = "renameat" 
      	or
        this.getTarget().getQualifiedName() = "renameat2"
    }
}

from Expr taintedArg, Expr taintSource, string taintCause, string globalVar
where ( 
  		exists (RenameSystemCall rsc | rsc.getArgument(0)=taintedArg) 
  		or 
  	    exists (RenameatSystemCall rsca | rsca.getArgument(0)=taintedArg or rsca.getArgument(1)=taintedArg)
       ) 	
		and
			isUserInput(taintSource, taintCause) 
		and
			taintedIncludingGlobalVars(taintSource, taintedArg, globalVar)
select taintedArg,"tainted by "+taintCause+" :anoms_rename_system_call"