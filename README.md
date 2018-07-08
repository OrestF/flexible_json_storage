# Flexible json storage v0.1

Store and retrieve your JSON examples via real http requests

## API

### Single data example

###### request
```json
{ "content": 
   {
        "author": "Marijn Haverbeke",
        "description": "JavaScript lies at the heart of almost every modern web application, from social apps to the newest browser-based games. Though simple for beginners to pick up and play with, JavaScript is a flexible, complex language that you can use to build full-scale applications.",
        "isbn": "9781593275846",
        "pages": 472,
        "published": "2014-12-14T00:00:00.000Z",
        "publisher": "No Starch Press",
        "subtitle": "A Modern Introduction to Programming",
        "title": "Eloquent JavaScript, Second Edition",
        "website": "http://eloquentjavascript.net/"
    }
}
```
###### response

```json
{
    "url": "http://localhost:3000/api/bins/units/5b41fc27eeefcc6d92927540"
}
```

Use this url to retrieve your data 

### Multiple data example (collection)

###### request

```json
 {"content":
 [
    {
      "isbn": "9781593275846",
      "title": "Eloquent JavaScript, Second Edition",
      "subtitle": "A Modern Introduction to Programming",
      "author": "Marijn Haverbeke",
      "published": "2014-12-14T00:00:00.000Z",
      "publisher": "No Starch Press",
      "pages": 472,
      "description": "JavaScript lies at the heart of almost every modern web application, from social apps to the newest browser-based games. Though simple for beginners to pick up and play with, JavaScript is a flexible, complex language that you can use to build full-scale applications.",
      "website": "http://eloquentjavascript.net/"
    },
    {
      "isbn": "9781449331818",
      "title": "Learning JavaScript Design Patterns",
      "subtitle": "A JavaScript and jQuery Developer's Guide",
      "author": "Addy Osmani",
      "published": "2012-07-01T00:00:00.000Z",
      "publisher": "O'Reilly Media",
      "pages": 254,
      "description": "With Learning JavaScript Design Patterns, you'll learn how to write beautiful, structured, and maintainable JavaScript by applying classical and modern design patterns to the language. If you want to keep your code efficient, more manageable, and up-to-date with the latest best practices, this book is for you.",
      "website": "http://www.addyosmani.com/resources/essentialjsdesignpatterns/book/"
    },
    {
      "isbn": "9781449365035",
      "title": "Speaking JavaScript",
      "subtitle": "An In-Depth Guide for Programmers",
      "author": "Axel Rauschmayer",
      "published": "2014-02-01T00:00:00.000Z",
      "publisher": "O'Reilly Media",
      "pages": 460,
      "description": "Like it or not, JavaScript is everywhere these days-from browser to server to mobile-and now you, too, need to learn the language or dive deeper than you have. This concise book guides you into and through JavaScript, written by a veteran programmer who once found himself in the same position.",
      "website": "http://speakingjs.com/"
    }
  ]
 }
```

###### response

```json
{
    "url": "http://localhost:3000/api/bins/collections/5b41e4b9eeefcc20e8f0f8b2"
}
```

#### Filters

You can use filters while retrieving collections

Example

* where pages more than 400

###### request

```
http://localhost:3000/api/bins/collections/5b41e4b9eeefcc20e8f0f8b2?q[pages]=>400
```

###### response
```json
 [
    {
      "isbn": "9781593275846",
      "title": "Eloquent JavaScript, Second Edition",
      "subtitle": "A Modern Introduction to Programming",
      "author": "Marijn Haverbeke",
      "published": "2014-12-14T00:00:00.000Z",
      "publisher": "No Starch Press",
      "pages": 472,
      "description": "JavaScript lies at the heart of almost every modern web application, from social apps to the newest browser-based games. Though simple for beginners to pick up and play with, JavaScript is a flexible, complex language that you can use to build full-scale applications.",
      "website": "http://eloquentjavascript.net/"
    },

    {
      "isbn": "9781449365035",
      "title": "Speaking JavaScript",
      "subtitle": "An In-Depth Guide for Programmers",
      "author": "Axel Rauschmayer",
      "published": "2014-02-01T00:00:00.000Z",
      "publisher": "O'Reilly Media",
      "pages": 460,
      "description": "Like it or not, JavaScript is everywhere these days-from browser to server to mobile-and now you, too, need to learn the language or dive deeper than you have. This concise book guides you into and through JavaScript, written by a veteran programmer who once found himself in the same position.",
      "website": "http://speakingjs.com/"
    }
  ]
 
```

#### List of possible filters
```
    =    : equals            ?q[name]=John (case sensitive) 
    =>   : greater than      ?q[pages]=>300 
    =<   : less than         ?q[pages]=<300
    =>=  : equals or greater ?q[pages]=>=400
    =<=  : equals or less    ?q[pages]=<=200
    =<>  : match             ?q[name]=ohn (match: John, Johnsons..)
```