# encoding: utf-8
require 'nokogiri'

module DB
  class Subs_builder
    def schema
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.root {
          xml.subs {
            xml.sub {
              xml.email
            }
          }
        }
      end
    end
  end
end