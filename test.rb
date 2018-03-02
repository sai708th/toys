
def sayHello
    yield
    yield
end

sayHello { puts "hello world!" }

"hello".each_char { |c| puts c }
