# Reox (Re(d+b)ox) 

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

or 
Use it for whole code 

```ruby
require 'reox'

Reox.record! 

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
