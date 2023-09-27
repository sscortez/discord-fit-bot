# frozen_string_literal: true

module GuildMonthlyChallenges
  class AddServerGoal
    def initialize(guild_id, month_year, target_num)
      @guild_id = guild_id
      @month_year = month_year
      @target_num = target_num
    end

    def call
      create_new_monthly_goal!(@guild_id, @month_year, @target_num)
    end

    def create_new_monthly_goal!(guild_id, month_year, target_num)
      monthly_goal_exists?(guild_id, month_year, target_num) || create_monthly_goal!(guild_id, month_year, target_num)
    end

    def monthly_goal_exists?(guild_id, month_year, target_num)
      GuildMonthlyChallenge.find_by(
        guild_id: guild_id,
        month_year: month_year,
        target_exercises: target_num
      )
    end

    def create_monthly_goal!(guild_id, month_year, target_num)
      binding.pry
      GuildMonthlyChallenge.create!(
        guild_id: guild_id,
        month_year: month_year,
        target_exercises: target_num,
        active: true
      )
    end
  end
end
