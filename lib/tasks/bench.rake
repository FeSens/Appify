require "benchmark"

namespace :performance do
  desc "This take does something useful!"

  task page_visits: :test do
    Benchmark.bm do |x|
      PageVisit.delete_all
      Push.delete_all
      sleep(10)
      x.report { make_visits(1e1) }
      x.report do
        g = PageVisit.group(:push_id, :path).having("sum(time_spent) > #{3 * 1e1}").pluck(:push_id)
        Push.find(g)
      end

      PageVisit.delete_all
      Push.delete_all
      x.report { make_visits(1e2) }
      x.report do
        g = PageVisit.group(:push_id, :path).having("sum(time_spent) > #{3 * 1e2}").pluck(:push_id)
        Push.find(g)
      end

      PageVisit.delete_all
      Push.delete_all
      x.report { make_visits(1e3) }
      x.report do
        g = PageVisit.group(:push_id, :path).having("sum(time_spent) > #{3 * 1e3}").pluck(:push_id)
        Push.find(g)
      end
    end
  end

  task page_visits_re: :test do
    Benchmark.bm do |x|
      x.report { make_visits(1e1) }
      x.report do
        g = PageVisit.group(:push_id, :path).having("sum(time_spent) > #{3 * 1e1}").pluck(:push_id)
        Push.find(g)
      end
    end
  end
end

def make_visits(n)
  (1..n).each { |_i|; Push.create; }
  Push.first(n).each { |push| for i in 1..n; push.page_visits.create(time_spent: rand(1..600), path: "/dsada/#{rand(1..10)}"); end }
end
