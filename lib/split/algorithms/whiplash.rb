# A multi-armed bandit implementation inspired by 
# @aaronsw and victorykit/whiplash
require 'simple-random'

module Split
  module Algorithms
    module Whiplash
      def self.choose_alternative(experiment)
        experiment[best_guess(experiment.alternatives)]
      end

      private

      def self.arm_guess(participants, completions)
        a = [participants, 0].max
        b = [participants-completions, 0].max
        s = SimpleRandom.new; s.set_seed; s.beta(a+fairness_constant, b+fairness_constant)
      end

      def self.best_guess(alternatives)
        guesses = {}
        alternatives.each do |alternative|
          guesses[alternative.name] = arm_guess(alternative.participant_count, alternative.all_completed_count)
        end
        gmax = guesses.values.max
        best = guesses.keys.select {|name| guesses[name] ==  gmax }
        return best.sample
      end

      def self.fairness_constant
        7
      end
    end
  end
end
