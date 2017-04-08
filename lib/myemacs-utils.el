(defun flatten (mylist)
  "Flattens a list recusively for example: 
  (flatten '(foo (bar (bat baz) cool) boo)) -> '(foo bar bat baz cool boo)"
  (cond
   ((null mylist) nil)
   ((atom mylist) (list mylist))
   (t
    (append (flatten (car mylist)) (flatten (cdr mylist))))))








