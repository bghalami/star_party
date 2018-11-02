require "rails_helper"

feature 'As an guest user' do
  context 'I can visit a party show' do
    scenario 'and view party details' do
      VCR.use_cassette("create standard party") do
        @fun_party = create(:party)
      end

      VCR.use_cassette("visit party not logged in") do
        visit "/parties/#{@fun_party.id}"
      end

      expect(page).to have_content(@fun_party.title)
      expect(page).to have_content("Date: Aug. 7, 2099")
      expect(page).to have_content("Time: 10:54 AM")
      expect(page).to have_content(@fun_party.description)
      expect(page).to have_content("Please log in to view party details and to rsvp.")
      expect(page).to_not have_content("Hosted By: #{@fun_party.host.name}")
      within(".party-show-card") do
        expect(page).to_not have_content("Attend")
      end
    end
  end
end
