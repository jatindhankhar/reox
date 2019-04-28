# Reox (Re(d+b)ox) 
![Gem](https://img.shields.io/gem/v/reox.svg) ![GitHub](https://img.shields.io/github/license/jatindhankhar/reox.svg)

Reox is a simple stream logger library.

### Prerequisites

Ruby :gem:


### Installing

Just install the gem
```
gem install reox
```

## Getting Started

Wrap the portion you want to record inside the record block

```ruby
require 'reox'

Reox.record do
  puts "I will be logged :)"
end

puts "I won't be logged"
```

will store it in `output.log` as

```text
This is a test
4556
```

**If you want logs to be verbose**

```ruby
require 'reox'

Reox.record{verbose: true} do
  puts "I will be logged :)"
end

puts "I won't be logged"
```

will store it in `output.log` as

```text
I, [2019-04-28T19:31:29.402618 #9435]  INFO -- tester.rb:5:in `puts': This is a test

I, [2019-04-28T19:31:30.910717 #9435]  INFO -- tester.rb:7:in `puts': 456
```

or Use it for whole code 

```ruby
require 'reox'

Reox.record! # or verbose mode Reox.record!({verbose: true})

puts "Everything will be logged"
puts "Unless we stop it, which is optinal " 

Reox.stop! # Optional to stop recording 

puts "Phew!, I escaped  the logger "

```


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## Acknowledgments

* StackOverflow for the guidance and [intial idea]( https://stackoverflow.com/a/6407200) 
* [PurpleBooth's README Template](https://gist.github.com/PurpleBooth/109311bb0361f32d87a2)
