/**
 * @name anoms_rename_system_call.ql
 * @kind problem
 * @problem.severity warning
 * @id cpp/anoms/rename_system_call
 *
 * Find all the rename system calls (rename, renameat, renameat2) where if the first argument comes from a value generated outside the function 
 * (which could be a source of variable tainting):
 **/

import cpp
import semmle.code.cpp.dataflow.DataFlow
 
class RenameFunctionCall extends FunctionCall{
    RenameFunctionCall(){
        this.getTarget().getQualifiedName() = "rename" or
        this.getTarget().getQualifiedName() = "renameat" or
        this.getTarget().getQualifiedName() = "renameat2"
    }
}
 
from RenameFunctionCall call, Parameter p
where DataFlow::localFlow(DataFlow::parameterNode(p), DataFlow::exprNode(call.getArgument(0)))
select p,"anoms_rename_system_call"