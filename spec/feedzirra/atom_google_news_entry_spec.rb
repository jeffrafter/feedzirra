require File.dirname(__FILE__) + '/../spec_helper'

describe Feedzirra::AtomEntry do
  before(:each) do
    # I don't really like doing it this way because these unit test should only rely on AtomEntry,
    # but this is actually how it should work. You would never just pass entry xml straight to the AtomEnry
    @entry = Feedzirra::Feed.parse(sample_google_news_atom_feed).entries.first
  end

  it "should parse the timestamp" do
    @entry.published.should == Time.parse('Fri Feb 20 04:06:56 UTC 2009')
  end
end
