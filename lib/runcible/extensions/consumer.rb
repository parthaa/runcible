# Copyright (c) 2012
#
# MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


module Runcible
  module Extensions
    class Consumer < Runcible::Resources::Consumer

      def self.bind_all(id, repo_id)
        # bind the consumer to all repositories with the given repo_id
        Runcible::Extensions::Repository.retrieve(repo_id)['distributors'].each do |d|
          self.bind(id, repo_id, d['id'])
        end
      end

      def self.unbind_all(id, repo_id)
        # unbind the consumer from all repositories with the given repo_id
        Runcible::Extensions::Repository.retrieve(repo_id)['distributors'].each do |d|
          self.unbind(id, repo_id, d['id'])
        end
      end

      def self.install(id, type_id, units)
        self.install_content(id, generate_content(type_id, units))
      end

      def self.update(id, type_id, units)
        self.update_content(id, generate_content(type_id, units))
      end

      def self.uninstall(id, type_id, units)
        self.uninstall_content(id, generate_content(type_id, units))
      end

      def self.generate_content(type_id, units)
        content = []
        units.each do |unit|
          content_unit = {}
          content_unit[:type_id] = type_id
          content_unit[:unit_key] = { :name => unit }
          content.push(content_unit)
        end
        content
      end
    end
  end
end
