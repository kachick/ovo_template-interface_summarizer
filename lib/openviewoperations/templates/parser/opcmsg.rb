# Copyright (C) 2012  Kenichi Kamiya

require 'striuct'

module OpenViewOperations; class Templates; class Parser
  class OPCMSG < self
    Core = Striuct.define do
      valid_string = OR(nil, AND(String, NOT('')))
      member :severities, OR(nil, GENERICS(Symbol))
      alias_member :severity, :severities
      member :nodes, OR(nil, GENERICS(Node))
      alias_member :node, :nodes
      member :application, valid_string
      member :msggrp, valid_string
      member :object, valid_string
      member :text, valid_string
      member :text_options, OR(nil, Hash)
    end
    
    private
    
    def template_type
      :OPCMSG
    end
    
    def parse_severities
      if scan(/ +SEVERITY((?: [A-Z][a-z]+)+)\n/)
        @scanner[1].lstrip.split.map(&:to_sym)
      end
    end

    def parse_application
      parse_quoted :APPLICATION
    end
    
    def parse_msggrp
      parse_quoted :MSGGRP
    end

    def parse_object
      parse_quoted :OBJECT
    end

    def parse_text
      parse_mquoted :TEXT
    end
    
    def parse_text_options
      if parse_flag :ICASE
        {ICASE: true}
      end
    end
  end

  Interface = OPCMSG
end; end; end