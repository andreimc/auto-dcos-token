require 'capybara/poltergeist'
require 'capybara'

class TokenGenerator

  attr_reader :url, :user, :pass, :session

  def initialize(url: , user:, pass:)
    @url = url
    @user = user
    @pass = pass
    Capybara.javascript_driver = :poltergeist
    @session = Capybara::Session.new(:poltergeist)
  end

  def configure_ha
    session.visit url

    new_window = session.window_opened_by {
      begin
        session.find('span', text: 'Sign in with Google').click
      rescue Exception => e
        puts e
      end
    }
    session.within_window new_window do
      email = session.find('#Email')
      email.set(user)

      session.find('#next').click

      pass_input = session.find('#Passwd')
      pass_input.set(pass)

      session.find('#signIn').click
    end

    token = session.find('.snippet-wrapper').text

    puts token
  end
end
