FactoryBot.define do
    factory :landmark do
        name "Colosseum"
        description "The most important monument in Rome"
        latitude 41.890251
        longitude 12.492373
        association :city, factory: :city
    end
end