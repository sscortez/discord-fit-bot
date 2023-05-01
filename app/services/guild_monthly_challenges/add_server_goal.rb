# frozen_string_literal: true

require 'discord_client'
require 'securerandom'

module GuildMonthlyChallenges
  def initialize(guild_id, month_year, target_no)
    @guild_id = guild_id
    @month_year = month_year
    @target_no = target_no
  end

  def call
    create_new_monthly_goal!()
  end

  def create_new_monthly_goal!(guild_id, month_year, target_no)
    goal = monthly_goal_exists?(guild_id, month_year) || create_monthly_goal!(guild_id, month_year)
  end

  def monthly_goal_exists?(guild_id, month_year)
    
  end
end
