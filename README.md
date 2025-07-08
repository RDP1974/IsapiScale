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
a test with D12.3 and a old cpu within WS 2025, push the number of messages with sql query from 750 to 5000 for sec (MySQL 8.4.5** LTS)<br>
(ab -n 10000 -c 1000 -k http://192.168.1.16/address/isapiscale.dll/scale) with 1000 concurrent users<br>
document path:          /isapi/isapiscale.dll/scale<br>
document length:        2425 bytes<br>
concurrency level:      1000<br>
time taken for tests:   1.968 seconds<br>
Complete requests:      10000<br>
failed requests:        0<br>
keep-alive requests:    10000<br>
total transferred:      25950000 bytes<br>
HTML transferred:       24250000 bytes<br>
requests per second:    5081.92 [#/sec] (mean)<br>
time per request:       196.776 [ms] (mean)<br>
time per request:       0.197 [ms] (mean, across all concurrent requests)<br>
transfer rate:          12878.49 [Kbytes/sec] received<br>
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

