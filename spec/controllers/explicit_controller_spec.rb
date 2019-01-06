# frozen_string_literal: true

require 'rails_helper'
require 'json'
require 'selenium-webdriver'

RSpec.describe ExplicitController, type: :controller do
  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
  end

  it 'test with perfect numbers cuts' do
    @driver.get 'http://localhost:3000'
    @driver.find_element(:id, 'string').send_keys '25 36 5 6 '
    @driver.find_element(:id, 'formSubmit').click
    expect(@driver.find_element(:id, 'quantity').text).to eq('Total quantity is 1')
    expect(@driver.find_element(:id, 'len').text).to eq('Max length 2')
    #  expect(@driver.find_element(:tag_name, 'body')).to have_content('25 36')
  end
  it 'test without input' do
    @driver.get 'http://localhost:3000/explicit/in'
    @driver.find_element(:id, 'formSubmit').click
    expect(@driver.find_element(:id, 'quant').text).to eq('Not found our array')
  end

  it 'test without our number' do
    @driver.get 'http://localhost:3000'
    @driver.find_element(:id, 'string').send_keys '7 6 5 3 2'
    @driver.find_element(:id, 'formSubmit').click
    expect(@driver.find_element(:id, 'quant').text).to eq('Not found our array')
  end
end
