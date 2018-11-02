class PartySearchResult
  def initialize(zip_code)
    @zip_code = zip_code
  end

  def parties
    @parties ||= (Party.where('date >= ?', Date.today).near(@zip_code, 15)).to_a

    exact_zip = (Party.where('zip_code = ? AND date >= ?', @zip_code, Date.today)).to_a
    exact_zip.each do |party|
      @parties << party
    end

    @parties.uniq
  end
end
