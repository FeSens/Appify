module Notifier
  class Discord < ApplicationUseCase
    attr_accessor :client
    WEBHOOK_URL = 'https://discord.com/api/webhooks/854916109937410049/LMyjMICTVQAizY2fj4zmlopAMOVx-PtiMxtkQjeHdR9G0M31OJlck4e7Ni4_3l7invmg'.freeze
  
    def initialize
      @client = Discordrb::Webhooks::Client.new(url: WEBHOOK_URL)
    end

    def call
      call!
    rescue Exception => e
      Rollbar.error(e)
    end
  end
end
