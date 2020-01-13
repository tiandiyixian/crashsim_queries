/**
 * @name fcntl_on_socket.ql
 * @kind problem
 * @problem.severity warning
 * @id cpp/anoms/fcntl_on_socket
 *
 * The following query finds fcntl function calls corresponding to socket. This
 * is based on the semmle.code.cpp.pointsto.PointsTo library and DescriptorNeverClosed.ql query
 * both are included as part of the codeql library.
 *
 *  http://man7.org/linux/man-pages/man2/fcntl.2.html
 **/


import cpp
import semmle.code.cpp.pointsto.PointsTo

predicate fcntlOnSocket(Expr e){
  exists (FunctionCall fc | fc.getTarget().hasGlobalOrStdName("fcntl")
    and fc.getArgument(0)=e
  )
}

class FcntlExpr extends PointsToExpr{
  FcntlExpr(){ fcntlOnSocket(this) }
  
  override predicate interesting(){fcntlOnSocket(this)}
}
  
class SocketCreation extends FunctionCall{
  SocketCreation(){
    this.getTarget().hasGlobalName("socket")
  }
}
 
from Expr alloc, SocketCreation sc
where sc=alloc and exists (FcntlExpr fe | fe.pointsTo()=alloc)
select alloc,"fcntl called on this socket :anoms_fcntl_on_socket"