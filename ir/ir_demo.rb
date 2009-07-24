def fib(a)
  if a < 2
    a
  else
    fib(a - 1) + fib(a - 2)
  end
end

class Bar
  def foo(a)
    puts a
  end
end