# Copyright (c) 2009-2011 by Ewout Vonk. All rights reserved.

# prevent loading when called by Bundler, only load when called by capistrano
if caller.any? { |callstack_line| callstack_line =~ /^Capfile:/ }
  unless Capistrano::Configuration.respond_to?(:instance)
    abort "deprec-substitute-in-file requires Capistrano 2"
  end

  module Deprec
    module SubstituteInFile
      # allow string substitutions in files on the server
      def substitute_in_file(filename, old_value, new_value, sep_char='/')
        # XXX sort out single quotes in 'value' - they'l break command!
        run <<-END
        [ -e '#{filename}' ] && sudo sh -c "
        perl -p -i -e 's#{sep_char}#{old_value}#{sep_char}#{new_value}#{sep_char}' #{filename}
        " || true
        END
      end
  
      def comment_line(filename, line, sep_char='/')
        substitute_in_file(filename, '^(' + line + ')([\r\n]*)$', '#$1$2', sep_char)
      end

      def remove_line(filename, line, sep_char='/')
        substitute_in_file(filename, '^' + line + '[\r\n]*$', '', sep_char)
      end
    end
  end

  Capistrano::EXTENSIONS[:deprec2].send(:include, Deprec::SubstituteInFile)
end