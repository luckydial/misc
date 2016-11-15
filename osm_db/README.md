## DB構築方法
0. .sqlファイルを実行してスキーマを作る
0. 下記のコマンドを実行
  0. ``` osmosis --read-pbf-fast file=Tokyo.osm.pbf --write-apidb dbType="mysql" host="localhost" validateSchemaVersion=no database="api06_test" user="root" password="hoge"```
  
## テストデータ（Tokyo.osm.pbf）について
下記のデータをとりま利用。

http://download.bbbike.org/osm/bbbike/Tokyo/
