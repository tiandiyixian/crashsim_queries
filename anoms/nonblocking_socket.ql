/**
 * @name anoms_nonblocking_socket.ql
 * @kind problem
 * @problem.severity warning
 * @id cpp/anoms/nonblocking_socket
 *
 * The following query finds fcntl function calls corresponding to socket that is set to non-blocking
 * using the O_NONBLOCK macro as the third argument to fcntl.
 **/

import cpp
import semmle.code.cpp.dataflow.DataFlow
  
class SocketCreation extends FunctionCall{
  SocketCreation(){
    this.getTarget().hasGlobalName("socket")
  }
}
 
class FcntlFunctionCall extends FunctionCall{
   FcntlFunctionCall(){
     exists (MacroInvocation m | m.getMacroName()="O_NONBLOCK" and 
    this.getTarget().hasGlobalName("fcntl") and this.getArgument(2).getLocation().subsumes(m.getLocation()))
 
  }
}

from FcntlFunctionCall ffc, SocketCreation sc
where DataFlow::localFlow(DataFlow::exprNode(sc), DataFlow::exprNode(ffc.getArgument(0)))
select ffc,"anoms_nonblocking_socket"