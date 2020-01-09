/**
 * @name aoc_preprocessor_in_statement
 * @kind problem
 * @problem.severity warning
 * @id cpp/aoc/preprocessor_in_statement
 *
 * Find all statements that contain an embedded Macro Definition
 */

import cpp

from Stmt st, Macro m 
where m.getLocation().getStartLine()<=st.getLocation().getEndLine() and
m.getLocation().getStartLine()>=st.getLocation().getStartLine() and st.getFile()=m.getFile()
select st, "aoc_preprocessor_in_statement"
