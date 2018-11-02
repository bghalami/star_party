require 'rails_helper'

describe 'visitor searches for parties' do
  context 'with a valid zip code' do
    it 'returns all parties' do
      VCR.use_cassette("create 5 parties3") do
        create_list(:party, 5)
      end

      VCR.use_cassette("visit root") do
        visit '/'
      end

      fill_in :q_find, with: 80203
      VCR.use_cassette("click find to find") do
        find(".find", visible: false).click
      end

      expect(current_path).to eq("/party_search")
      expect(page).to have_css(".party-card", count: 5)

      within(first(".party-card")) do
        expect(page).to have_css(".party-title")
        expect(page).to have_css(".date")
        expect(page).to have_css(".description")
        expect(page).to have_css(".location")
      end
    end

    it 'does not return past parties' do
      host = create(:user)

      VCR.use_cassette("create past, present, future party") do
        @today_party = create(:party, title: "Today Party", date: Date.today)
        @future_party = create(:party, title: "Future Party", date: "11-11-2018")
        @past_party = create(:party, title: "Past Party", date: "07-07-2017")
      end

      VCR.use_cassette("visit root") do
        visit '/'
      end

      fill_in :q_find, with: 80203
      VCR.use_cassette("find to not show past parties") do
        find(".find", visible: false).click
      end

      expect(page).to have_css(".party-card", count: 2)

      expect(page).to have_content(@today_party.title)
      expect(page).to have_content(@future_party.title)
      expect(page).to_not have_content(@past_party.title)
    end

    it 'does not return parties outside 15mi radius' do
      host = create(:user)

      VCR.use_cassette("create near and far parties2") do
        @near_party = create(:party, title: "Near Party")
        @far_party = create(:party,
                            title: "Far Party",
                            zip_code: 70119,
                            street_address: "980 Grant Street",
                            city: "New Orleans",
                            state: "LA"
                          )
      end

      VCR.use_cassette("visit root") do
        visit '/'
      end
      
      fill_in :q_find, with: 80203
      VCR.use_cassette("find to not show far parties") do
        find(".find", visible: false).click
      end

      expect(page).to have_css(".party-card", count: 1)

      expect(page).to have_content(@near_party.title)
      expect(page).to_not have_content(@far_party.title)
    end
  end

  context 'with zip code corresponding to zero parties' do
    it 'returns a message on index page' do
      VCR.use_cassette("create standard party") do
        create(:party)
      end

      VCR.use_cassette("visit root") do
        visit '/'
      end

      fill_in :q_find, with: 14624

      VCR.use_cassette("click another other find") do
        find(".find", visible: false).click
      end

      expect(current_path).to eq("/")
      expect(page).to_not have_css(".party")
      expect(page).to have_content("No parties found near 14624. Try another search!")
    end
  end
end
