function getData_StatsData(tableTitle,tableData){

  //nodeにテーブル行を追加していく。
  for(let value of map_col_item.values()){
      let tHead = document.createElement("th");
          tHead.appendChild(document.createTextNode(value));
          tableTitle.appendChild(tHead);
  }

  for(let key of map_row_time.keys()){
      let tRow = tableData.insertRow( -1 );
          tRow.classList.add("text-right");

      let tHead = document.createElement("th");
          tHead.classList.add("text-left");

      tRow.appendChild(tHead).appendChild(document.createTextNode(map_row_time.get(key)));
  }                



      },false);

      xhr.addEventListener('loadend',function(){
          show_result_xhr.textContent = "";
      },false);

      xhr.addEventListener('error',function(){
          show_result_xhr.textContent = 'サーバーエラーが発生しました。';
      },false);

      xhr.open('GET',reqUrl_StatsData_json,true);
      xhr.send(null);

  });        

}