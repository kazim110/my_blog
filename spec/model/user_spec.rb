require 'rails_helper'

RSpec.describe User, type: :model do
    subject { User.new(name: 'kazim', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Software Developer', posts_counter: 5)}
    before { subject.save }

    it 'is valid with valid attributes' do
        expect(subject).to be_valid
    end
    
    it 'Name should be present' do
        subject.name = nil
        expect(subject).to_not be_valid
    end
    
    it 'posts_counter should be integer and equal and greater than zero' do
        subject.posts_counter = -11
        expect(subject).to_not be_valid
    end
    
    it 'is valid with a positive integer posts_counter' do
        subject.posts_counter = 0
        expect(subject).to be_valid
    end
    
    it 'is not valid with a non-integer posts_counter' do
        subject.posts_counter = 3.5
        expect(subject).not_to be_valid
    end
    
    it 'is not valid with a string posts_counter' do
        subject.posts_counter = 'abc'
        expect(subject).not_to be_valid
    end
end
    