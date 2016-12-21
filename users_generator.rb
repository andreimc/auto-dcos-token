require 'capybara/poltergeist'
require 'capybara'

class UsersGenerator

  attr_reader :url, :user, :pass, :session, :accounts

  def initialize(url: , user:, pass:, accounts: nil, debug: false)
    @url = url
    @user = user
    @pass = pass
    @accounts = accounts
    if (debug)
      require 'selenium-webdriver'
      Capybara.register_driver :chrome do |app|
        Capybara::Selenium::Driver.new(app, :browser => :chrome)
      end

      Capybara.javascript_driver = :chrome
      @session = Capybara::Session.new(:chrome)
    else
      Capybara.javascript_driver = :poltergeist
      @session = Capybara::Session.new(:poltergeist)
    end
  end

  def get_token
    session.visit "#{url}/login?redirect_uri=urn:ietf:wg:oauth:2.0:oob"

    do_login

    token = session.find('.snippet-wrapper').text

    puts token
  end

  def create_users
    session.visit url

    sleep 5

    frame = session.find('iframe#oauth-iframe')

    session.driver.browser.switch_to.frame(frame.native)
    do_login

    sleep 5

    session.visit "#{url}/#/system/organization/users/"

    sleep 5

    puts session.text
    accounts.split(',').each do |account|
      session.find('a', text: 'New User').click

      email = session.find('input[name=uid]')
      email.set(account)
      session.find('button', text: 'Add User').click

      sleep 1
    end
  end

  private

  def do_login
    puts 'do login'
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
  end
end
