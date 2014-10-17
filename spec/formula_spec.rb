require 'rspec'
require 'spec_helper'
require 'formula'

describe Formula do
  it 'Simple formula' do
    form = '#=Зборка!K95+Зборка!K96+Зборка!K97+Зборка!K98'
    hash = App::Formula.translate(form)
    expected = {
        'Vektor2&K'=> 1,
        'Vektor3&K'=> 1,
        'Vektor4&K'=> 1,
        'Vektor5&K'=> 1,
    }
    expect(hash).to eq(expected)
  end

  it 'Simple formula with parenthesis' do
    form = '#=(Зборка!K95+Зборка!K96+Зборка!K97+Зборка!K98)'
    hash = App::Formula.translate(form)
    expected = {
        'Vektor2&K'=> 1,
        'Vektor3&K'=> 1,
        'Vektor4&K'=> 1,
        'Vektor5&K'=> 1,
    }
    expect(hash).to eq(expected)
  end

  it 'Simple formula with factor' do
    form = '#=3*(Зборка!K95+Зборка!K96+Зборка!K97+Зборка!K98)'
    hash = App::Formula.translate(form)
    expected = {
        'Vektor2&K'=> 3,
        'Vektor3&K'=> 3,
        'Vektor4&K'=> 3,
        'Vektor5&K'=> 3,
    }
    expect(hash).to eq(expected)
  end

  it 'Nested simple formula' do
    form = '#=2*(Зборка!K95+2*Зборка!K96+Зборка!K97+Зборка!K98)'
    hash = App::Formula.translate(form)
    expected = {
        'Vektor2&K'=> 2,
        'Vektor3&K'=> 4,
        'Vektor4&K'=> 2,
        'Vektor5&K'=> 2,
    }
    expect(hash).to eq(expected)
  end

  it 'Nested simple formula with float' do
    form = '#=2*(Зборка!K95+2,5*Зборка!K96+Зборка!K97+Зборка!K98)'
    hash = App::Formula.translate(form)
    expected = {
        'Vektor2&K'=> 2,
        'Vektor3&K'=> 5,
        'Vektor4&K'=> 2,
        'Vektor5&K'=> 2,
    }
    expect(hash).to eq(expected)
  end

  it 'Nested formula with float' do
    form = '#=Зборка!K95+2*(2,5*(Зборка!K96+Зборка!K97)+Зборка!K97+Зборка!K98)'
    hash = App::Formula.translate(form)
    expected = {
        'Vektor2&K'=> 1,
        'Vektor3&K'=> 5,
        'Vektor4&K'=> 7,
        'Vektor5&K'=> 2,
    }
    expect(hash).to eq(expected)
  end

  it 'Recursive formula', focus: true do
    form = '#=Тепл!T10'
    hash = App::Formula.translate(form)
    expected = {
        'Vektor2&K'=> 1,
        'Vektor3&K'=> 5,
        'Vektor4&K'=> 7,
        'Vektor5&K'=> 2,
    }
    expect(hash).to eq(expected)
  end


end
