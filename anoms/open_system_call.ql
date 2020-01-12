/**
 * @name anoms_open_system_call.ql
 * @kind problem
 * @problem.severity warning
 * @id cpp/anoms/open_system_call
 *
 * Find all open or creat system calls where the first argument comes from a user-tainted source.
 * The openat system call is also included in the search but for this system
 * calls we also search for the possiblity that that the file descriptor could be a user-tainted source.
 * 
 *  rename system call URL: http://man7.org/linux/man-pages/man2/open.2.html
 **/

import cpp
import semmle.code.cpp.security.Security
import semmle.code.cpp.security.TaintTracking

class OpenSystemCall extends FunctionCall{
	OpenSystemCall(){
        this.getTarget().getQualifiedName() = "open"
		or
		this.getTarget().getQualifiedName() = "creat"
    }
}

class OpenatSystemCall extends FunctionCall{
    OpenatSystemCall(){
		this.getTarget().getQualifiedName() = "openat" 
    }
}

from Expr taintedArg, Expr taintSource, string taintCause, string globalVar
where ( 
  		exists (OpenSystemCall osc | osc.getArgument(0)=taintedArg) 
  		or 
  	    exists (OpenatSystemCall osca | osca.getArgument(0)=taintedArg or osca.getArgument(1)=taintedArg)
       ) 	
		and
			isUserInput(taintSource, taintCause) 
		and
			taintedIncludingGlobalVars(taintSource, taintedArg, globalVar)
select taintedArg,"tainted by "+taintCause+" :anoms_rename_system_call"