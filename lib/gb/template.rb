module Gb
  module Template
    class GistList
      def online(items)
        templete =<<-EOS
<% items.each do |item| %>
<%="#{item.id}"%> 
<% end %>
EOS
        ERB.new(template).result
      end

      def normal(items)
        template =<<-'EOS'
<%- items.each do |item| -%>
<%= "#{item.gist_id} #{item.description}"%>
<%- end -%>
EOS
        ERB.new(template,nil,'-').result(binding)
      end

      alias_method :default,:normal
    end
  end
end
