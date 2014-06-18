require 'rails_helper'

feature "user views a TV show's details", %Q{
  As a site visitor
  I want to view the details for a TV show
  So I can find learn more about it
  I can see a the show's title, network, the years it ran, and a synopsis.

} do

  # Acceptance Criteria:
  # * I can see a the show's title, network, the years it ran,
  # and a synopsis.

  scenario "user views a TV show's details" do
    show = TelevisionShow.create(title: 'Game of Thrones',
      network: 'HBO' )

    visit "/television_shows/#{show.id}"

    expect(page).to have_content show.title
    expect(page).to have_content show.network
    expect(page).to have_content show.years
    expect(page).to have_content show.synopsis
  end

#   Acceptance Criteria:
# * I can see a the show's title, network, the years it ran, and a synopsis
# * For each character, I can see the character's name, actor's name, and the character's

  scenario "user sees character details related to show" do
    show = TelevisionShow.create(title: 'The Wire',
      network: 'HBO' )

    characters = []

    char_attrs = [
      { name: 'Omar', actor: 'Michael K Williams', description: 'Omar coming!',
       television_show_id: "#{show.id}"},
       {name: 'Stringer Bell', actor: 'Idris Elba', description: 'Entreprenuer',
        television_show_id: "#{show.id}"}
      ]

    char_attrs.each do |attrs|
      characters << Character.create(attrs)
    end

   visit "/television_shows/#{show.id}"
   characters.each do |char|
      expect(page).to have_content char.name
      expect(page).to have_content char.actor
      expect(page).to have_content char.description
    end
  end
end
