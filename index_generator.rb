### gem install erubis
require 'erubis'

class Article
  attr_accessor :title, :desc, :url, :date
end

## Get file names in directory
def each_article(dir, &block)
  return [] unless Dir.exist?(dir)
  Dir.chdir(dir)
  Dir.foreach(dir) { |entryName|
    isHtml = entryName.end_with?(".html") && File.file?(entryName)
    yield entryName if isHtml
  }
end

## Render template
def render(template_file, articles)
  template = IO.read(template_file)
  eruby = Erubis::Eruby.new(template)
  eruby.result(:articles => articles)
end

def read_article(file)
  article = Article.new
  article.url = "./#{file}"
  article.title = file.gsub(/\.html/, "")
  article.date = File.mtime(file).strftime("%Y-%m-%d")
  article
end

def read_articles(dir)
  articles = []
  each_article(dir) { |file|
    articles << read_article(file)
  }
  articles
end

# Generate index.html
File.open("index.html", "w") { |f|
  articles = read_articles("./")
  f.write(render("index.template", articles))
  puts "index.html generated"
}
