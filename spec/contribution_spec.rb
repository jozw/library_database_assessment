require 'rspec_helper'

describe Contribution do

  it 'is initialized with a name' do
    contribution = Contribution.new({'author_id' => 1, 'title_id' => 3})
    contribution.should be_instance_of Contribution
  end

  it 'lets you save multiple contributions to the database' do
    contribution = Contribution.new({'author_id' => 2, 'title_id' => 5})
    contribution.save
    contribution_two = Contribution.new({'author_id' => 2, 'title_id' => 9})
    contribution_two.save
    Contribution.all.should eq [contribution, contribution_two]
  end

  it 'treats contributions as equal if author id and title id match' do
    contribution = Contribution.new({'author_id' => 3, 'title_id' => 4})
    contribution_two = Contribution.new({'author_id' => 3, 'title_id' => 4})
    contribution.should eq contribution_two
  end

  it 'deletes specific contributions by id' do
    title = Title.new({'name' => 'Cookbook'})
    title.save
    author = Author.new({'name' => 'Jane'})
    author.save
    contribution = Contribution.new({'author_id' => author.id, 'title_id' => title.id})
    contribution.save
    title_two = Title.new({'name' => 'Favorite Tea'})
    title_two.save
    author_two = Author.new({'name' => 'Earl Grey'})
    author_two.save
    contribution_two = Contribution.new({'author_id' => author_two.id, 'title_id' => title_two.id})
    contribution_two.save
    Contribution.remove(contribution_two.id)
    Contribution.all.should eq [contribution]
  end
end
