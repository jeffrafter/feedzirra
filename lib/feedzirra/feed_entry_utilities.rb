require 'digest/md5'

module Feedzirra
  module FeedEntryUtilities
    module Sanitize
      def sanitize!
        self.replace(sanitize) unless self.nil?
      end
      
      def sanitize
        Dryopteris.sanitize(self)
      end
    end

    attr_reader :published
    
    def parse_datetime(string)
      DateTime.parse(string).feed_utils_to_gm_time
    end
    
    def published=(val)
      @published = parse_datetime(val)
    end
    
    def content
      @content.extend(Sanitize)
    end
    
    def title
      @title.extend(Sanitize)
    end
    
    def author
      @author.extend(Sanitize)
    end
    
    def summary
      @summary.extend(Sanitize)
    end
    
    def sanitize!
      self.title.sanitize!
      self.author.sanitize!
      self.content.sanitize!
      self.summary.sanitize!
    end
    
    def checksum
      Digest::MD5.hexdigest("#{title}--#{url}--#{summary}--#{content}")
    end    

    alias_method :last_modified, :published
  end
end
