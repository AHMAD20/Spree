module Spree::BaseHelper
    
    def logo(image_path = Spree::Config[:logo], img_options: {})
        link_to image_tag(image_path, img_options), spree.root_path
    end

    def taxon_breadcrumbs(taxon, separator = '/', breadcrumb_class = 'breadcrumbs-main clearfix')
        return '' if current_page?('/') || taxon.nil?
  
        crumbs = [[t('spree.home'), spree.root_path]]
  
        crumbs << [t('spree.products'), products_path]
        if taxon
          crumbs += taxon.ancestors.collect { |a| [a.name, spree.nested_taxons_path(a.permalink)] } unless taxon.ancestors.empty?
          crumbs << [taxon.name, spree.nested_taxons_path(taxon.permalink)]
        end
  
        separator = raw(separator)
  
        items = crumbs.each_with_index.collect do |crumb, i|
          content_tag(:li, itemprop: 'itemListElement', itemscope: '') do
            link_to(crumb.last, itemprop: 'item') do
              content_tag(:span, crumb.first, itemprop: 'name') + tag('meta', { itemprop: 'position', content: (i + 1).to_s }, false, false)
            end + (crumb == crumbs.last ? '' : separator)
          end
        end
  
        content_tag(:div, content_tag(:ul, raw(items.map(&:mb_chars).join)),class: breadcrumb_class)
    end
      
    def taxons_tree(root_taxon, current_taxon, max_level = 1,sub_category = 0)
      return '' if max_level < 1 || root_taxon.children.empty?
        if sub_category == 0
          root_taxon.children.map do |taxon|
            if taxon.children.empty?
              css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'active' : nil
              content_tag :li, class: css_class do
                link_to(taxon.name, seo_url(taxon), method: :get) +
                taxons_tree(taxon, current_taxon, max_level,0)
              end
            else
              css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'active' : nil
              content_tag :li, class: css_class do
                link_to(taxon.name, seo_url(taxon), method: :get) +
                taxons_tree(taxon, current_taxon, max_level,sub_category + 1)
              end
            end
          end.join("\n").html_safe
        else
              content_tag :div, class: 'side-sub-menu' do
                content_tag :ul, class: 'clearfix' do
                  content_tag :li, class: 'col-md-12' do
                    content_tag :div, class: 'row' do
                      content_tag :ul, class: 'clearfix col-md-12' do
                        root_taxon.children.map do |taxon|
                          css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'active' : nil
                          content_tag :li do
                            link_to(taxon.name, seo_url(taxon), method: :get) +
                            taxons_tree(taxon, current_taxon, max_level,sub_category + 1)
                          end
                        end.join("\n").html_safe
                      end
                    end
                  end
                end
              end
        end
    end

    def index_page?
      return true if current_page?('/')
    end

end