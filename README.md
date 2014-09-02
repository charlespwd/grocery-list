# Grocery-list
![Build Status](https://travis-ci.org/charlespwd/grocery-list.svg?branch=master)
[![Coverage
Status](https://coveralls.io/repos/charlespwd/grocery-list/badge.png)](https://coveralls.io/r/charlespwd/grocery-list)

Turn your json, csv, md, or strings into grocery lists that you can
then search for.

## Example usage
```ruby
require 'grocery_list'

GroceryList.search_all('spam, eggs, bacon')
#=> opens 1 tab/item on iga.net sorted by price ascending
```

## Installation
```bash
gem install grocery_list
```

## Formats
### Strings
  Strings are expected to be split by commas.

```ruby
  "spam, egg, bacon, maple syrup" #=> valid
  "spam, egg, \nbacon, maple syrup" #=> invalid
```

### JSON
  Just pass in an array of strings and you're golden.

```ruby
  '["spam", "egg", "bacon", "maple syrup"]'
```

### Markdown File
  Every list items identified by a ` *` is considered an item. Every
line which doesn't respect this isn't.

```markdown
# Grocery List
 * Spam
 * Eggs
 * Bacon
 * Maple syrup

Anything else isn't considered an item.
```

## To do
  * [ ] Implement more searchers? I have IGA.net working in Montreal;
Could be extended?

## License
MIT
