require 'bundler/setup'
require 'hanami/setup'
require 'hanami/model'
require_relative '../lib/hanami_web_app'
require_relative '../apps/web/application'

Hanami.configure do
  mount Web::Application, at: '/'

  model do
    ##
    # Database adapter
    #
    # Available options:
    #
    #  * SQL adapter
    #    adapter :sql, 'sqlite://db/hanami_web_app_development.sqlite3'
    #    adapter :sql, 'postgres://localhost/hanami_web_app_development'
    #    adapter :sql, 'mysql://localhost/hanami_web_app_development'
    #
    adapter :sql, ENV['DATABASE_URL']

    ##
    # Migrations
    #
    migrations 'db/migrations'
    schema     'db/schema.sql'
  end

  mailer do
    root 'lib/hanami_web_app/mailers'

    # See http://hanamirb.org/guides/mailers/delivery
    delivery do
      development :test
      test        :test
      # production :smtp, address: ENV['SMTP_PORT'], port: 1025
    end
  end
end
