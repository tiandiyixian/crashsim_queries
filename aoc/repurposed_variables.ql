/**
 * @name aoc_repurposed_variables.ql
 * @kind problem
 * @problem.severity warning
 * @id cpp/aoc/repurposed_variables
 *
 * Find all assignments where argc and argv are on the left-hand-side (being assigned a value).
 */

import cpp

from Assignment a
where a.getLValue().toString()="argc" or a.getLValue().toString()="argv"
select a,"aoc_repurposed_variables"