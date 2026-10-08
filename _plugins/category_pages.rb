# frozen_string_literal: true

module Jekyll
  # Generates one archive page for every category found in post front matter.
  # URLs intentionally keep the original category name, e.g. /categories/詩/.
  class CategoryPage < Page
    def initialize(site, base, dir, category)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      process(@name)
      read_yaml(File.join(base, '_layouts'), 'category.html')

      data['title'] = "分类：#{category}"
      data['description'] = "#{category} 分类下的文章"
      data['category'] = category
      data['background'] = '/img/bg-post.png'
    end
  end

  class CategoryPageGenerator < Generator
    safe true
    priority :low

    def generate(site)
      site.categories.keys.each do |category|
        site.pages << CategoryPage.new(site, site.source, File.join('categories', category.to_s), category.to_s)
      end
    end
  end
end
