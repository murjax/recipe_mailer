require 'rails_helper'

describe RecipeGenerator do
  describe '#generate' do
    let(:title) { 'Apple Elixir Recipe' }
    let(:ingredient_lines) { ['4 cups fresh apple cider', '2 cinnamon sticks'] }
    let(:response) do
      {
        hits: [{
          recipe: {
            label: title,
            ingredientLines: ingredient_lines
          }
        }]
      }.deep_stringify_keys
    end

    it 'returns recipe' do
      expect(HTTParty).to receive('get').and_return(response)
      recipe = described_class.new.generate
      expect(recipe).to eq(title: title, ingredients: ingredient_lines)
    end
  end

  describe '#random_query' do
    subject { described_class.new.random_query(type) }

    context 'breakfast' do
      let(:type) { :breakfast }

      it 'is combination of fruit and grain' do
        fruit, grain = subject.split(' ')
        expect(described_class::FRUIT).to include(fruit)
        expect(described_class::GRAIN).to include(grain)
      end
    end

    context 'lunch' do
      let(:type) { :lunch }

      it 'is combination of meat and grain' do
        meat, grain = subject.split(' ')
        expect(described_class::MEATS).to include(meat)
        expect(described_class::GRAIN).to include(grain)
      end
    end

    context 'dinner' do
      let(:type) { :dinner }

      it 'is combination of meat and vegetable' do
        meat, vegetable = subject.split(' ')
        expect(described_class::MEATS).to include(meat)
        expect(described_class::VEGETABLES).to include(vegetable)
      end
    end
  end
end
