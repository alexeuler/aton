require 'rspec'
require 'spec_helper'
require 'formula'

describe Formula do
  it 'Simple formula' do
    form = '#=Зборка!O95+Зборка!O96+Зборка!O97+Зборка!O98'
    hash = App::Formula.translate(form)
    expected = {
        'Vektor2'=> 1,
        'Vektor3'=> 1,
        'Vektor4'=> 1,
        'Vektor5'=> 1,
    }
    expect(hash).to eq(expected)
  end

  it 'Simple formula with parenthesis' do
    form = '#=(Зборка!O95+Зборка!O96+Зборка!O97+Зборка!O98)'
    hash = App::Formula.translate(form)
    expected = {
        'Vektor2'=> 1,
        'Vektor3'=> 1,
        'Vektor4'=> 1,
        'Vektor5'=> 1,
    }
    expect(hash).to eq(expected)
  end

  it 'Simple formula with factor' do
    form = '#=3*(Зборка!O95+Зборка!O96+Зборка!O97+Зборка!O98)'
    hash = App::Formula.translate(form)
    expected = {
        'Vektor2'=> 3,
        'Vektor3'=> 3,
        'Vektor4'=> 3,
        'Vektor5'=> 3,
    }
    expect(hash).to eq(expected)
  end

  it 'Nested simple formula' do
    form = '#=2*(Зборка!O95+2*Зборка!O96+Зборка!O97+Зборка!O98)'
    hash = App::Formula.translate(form)
    expected = {
        'Vektor2'=> 2,
        'Vektor3'=> 4,
        'Vektor4'=> 2,
        'Vektor5'=> 2,
    }
    expect(hash).to eq(expected)
  end

  it 'Nested simple formula with float' do
    form = '#=2*(Зборка!O95+2,5*Зборка!O96+Зборка!O97+Зборка!O98)'
    hash = App::Formula.translate(form)
    expected = {
        'Vektor2'=> 2,
        'Vektor3'=> 5,
        'Vektor4'=> 2,
        'Vektor5'=> 2,
    }
    expect(hash).to eq(expected)
  end

  it 'Nested formula with float' do
    form = '#=Зборка!O95+2*(2,5*(Зборка!O96+Зборка!O97)+Зборка!O97+Зборка!O98)'
    hash = App::Formula.translate(form)
    expected = {
        'Vektor2'=> 1,
        'Vektor3'=> 5,
        'Vektor4'=> 7,
        'Vektor5'=> 2,
    }
    expect(hash).to eq(expected)
  end



end
