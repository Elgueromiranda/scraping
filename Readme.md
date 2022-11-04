# Scraping Websites

##Summary 

Websites can be great resources with tons of useful information. If you want to save that information, you can visit the website and copy the text, or even save the HTML source. But if a website has its information across hundreds of different links, this is a tedious process. 

Luckily, you're a programmer.

Web scraping is the process of grabbing information from websites automatically. You need two basic things: 

1. A way to get HTML from the internet directly (without having to open a browser). We'll use the **open-uri** module for this.
2. A way to pull information from the HTML. Technically, HTML is just a string, so you could write code with regular expressions to do all your searching, but it would be much easier to use something that understands HTML. We'll use the **nokogiri** gem for this.

###Part 1: Scraping a local HTML file 

#### Save a HTML Page

First, we're going to save a specific post as a plain HTML file for us to practice on. Visit the Hacker News homepage and click through to a specific post.  If you can't find one, use the [A/B Testing Mistakes](http://news.ycombinator.com/item?id=5003980) post. Right click the page and select "view source."  Copy and paste the HTML into Sublime and save the file as **`post.html`**.

#### Playing around with Nokogiri

First, make sure the `nokogiri` gem is installed.  Open your console, run `irb` and enter:

```ruby
require 'nokogiri'
```

If you get an error that means Nokogiri is not installed, install it by running this command:

```text
$ gem install nokogiri
```

Make sure you're in *the same directory as `post.html`*. Then try this from `irb`:

```ruby
doc = Nokogiri::HTML(File.open('post.html'))
```



Here's an example of how you'd write a method that takes a Nokogiri document of a Hacker News thread as input and return an array of commentor usernames:

```ruby
def extract_usernames(doc)
  doc.search('.comhead > a:first-child').map do |element|
    element.inner_text
  end
end
```

The Nokogiri gem creates an object that gives you an easy way to search and grab information out of it using CSS selectors. Spend some time looking at the [Nokogiri documentation about searching an HTML document](http://www.nokogiri.org/tutorials/searching_a_xml_html_document.html) and [Parsing HTML with Nokogiri](http://ruby.bastardsbook.com/chapters/html-parsing/) to get a feel for how it works.

Try these commands to see the ways you can get data using Nokogiri (check out this [tutorial on css selectors](http://css.maxdesign.com.au/selectutorial/) if you need a refresher).

```ruby
doc.search('.subtext > span:first-child').map { |span| span.inner_text}

doc.search('.subtext > a:nth-child(3)').map {|link| link['href'] }

doc.search('.title > a:first-child').map { |link| link.inner_text}

doc.search('.title > a:first-child').map { |link| link['href']}

doc.search('.comment > font:first-child').map { |font| font.inner_text}
```

What is the data structure?  Can you call ruby methods on the returned data structure?

**Choose at least one other comment-related data (other than subtext, title, and comment). Figure out your own Nokogiri call to pull in the data.**

###Part 2: Scraping a live web page 

We're ready to scrape a live webpage directly without having to save it first as an HTML file. We're going to use Ruby's [OpenURI](http://www.ruby-doc.org/stdlib-1.9.3/libdoc/open-uri/rdoc/OpenURI.html) module to help us out. By requiring `'open-uri'` at the top of your Ruby program, you can use open with a URL. For example:

```ruby
require 'open-uri'

html_file = open('http://www.ruby-doc.org/stdlib-1.9.3/libdoc/open-uri/rdoc/OpenURI.html')
puts html_file.read
```

The `html_file` is a `StringIO` object which NokoGiri accepts as an argument to `NokoGiri::HTML`.

**Choose a webpage and write a method that accepts a url as an argument and prints out information about that page.** Try to choose a page other than Hacker News. This means that once you choose a url, you should spend some time looking at the HTML source to understand what CSS selectors to use to scrape the site. You'll find that some sites have more organized HTML than others, so your mileage may vary! 

###Part 3: Modeling Data With Classes

Scraping websites is a powerful tool to grab massive amounts of data, but it quickly gets out of hand if you don't have a way to organize that data. When you use Ruby, the best way to organize your data is to use classes. In the Hacker News example, we were scraping information about posts and comments. Instead of simply printing out the data, we can create a Post class and Comment class and save the data into Post and Comment objects.

Keeping with this example, a `Post` class could have the following attributes: `title`, `url`, `points`, and `item_id`. A `Post` class could have the following methods:

1. `Post#comments` returns all the comments associated with a particular post
2. `Post#add_comment` takes a `Comment` object as its input and adds it to the comment list.

**Your job is to define classes and create objects to represent the data that you scraped from your website.** You can choose one of the following:

1. Scrape data from a live Hacker News page *(easier)*
  * Create a `Post` class and a `Comment` class to represent the data.
  * Create a new `Post` object using the scraped information.
  * Create a new `Comment` object for each comment on the page and add it to the `Post` object.
2. Scrape data from a live page of your choice *(harder)*
  * Create classes to represent the data. You'll have to think about what works best for that specific site.
  * Create the appropriate objects based on the scraped information.


##Resources
* [Nokogiri documentation about parsing an HTML document](http://nokogiri.org/tutorials/parsing_an_html_xml_document.html)
* [Parsing HTML with Nokogiri](http://ruby.bastardsbook.com/chapters/html-parsing/)
* [CSS selectors](http://css.maxdesign.com.au/selectutorial/)
* [Command-line arguments in Ruby](http://alvinalexander.com/blog/post/ruby/how-read-* command-line-arguments-args-script-program)
* [OpenURI](http://www.ruby-doc.org/stdlib-1.9.3/libdoc/open-uri/rdoc/OpenURI.html)
