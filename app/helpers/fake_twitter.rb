class FakeTwitter
  def self.search(term)
    p "Faking search #{term}"
    [term]
  end

  def self.update(update)
    p "Faking update #{update}"
  end
end