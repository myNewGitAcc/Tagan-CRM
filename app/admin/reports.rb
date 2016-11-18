ActiveAdmin.register_page "Reports" do
  menu parent: "Transactions"

  content do

    within @head do
      script :src => javascript_path('https://code.highcharts.com/highcharts.js'), :type => "text/javascript"
      script :src => javascript_path('https://code.highcharts.com/modules/exporting.js'), :type => "text/javascript"
    end

    render partial: 'chart'
    render partial: 'table'
  end

  sidebar :settings do
    render partial: 'sidebar'
  end

  controller do
    def index
      @internal_accounts = InternalAccount.all
      @result_month = []
      @result_amount = []

      if params['q'].present?
        date_range = search_by_date(params['q']["created_at_gteq"], params['q']["created_at_lteq"])
        account_id = params['q']['internal_account_id']
        unit = params['q']['unit']
      else
        unit = 'day'
      end

      balance = date_range_craft(date_range, unit, account_id)
      balance.each_key do |key|
        @result_month << key.strftime("%a, %d %b %Y")
        @result_amount << balance[key]
      end
    end

    def total_amount_by_periods_between_date(period='day', account_id=nil, date_range=DateTime.now-1.month..DateTime.now)
      @transactions = search_transactions(account_id, date_range)
      debits = @transactions.transaction_by_type('Debit', period)
      credits = @transactions.transaction_by_type('Credit', period)
      result = (debits+credits).group_by(&:period)
      result.update(result){|k,v| balance_for_period(v).round(2)}
    end

    def balance_for_period(trs)
      result = (trs[1].total rescue 0) - (trs[0].total rescue 0)
      result = result*(-1) unless trs[0].type == 'Debit'
      result
    end

    def search_by_date(from,to)
      if from.present? || to.present?
        if from.present? && to.blank?
          from..DateTime.now
        elsif from.blank? && to.present?
          DateTime.now.at_beginning_of_year..to
        else
          from..to
        end
      end
    end

    def date_range_craft(date_range, unit, account_id)
      if date_range.present?
        total_amount_by_periods_between_date(unit,account_id,date_range)
      else
        total_amount_by_periods_between_date(unit, account_id)
      end
    end

    def search_transactions account_id, date_range
      if account_id.present?
        Transaction.active_account.where(created_at: date_range, internal_account_id: account_id)
      else
        Transaction.active_account.where(created_at: date_range)
      end
    end

  end
end