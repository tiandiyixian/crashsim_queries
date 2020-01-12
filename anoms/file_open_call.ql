/**
 * @name anoms_file_open_call.ql
 * @kind problem
 * @problem.severity warning
 * @id cpp/anoms/file_open_call.ql
 *
 * Find all open, openat or creat system calls where the pathname argument comes from a user-tainted source.
 * 
 * The fopen and freopen C library function calls are also checked.
 * 
 *  rename system call URL: http://man7.org/linux/man-pages/man2/open.2.html
 **/

import cpp
import semmle.code.cpp.security.Security
import semmle.code.cpp.security.TaintTracking

class OpenSystemCall extends Function{
	OpenSystemCall(){
        this.hasGlobalName("open")
		or
		this.hasGlobalName("creat")
    }
}

class OpenatSystemCall extends Function{
    OpenatSystemCall(){
		this.hasGlobalName("openat") 
    }
}

class FopenLibraryCall extends Function{
	FopenLibraryCall(){
		this.hasGlobalOrStdName("fopen")
		or
		this.hasGlobalOrStdName("freopen")
	}
}

from Expr taintedArg, Expr taintSource, string taintCause, string globalVar, FunctionCall fc
where
  		( 
			exists (OpenSystemCall osc | fc.getTarget()=osc and fc.getArgument(0)=taintedArg)
			or 
			exists (OpenatSystemCall oasc | fc.getTarget()=oasc and fc.getArgument(1)=taintedArg)
			or
			exists (FopenLibraryCall folc | fc.getTarget()=folc and fc.getArgument(0)=taintedArg)
        ) 	
		and
			isUserInput(taintSource, taintCause) 
		and
			taintedIncludingGlobalVars(taintSource, taintedArg, globalVar)
select taintedArg,"tainted by "+taintCause+" :anoms_file_open_call"