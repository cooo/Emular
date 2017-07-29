class Stack
  STACK_SIZE = 16

  attr_reader :sp, :stack
  
  def initialize
    @stack = Array.new(STACK_SIZE, 0)
    @sp = 0
  end

  def push(address)
    stack[@sp] = address
    @sp += 1
  end

  def pop
    @sp -= 1
    address = stack[@sp]
    stack[@sp] = 0
    address
  end

  def to_s
    "sp: #{@sp}  stack: #{@stack}"
  end

end
