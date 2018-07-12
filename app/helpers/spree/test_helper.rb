module Spree::TestHelper

    def taxons_tree(root_taxon, current_taxon, max_level = 1)
        return '' if max_level < 1 || root_taxon.children.empty?
        content_tag :ul, id: 'category-menu' do
        taxons = root_taxon.children.map do |taxon|
            if taxon.children.empty?
            css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'active' : nil
            content_tag :li, class: css_class do
            link_to(taxon.name, seo_url(taxon), method: :get) +
                taxons_tree(taxon, current_taxon, max_level)
            end
            else
            css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'active' : nil
            content_tag :li, class: css_class do
                link_to(taxon.name) do
                content_tag :ul, id: 'category-menu' do
                    taxons2 = taxon.children.map do |taxon2|
                    css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon2)) ? 'active' : nil
                    content_tag :li, class: css_class do
                    link_to(taxon2.name, seo_url(taxon), method: :get) +
                        taxons_tree(taxon2, current_taxon, max_level)
                    end
                    end
                    safe_join(taxons2, "\n")
                end
                end
            end
            end
        end
        safe_join(taxons, "\n")
        end
    end

    def taxons_tree2(root_taxon, current_taxon, max_level = 1)
        return '' if max_level < 1 || root_taxon.children.empty?
        content_tag :ul, id: 'category-menu' do
          taxons = root_taxon.children.map do |taxon|
            if taxon.children.empty?
              css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'active' : nil
              content_tag :li, class: css_class do
              link_to(taxon.name, seo_url(taxon), method: :get) +
                taxons_tree(taxon, current_taxon, max_level)
              end
            else
              css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'active' : nil
              #content_tag :li, class: css_class do
                link_to(taxon.name) do
                  content_tag :div, class: 'side-sub-menu' do
                    content_tag :ul, class: 'clearfix' do
                      content_tag :li, class: 'col-md-12' do
                        content_tag :div, class: 'row' do
                          content_tag :ul, class: 'clearfix col-md-12' do
                            taxons2 = taxon.children.map do |taxon2|
                              #css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon2)) ? 'active' : nil
                              content_tag :li do
                              link_to(taxon2.name, seo_url(taxon2), method: :get)
                                #taxons_tree(taxon2, current_taxon, max_level)
                              end
                            end
                            safe_join(taxons2, "\n")
                          end
                        end
                      end
                    end
                  end
                end
              #end
            end
          end
          safe_join(taxons, "\n")
        end
    end

    def taxons_tree_without_recursion(root_taxon, current_taxon, max_level = 1)
      return '' if max_level < 1 || root_taxon.children.empty?
        taxons = root_taxon.children.map do |taxon|
          check = 1
          if taxon.children.empty?
            css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'active' : nil
            content_tag :li, class: css_class do
            link_to(taxon.name, seo_url(taxon), method: :get) +
              taxons_tree(taxon, current_taxon, max_level)
            end
          else
            css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'active' : nil
            content_tag :li, class: css_class do
              link_to(taxon.name, seo_url(taxon), method: :get)
            end
            css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'active' : nil
            content_tag :li do
              val = link_to(taxon.name, seo_url(taxon), method: :get)
              safe_join(val, "\n")
              content_tag :div, class: 'side-sub-menu' do
                content_tag :ul, class: 'clearfix' do
                  content_tag :li, class: 'col-md-12' do
                    content_tag :div, class: 'row' do
                      content_tag :ul, class: 'clearfix col-md-12' do
                        taxons2 = taxon.children.map do |taxon2|
                          #css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon2)) ? 'active' : nil
                          content_tag :li do
                            #if check == 1
                          link_to(taxon2.name, seo_url(taxon2), method: :get)
                            #taxons_tree(taxon2, current_taxon, max_level)
                          end
                        end
                        safe_join(taxons2, "\n")
                      end
                    end
                  end
                end
              end
            end
          end
        end
        safe_join(taxons, "\n")
    end

    def taxons_tree_with_recursion(root_taxon, current_taxon, max_level = 1,sub_category = 0)
      return '' if max_level < 1 || root_taxon.children.empty?
        taxons = root_taxon.children.map do |taxon|
          if sub_category == 0
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
                taxons_tree(taxon, current_taxon, max_level,1)
              end
            end
          else
              content_tag :div, class: 'side-sub-menu' do
                content_tag :ul, class: 'clearfix' do
                  content_tag :li, class: 'col-md-12' do
                    content_tag :div, class: 'row' do
                      content_tag :ul, class: 'clearfix col-md-12' do
                        #taxons2 = taxon.children.map do |taxon2|
                          #css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon2)) ? 'active' : nil
                          content_tag :li do
                            #if check == 1
                            link_to(taxon.name, seo_url(taxon), method: :get) +
                            taxons_tree(taxon, current_taxon, max_level,1)
                            #break
                          end
                        #end
                        #taxons = taxons2
                        #safe_join(taxons2, "\n")
                      end
                    end
                  end
                end
              end
          end
        end
        safe_join(taxons, "\n")
    end

    def taxons_tree_net_solution(root_taxon, current_taxon, max_level = 1, current_level = 1)
      return '' if max_level < 1 || root_taxon.children.empty?
      if current_level == 1
        content_tag :ul, class: 'widget-shadow', id: 'left-nav' do
          root_taxon.children.map do |taxon|
            css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'active' : nil
            content_tag :li, class: css_class do
              link_to(taxon.name, seo_url(taxon), "class" => css_class,method: :get) +
              if current_taxon && current_taxon.self_and_ancestors.include?(taxon)
                taxons_tree(taxon, current_taxon, max_level - 1, current_level + 1)
              end
            end
          end.join("\n").html_safe
        end
      else
        content_tag :ul do
          root_taxon.children.map do |taxon|
            css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'active' : nil
            content_tag :li, class: css_class do
              link_to(taxon.name, seo_url(taxon), "class" => css_class,method: :get) +
              if current_taxon && current_taxon.self_and_ancestors.include?(taxon)
                taxons_tree(taxon, current_taxon, max_level - 1, current_level + 1)
              end
            end
          end.join("\n").html_safe
        end
      end
    end

end