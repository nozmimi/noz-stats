class NozStatsController < ApplicationController
  
  def index
    get_data_gdp
  end

end


  #（メモ）e-statのAPIアドレスを作成するメソッド
  def get_api_url(stats_data_id)
    api_url = "https://api.e-stat.go.jp/rest/2.1/app/json/getStatsData"
    api_appid = "bb86c86ee575b3adfa4930ee0f17a74de14e57e6"
    stats_data_id = "0003109767"
    @req_url = api_url +"?appId=" + api_appid +"&statsDataId=" + stats_data_id  
  end

#以下、各統計のデータを呼び出すメソッド。
#統計毎にデータ構造が違うため、使用する統計毎にメソッドを作成することにしました。

  #（メモ）国民経済計算より（主にGDP）
  def get_data_gdp(stats_data_id = "0003109767")
    require 'net/http'
    require 'uri'
    require 'json'
    require 'pp'
    require 'date'
    
    # アクセスするURLを取得
    get_api_url(stats_data_id)

    # データの取得
    req_uri = URI.parse(@req_url)
    data_json = Net::HTTP.get(req_uri)
    data_all = JSON.parse(data_json, symbolize_names: true)
    
    # 条件指定に使う、データの更新日時の取得
    update_date = data_all[:GET_STATS_DATA][:STATISTICAL_DATA][:TABLE_INF][:UPDATED_DATE]
    
    db_catlist = CategoryList.all
    if db_catlist.count == 4
      db_catlist.create(category_code:stats_data_id, data_update_date:update_date)
    end
    
      # if data_update_date > db_data[0].updated_at or db_data.count == 0
      #   data_class_obj = data_all[:GET_STATS_DATA][:STATISTICAL_DATA][:CLASS_INF][:CLASS_OBJ]
        
      #   data_class_obj.each do |data|
      #     if data[:@id] == "time"
      #       data[:CLASS].each do |data_time|
      #           SystemOfNationalAccount.create(date_code:data_time[:@code], date_name:data_time[:@name], period_time:"年度")
      #       end
      #     end
      #   end      
      # else
      # end
    end
