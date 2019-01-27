class NozStatsController < ApplicationController
  
  def index
    get_data_gdp
    
  end

  def table
    get_data_gdp
    
  end

end


  #（メモ）e-statのAPIアドレスを作成するメソッド
  def get_api_url(stats_data_id)
    api_url = "https://api.e-stat.go.jp/rest/2.1/app/json/getStatsData"
    api_appid = "bb86c86ee575b3adfa4930ee0f17a74de14e57e6"
    stats_data_id = "0003109767"
    @req_url = api_url +"?appId=" + api_appid +"&statsDataId=" + stats_data_id
    puts @req_url
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
    
    # データの更新日時の取得
    update_date = data_all[:GET_STATS_DATA][:STATISTICAL_DATA][:TABLE_INF][:UPDATED_DATE]
    
    # date,categoryの取り出し
    data_classobjs = data_all[:GET_STATS_DATA][:STATISTICAL_DATA][:CLASS_INF][:CLASS_OBJ]
   
    # date,categoryごとのデータの取り出し
    data_datainfs = data_all[:GET_STATS_DATA][:STATISTICAL_DATA][:DATA_INF]


    db_catlists = CategoryList.all
    if db_catlists.count == 0
      db_catlists.create(category_code:stats_data_id, data_update_date:update_date)
    end
    
    db_sna = SystemOfNationalAccount.all
    if db_sna.count > 0
      data_classobjs.each do |obj|
        case obj[:@id] 
        when "time" then
          classobjs_time_class = obj[:CLASS]
          puts classobjs_time_class
          # db_sna.create date_code:obj[:CLASS][:@code], date_name:obj[:CLASS][:@name], period_time:"年度"
        when "cat01" then
          classobjs_cat_class = obj[:CLASS]
          # db_sna.create category_code:obj[:CLASS][:@code], category_name:obj[:CLASS][:@name]
        end
      end
    else
    
      
    end
      
    end
