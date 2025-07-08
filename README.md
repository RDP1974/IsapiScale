# IsapiScale
a pair of hints to make Delphi isapi web app scalable and reliable<br>
<br>
of course Delphi has the safe mem of Rust, the OOP quicker and elegant than C++ thanks to an optimized VMT, faster execution time due to smaller pe exe size that fit into L1 cpu cache<br>
<br>
so for newbies there it is a sample to make Windows Server isapi applications flying<br>
<br>
1. using a scalable allocator (see mine repositories)<br>
2. set keep-alive<br> 
3. set max connections higher<br>
4. don't use a single firedac chain on the datamodule, because these components are not thread safe and should be used with locks, so:<br>
5. manage easy threadvar for database objects<br>
6. use database pooling<br>
7. let me suggest a fastest json parser https://github.com/ahausladen/JsonDataObjects and use type casting instead of variants*:<br>
no jealousy towards techempower's c++ frameworks 🙂<br>
<br>
a test with D12.3 and a old cpu within WS 2025, push the number of messages with sql query from 750 to 4700 for sec (MySQL 8.4.5** LTS)<br>
(ab -n 1000 -c 100 -k http://address/isapi/isapiscale.dll/scale)<br>
Document Path:          /isapi/isapiscale.dll/scale<br>
Document Length:        2425 bytes<br>
Concurrency Level:      100<br>
Time taken for tests:   0.212 seconds<br>
Complete requests:      1000<br>
Failed requests:        0<br>
Keep-Alive requests:    1000<br>
Total transferred:      2595000 bytes<br>
HTML transferred:       2425000 bytes<br>
Requests per second:    4715.27 [#/sec] (mean)<br>
Time per request:       21.208 [ms] (mean)<br>
Time per request:       0.212 [ms] (mean, across all concurrent requests)<br>
Transfer rate:          11949.34 [Kbytes/sec] received<br>
<br>
this should increment linearly among all the cpu cores<br>
<br>
* cast the type eg. Obj.S['one'] := 'thisisastring' Obj.I['two'] := 2<br>
** as client libs use libmysql.dll, libssl-3-x64.dll, libcrypto-3-x64.dll
<br>
<br>
let me know opinions or errors, kind regards<br>
rdp@dellapasqua.com<br>
Roberto

