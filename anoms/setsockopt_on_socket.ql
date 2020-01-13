/**
 * @name setsockopt_on_socket.ql
 * @kind problem
 * @problem.severity warning
 * @id cpp/anoms/setsockopt_on_socket
 *
 * The following query finds setsockopt function calls corresponding to socket. This
 * is based on the semmle.code.cpp.pointsto.PointsTo library and DescriptorNeverClosed.ql query
 * both are included as part of the codeql library.
 *
 *  http://man7.org/linux/man-pages/man3/setsockopt.3p.html
 **/


import cpp
import semmle.code.cpp.pointsto.PointsTo

predicate setsockoptOnSocket(Expr e){
  exists (FunctionCall fc | fc.getTarget().hasGlobalOrStdName("setsockopt")
    and fc.getArgument(0)=e
  )
}

class SetsockoptExpr extends PointsToExpr{
  SetsockoptExpr(){ setsockoptOnSocket(this) }
  
  override predicate interesting(){setsockoptOnSocket(this)}
}
  
class SocketCreation extends FunctionCall{
  SocketCreation(){
    this.getTarget().hasGlobalName("socket")
  }
}
 
from Expr alloc, SocketCreation sc
where sc=alloc and exists (SetsockoptExpr se| se.pointsTo()=alloc)
select alloc,"setsockopt called on this socket :anoms_setsockopt_on_socket"